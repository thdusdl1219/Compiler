#!/usr/bin/python

# This emulator was originally written by Hanhwi jang.

import re
import sys

class Inst:
    op = None
    r1 = None
    r2 = None
    r3 = None
    immed = None
    label = None
    
    def __init__ (self, text):
        re_instruction = re.compile(r"""
            ^
            (?P<op>\w+)                                 # Opcode
            (?:
                $ |                                     # No operand (e.g., syscall, nop)
                \s+(?P<label_1>[A-Za-z_]\w+)$ |         # One label operand (e.g., j, jal)
                \s+(?P<r1>\$\w+)                        # The first register operand
                (?:
                    $ |                                 # One register operand (e.g., jr)
                    ,\s+(?P<label_2>[A-Za-z_]\w+)$ |    # One register and one label operands (e.g., la, branchz)
                    ,\s+(?P<immed_1>-?\d+)              # An immediate operand
                    (?:
                        $ |                             # One register and one immediate operands (e.g., li)
                        \((?P<r2_1>\$\w+)\)$            # One register and one address operands (e.g., lw, sw)
                    ) |
                    ,\s+(?P<r2_2>\$\w+)                 # The second register operand
                    (?:
                        $ |                             # Two registers operand (e.g., Move)
                        ,\s+(?P<label_3>[A-Za-z_]\w+)$ |# Two registers and one label operands (e.g., branchu, branch)
                        ,\s+(?P<immed_2>-?\d+)$ |       # Two registers and one immediate operands (e.g., addi)
                        ,\s+(?P<r3>\$\w+)$              # Three registers operands (e.g., add)
                    )
                )
            )
        """, re.VERBOSE)
        m = re_instruction.match(text)
        if m is not None:
            self.op = m.group('op')
            self.r1 = m.group('r1')
            if m.group('r2_1') is not None:
              self.r2 = m.group('r2_1')
            else:
              self.r2 = m.group('r2_2')
            self.r3 = m.group('r3')
            if m.group('immed_1') is not None:
              self.immed = m.group('immed_1')
            else:
              self.immed = m.group('immed_2')
            if self.immed is not None:
              self.immed = int(self.immed)
            if m.group('label_1') is not None:
              self.label = m.group('label_1')
            elif m.group('label_2') is not None:
              self.label = m.group('label_2')
            else:
              self.label = m.group('label_3')
        else:
            print "ERROR [%s]" % text

    def _print(self):
        print self.op, self.r1, self.r2, self.r3, self.immed, self.label

class RF:
    archRegsName =  [ "$zero", "$at", "$v0", "$v1","$a0","$a1" ,"$a2", "$a3",
                      "$t0" ,"$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
                      "$s0", "$s1", "$s2", "$s3", "$s4", "$s5", "$s6", "$s7",
                      "$t8", "$t9", "$k0", "$k1", "$gp", "$sp", "$fp", "$ra"]
    archRegsMap = dict(zip(archRegsName, range(0, len(archRegsName))))
    tempRegsBase = len(archRegsName)

    archRegsVal = [None for x in xrange(0, len(archRegsName))]
    virtRegsStack = [{}]

    def getReg(self, reg_name):
        if reg_name in self.archRegsMap:
            return self.archRegsVal[self.archRegsMap[reg_name]]
        else:
            reg_index = int(reg_name[2:])
            if reg_index in self.virtRegsStack[-1]:
                return self.virtRegsStack[-1][reg_index]
            else:
                return None
    def setReg(self, reg_name, value):
        if reg_name in self.archRegsMap:
            if reg_name != "$zero":
                self.archRegsVal[self.archRegsMap[reg_name]] = value
        else:
            reg_index = int(reg_name[2:])
            self.virtRegsStack[-1][reg_index] = value
    def push(self):
        self.virtRegsStack.append({})
    def pop(self):
        del self.virtRegsStack[-1]

    def __init__ (self):
        self.archRegsVal[0] = 0
        self.setReg('$sp', 0xc0000000)
        self.setReg('$gp', 0x10008000)
        self.setReg('$ra', -1)
        return

class Machine:
    rf = RF()

    insts = []

    data = [] # heap
    static_data = {} # static data

    # Instruction Pointer
    ip = 0
    inst_label = {}
    text_base = 0
    data_base = 0
    static_base = 0x10000000

    def get_block_idx(self, addr):
        if addr < self.data_base:
            print addr
            raise exception 
        else:
            return (addr - self.data_base) / 4

    def syscall(self):
        if self.rf.getReg("$v0") == 9:
            # sbrk
            self.data_base = 0xFFFF0000
            size = (self.rf.getReg("$a0") + 3) / 4
            for i in xrange(0, size):
                self.data.append(0)
            self.rf.setReg("$v0", self.data_base)
        return

    def execute(self):
        # Arit2 case
        r = 0
        dst = None
        nextip = self.ip + 1
        inst = self.insts[self.ip]
        # print "IP", self.ip
        # inst._print()
        if inst.op == 'abs':
            r = abs(self.rf.getReg(inst.r2))
            dst = inst.r1
        elif inst.op == 'neg':
            r = -(self.rf.getReg(inst.r2))
            dst = inst.r1
        elif inst.op == 'not':
            r = ~(self.rf.getReg(inst.r2))
            dst = inst.r1
        elif inst.op == 'add':
        # Arith3 case
            r = (self.rf.getReg(inst.r2) + self.rf.getReg(inst.r3))
            dst = inst.r1
        elif inst.op == 'and':
            r = (self.rf.getReg(inst.r2) & self.rf.getReg(inst.r3))
            dst = inst.r1
        elif inst.op == 'mulo':
            r = (self.rf.getReg(inst.r2) * self.rf.getReg(inst.r3))
            dst = inst.r1
        elif inst.op == 'div':
            r = (self.rf.getReg(inst.r2) / self.rf.getReg(inst.r3))
            dst = inst.r1
        elif inst.op == 'or':
            r = (self.rf.getReg(inst.r2) | self.rf.getReg(inst.r3))
            dst = inst.r1
        elif inst.op == 'rem':
            r = (self.rf.getReg(inst.r2) % self.rf.getReg(inst.r3))
            dst = inst.r1
        elif inst.op == 'sub':
            r = (self.rf.getReg(inst.r2) - self.rf.getReg(inst.r3))
            dst = inst.r1
        elif inst.op == 'xor':
            r = (self.rf.getReg(inst.r2) ^ self.rf.getReg(inst.r3))
            dst = inst.r1
        elif inst.op == 'seq':
            r = (self.rf.getReg(inst.r2) == self.rf.getReg(inst.r3))
            dst = inst.r1
        elif inst.op == 'slt':
            r = (self.rf.getReg(inst.r2) < self.rf.getReg(inst.r3))
            dst = inst.r1
        # Arithi case
        elif inst.op == 'addi':
            r = (self.rf.getReg(inst.r2) + inst.immed)
            dst = inst.r1
        elif inst.op == 'andi':
            r = (self.rf.getReg(inst.r2) & inst.immed)
            dst = inst.r1
        elif inst.op == 'orii':
            r = (self.rf.getReg(inst.r2) | inst.immed)
            dst = inst.r1
        elif inst.op == 'xori':
            r = (self.rf.getReg(inst.r2) ^ inst.immed)
            dst = inst.r1
        # Li
        elif inst.op == 'li':
            r = inst.immed
            dst = inst.r1
        # La
        elif inst.op == 'la':
            try:
                r = self.inst_label[inst.label]
                r = r + self.text_base
            except:
                r = self.data_label[inst.label]
                r = r + self.data_base

            dst = inst.r1
        # Lw
        elif inst.op == 'lw':
            addr = self.rf.getReg(inst.r2) + inst.immed
            if addr >= self.static_base and addr < self.data_base:
                try:
                    r = self.static_data[addr]
                except:
                    r = 0
            else:
                r = self.data[self.get_block_idx(addr)]
            dst = inst.r1
        # Sw
        elif inst.op == 'sw':
            addr = self.rf.getReg(inst.r2) + inst.immed
            if addr >= self.static_base and addr < self.data_base:
                self.static_data[addr] = self.rf.getReg(inst.r1)
            else:
                self.data[self.get_block_idx(addr)] = self.rf.getReg(inst.r1)
            dst = None
        # Move
        elif inst.op == 'move':
            r = self.rf.getReg(inst.r2)
            dst = inst.r1
        # Branchz
        elif inst.op == 'bltz':
            if self.rf.getReg(inst.r1) < 0:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'beqz':
            if self.rf.getReg(inst.r1) == 0:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bnez':
            if self.rf.getReg(inst.r1) != 0:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bgez':
            if self.rf.getReg(inst.r1) >= 0:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bgtz':
            if self.rf.getReg(inst.r1) > 0:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'blez':
            if self.rf.getReg(inst.r1) <= 0:
                nextip = self.inst_label[inst.label]
            dst = None
        # Branchu (* Not correctly implemented *)
        elif inst.op == 'bltu':
            if self.rf.getReg(inst.r1) < self.rf.getReg(inst.r2):
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bgeu':
            if self.rf.getReg(inst.r1) >= self.rf.getReg(inst.r2):
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bgtu':
            if self.rf.getReg(inst.r1) > self.rf.getReg(inst.r2):
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bleu':
            if self.rf.getReg(inst.r1) <= self.rf.getReg(inst.r2):
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'blt':
            if self.rf.getReg(inst.r1) < self.rf.getReg(inst.r2):
                nextip = self.inst_label[inst.label]
            dst = None
        # Branch
        elif inst.op == 'beq':
            if self.rf.getReg(inst.r1) == self.rf.getReg(inst.r2):
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bne':
            if self.rf.getReg(inst.r1) != self.rf.getReg(inst.r2):
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bge':
            if self.rf.getReg(inst.r1) >= self.rf.getReg(inst.r2):
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bgt':
            if self.rf.getReg(inst.r1) > self.rf.getReg(inst.r2):
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'ble':
            if self.rf.getReg(inst.r1) <= self.rf.getReg(inst.r2):
                nextip = self.inst_label[inst.label]
            dst = None
            pass
        elif inst.op == 'j':
            nextip = self.inst_label[inst.label]
            dst = None
            pass
        elif inst.op == 'jal':
            r = nextip
            if inst.label == '_printint':
                print "PRINT:", self.rf.getReg("$a0")
            else:
                nextip = self.inst_label[inst.label]
                self.rf.push()
            dst = "$ra"
        elif inst.op == 'jr':
            if inst.r1 == '$ra':
                self.rf.pop()
            nextip = self.rf.getReg(inst.r1)
            dst = None
            pass
        elif inst.op == 'jalr':
            if self.rf.getReg(inst.r2) == self.inst_label['_printint']:
                print "PRINT:", self.rf.getReg("$a0")
            else:
                r = nextip
                nextip = self.rf.getReg(inst.r2)
                self.rf.push()
                dst = inst.r1
            pass
        elif inst.op == 'syscall':
            self.syscall()
            pass
        elif inst.op == 'nop':
            pass
        # update context
        #print "IP", self.ip
        #inst._print()
        #print "result : " + str(r)
        self.ip = nextip
        if dst is not None:
#            inst._print()
#            print self.ip
#            print dst
#            print len(self.regs)
            self.rf.setReg(dst, r)
        return

    def init(self):
        return

    def load(self, fname):
        with open(fname, 'rt') as f: 
            re_label = re.compile('([A-Za-z_.0-9]+):')
            is_text = False
            max_reg = 0
            for line in f:
                i_comment_begin = line.find('#')
                if i_comment_begin == -1:
                  # This line does not have a comment; just stripping spaces
                  l = line.strip()
                elif i_comment_begin == 0:
                  # The whole line is a comment
                  continue
                else:
                  # Removing comments and stripping spaces
                  l = (line[0:i_comment_begin]).strip()

                if l == '.data':
                    text_flag = False
                    continue
                elif l == '.text':
                    text_flag = True
                    continue
                elif text_flag is False:
                    # data mode
                    # label ?
                    # data ?
                    # Ignore everything; fun program does not need a data section
                    continue
                else:
                    # text mode
                    # label ?
                    m = re_label.match(l)
                    if m is not None:
                        self.inst_label[m.group(1)] = self.ip
                    else:
                        i = Inst(l)
                        self.insts.append(i)
                        self.ip = self.ip + 1
        return
        
    def start(self):
        self.ip = self.inst_label['main']

        while True:
            self.execute ()
            if self.ip == -1:
                break
            else:
                pass

        print "main function returns %s" % self.rf.getReg('$v0')
        #print self.regs

    def stat (self):
        return

if __name__ == '__main__':
    m = Machine();
    m.load (sys.argv[1])
    m.start()
