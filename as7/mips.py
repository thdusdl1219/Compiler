#!/usr/bin/python

import re
import sys

class Inst:
    op = ""
    r1 = ""
    r2 = ""
    r3 = ""
    immed = ""
    label = ""
    
    _type1 = re.compile ('^(?P<op>\w+)\s+(?P<r1>\$\w+),\s+(?P<r2>\$\w+),\s+(?P<r3>\$\w+)') # rd rs r
    _type2 = re.compile ('^(?P<op>\w+)\s+(?P<r1>\$\w+),\s+(?P<r2>\$\w+),\s+(?P<immed>-?\d+)') # rt rs immed
    _type3 = re.compile ('^(?P<op>\w+)\s+(?P<r1>\$\w+),\s+(?P<r2>\$\w+),\s+(?P<label>[A-Za-z_]\w+)') # branchu, branch
    _type4 = re.compile ('^(?P<op>\w+)\s+(?P<r1>\$\w+),\s+(?P<r2>\$\w+)') # rs rt 
    _type5 = re.compile ('^(?P<op>\w+)\s+(?P<r1>\$\w+),\s+(?P<immed>-?\d+)\((?P<r2>\$\w+)\)') # lw sw
    _type6 = re.compile ('^(?P<op>\w+)\s+(?P<r1>\$\w+),\s+(?P<immed>-?\d+)') # li reg immed
    _type7 = re.compile ('^(?P<op>\w+)\s+(?P<r1>\$\w+),\s+(?P<label>[A-Za-z_]\w+)') # la, branchz
    _type8 = re.compile ('^(?P<op>\w+)\s+(?P<r1>\$\w+)') # jr
    _type9 = re.compile ('^(?P<op>\w+)\s+(?P<label>[A-Za-z_]\w+)') # j jal 
    _type10 = re.compile ('^(?P<op>\w+)') # syscall, nop

    parse_list = [ _type1, _type2, _type3, _type4, _type5,
                   _type6, _type7, _type8, _type9, _type10]

    def __init__ (self, text):
        found = False
        for parse in self.parse_list:
            m = parse.match (text)
            if m is not None:
                self.op = m.group('op')
                try:
                    self.r1 = m.group('r1')
                except:
                    self.r1 = None
                try:
                    self.r2 = m.group('r2')
                except:
                    self.r2 = None
                try:
                    self.r3 = m.group('r3')
                except:
                    self.r3 = None
                try:
                    self.immed = int(m.group('immed'))
                except:
                    self.immed = 0
                try:
                    self.label = m.group('label')
                except:
                    self.label = None
                found = True
                break
        
        if not found:
            print "ERROR", text
            raise exception

    def _print(self):
        print self.op, self.r1, self.r2, self.r3, self.immed, self.label

class Machine:
    archRegs =  [ "$zero", "$at", "$v0", "$v1","$a0","$a1" ,"$a2", "$a3",
                  "$t0" ,"$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
                  "$s0", "$s1", "$s2", "$s3", "$s4", "$s5", "$s6", "$s7",
                  "$t8", "$t9", "$k0", "$k1", "$gp", "$sp", "$fp", "$ra"]

    archRegMap = dict (zip (archRegs, range (0, len (archRegs))))
    tempRegBase = len (archRegs)
    regs = [0 for x in xrange(0, len (archRegMap))]
    insts = []
    data = [] # heap
    static_data = {} # static data
    # Instruction Pointer
    ip = 0
    inst_label = {}
    data_label = {}
    text_base = 0
    data_base = 0
    static_base = 0x10000000

    def get_block_idx(self, addr):
        if addr < self.data_base:
            print addr
            raise Exception 
        else:
            return (addr - self.data_base) / 4

    def syscall(self):
        if self.regs[self.getidx("$v0")] == 9:
            # sbrk
            self.data_base = 0xFFFF0000
            size = (self.regs[self.getidx("$a0")] + 3) / 4
            for i in xrange(0, size):
                self.data.append(0)
            self.regs[self.getidx("$v0")] = self.data_base
        return

    def getidx(self, rname):
        try:
            return self.archRegMap[rname]
        except:
            return self.tempRegBase + int(rname[2:])

                        
    def get_max_reg(self, inst):
        l = [-1]
        try:
            l.append(self.getidx(inst.r1)) 
        except:
            pass
        try:
            l.append(self.getidx(inst.r2))
        except:
            pass
        try:
            l.append(self.getidx(inst.r3))
        except:
            pass

        return max (l)

    def execute(self):
        # Arit2 case
        r = 0
        dst = None
        nextip = self.ip + 1
        inst = self.insts[self.ip]
        """ try : 
            print "reg1" , self.regs[self.getidx(inst.r1)]
        except :
            pass
        print "IP", self.ip
        inst._print()"""
        if inst.op == 'abs':
            r = (self.regs[self.getidx(inst.r2)])
            dst = self.getidx(inst.r1)
        elif inst.op == 'neg':
            r = -(self.regs[self.getidx(inst.r2)])
            dst = self.getidx(inst.r1)
        elif inst.op == 'not':
            r = ~(self.regs[self.getidx(inst.r2)])
            dst = self.getidx(inst.r1)
        elif inst.op == 'add':
        # Arith3 case
            r = self.regs[self.getidx(inst.r2)] + self.regs[self.getidx(inst.r3)]
            dst = self.getidx(inst.r1)
        elif inst.op == 'and':
            r = self.regs[self.getidx(inst.r2)] & self.regs[self.getidx(inst.r3)]
            dst = self.getidx(inst.r1)
        elif inst.op == 'mulo':
            r = (self.regs[self.getidx(inst.r2)] * self.regs[self.getidx(inst.r3)])
            dst = self.getidx(inst.r1)
        elif inst.op == 'div':
            r = (self.regs[self.getidx(inst.r2)] / self.regs[self.getidx(inst.r3)])
            dst = self.getidx(inst.r1)
        elif inst.op == 'or':
            r = (self.regs[self.getidx(inst.r2)] | self.regs[self.getidx(inst.r3)])
            dst = self.getidx(inst.r1)
        elif inst.op == 'rem':
            r = (self.regs[self.getidx(inst.r2)] % self.regs[self.getidx(inst.r3)])
            dst = self.getidx(inst.r1)
        elif inst.op == 'sub':
            r = (self.regs[self.getidx(inst.r2)] - self.regs[self.getidx(inst.r3)])
            dst = self.getidx(inst.r1)
        elif inst.op == 'xor':
            r = (self.regs[self.getidx(inst.r2)] ^ self.regs[self.getidx(inst.r3)])
            dst = self.getidx(inst.r1)
        elif inst.op == 'seq':
            r = (self.regs[self.getidx(inst.r2)] == self.regs[self.getidx(inst.r3)])
            dst = self.getidx(inst.r1)
        elif inst.op == 'slt':
            r = (self.regs[self.getidx(inst.r2)] < self.regs[self.getidx(inst.r3)])
            dst = self.getidx(inst.r1)
        # Arithi case
        elif inst.op == 'addi':
            r = (self.regs[self.getidx(inst.r2)] + inst.immed)
            dst = self.getidx(inst.r1)
        elif inst.op == 'andi':
            r = (self.regs[self.getidx(inst.r2)] & inst.immed)
            dst = self.getidx(inst.r1)
        elif inst.op == 'orii':
            r = (self.regs[self.getidx(inst.r2)] | inst.immed)
            dst = self.getidx(inst.r1)
        elif inst.op == 'xori':
            r = (self.regs[self.getidx(inst.r2)] ^ inst.immed)
            dst = self.getidx(inst.r1)
        # Li
        elif inst.op == 'li':
            r = inst.immed
            dst = self.getidx(inst.r1)
        # La
        elif inst.op == 'la':
            try:
                r = self.inst_label[inst.label]
                r = r + self.text_base
            except:
                r = self.data_label[inst.label]
                r = r + self.data_base

            dst = self.getidx(inst.r1)
        # Lw
        elif inst.op == 'lw':
            addr = self.regs[self.getidx(inst.r2)] + inst.immed
            if addr >= self.static_base and addr < self.data_base:
                try:
                    r = self.static_data[addr]
                except:
                    r = 0
            else:
                r = self.data[self.get_block_idx(addr)]
            dst = self.getidx(inst.r1)
        # Sw
        elif inst.op == 'sw':
            addr = self.regs[self.getidx(inst.r2)] + inst.immed
            if addr >= self.static_base and addr < self.data_base:
                self.static_data[addr] = self.regs[self.getidx(inst.r1)]
            else:
                self.data[self.get_block_idx(addr)] = self.regs[self.getidx(inst.r1)]
            dst = None
        # Move
        elif inst.op == 'move':
            r = self.regs[self.getidx(inst.r2)]
            dst = self.getidx(inst.r1)
        # Branchz
        elif inst.op == 'bltz':
            if self.regs[self.getidx(inst.r1)] < 0:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'beqz':
            if self.regs[self.getidx(inst.r1)] == 0:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bnez':
            if self.regs[self.getidx(inst.r1)] != 0:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bgez':
            if self.regs[self.getidx(inst.r1)] >= 0:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bgtz':
            if self.regs[self.getidx(inst.r1)] > 0:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'blez':
            if self.regs[self.getidx(inst.r1)] <= 0:
                nextip = self.inst_label[inst.label]
            dst = None
        # Branchu (* Not correctly implemented *)
        elif inst.op == 'bltu':
            if self.regs[self.getidx(inst.r1)] < self.regs[self.getidx(inst.r2)]:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bgeu':
            if self.regs[self.getidx(inst.r1)] >= self.regs[self.getidx(inst.r2)]:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bgtu':
            if self.regs[self.getidx(inst.r1)] > self.regs[self.getidx(inst.r2)]:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bleu':
            if self.regs[self.getidx(inst.r1)] <= self.regs[self.getidx(inst.r2)]:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'blt':
            if self.regs[self.getidx(inst.r1)] < self.regs[self.getidx(inst.r2)]:
                nextip = self.inst_label[inst.label]
            dst = None
        # Branch
        elif inst.op == 'beq':
            if self.regs[self.getidx(inst.r1)] == self.regs[self.getidx(inst.r2)]:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bne':
            if self.regs[self.getidx(inst.r1)] != self.regs[self.getidx(inst.r2)]:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bge':
            if self.regs[self.getidx(inst.r1)] >= self.regs[self.getidx(inst.r2)]:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'bgt':
            if self.regs[self.getidx(inst.r1)] > self.regs[self.getidx(inst.r2)]:
                nextip = self.inst_label[inst.label]
            dst = None
        elif inst.op == 'ble':
            if self.regs[self.getidx(inst.r1)] <= self.regs[self.getidx(inst.r2)]:
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
                print "PRINT:",self.regs[self.getidx("$a0")]
            else:
                nextip = self.inst_label[inst.label]
            dst = self.getidx ("$ra")
        elif inst.op == 'jr':
            nextip = self.regs[self.getidx(inst.r1)]
            dst = None
            pass
        elif inst.op == 'jalr':
            if self.regs[self.getidx(inst.r2)] == self.inst_label['_printint']:
                print "PRINT:",self.regs[self.getidx("$a0")]
            else:
                r = nextip
                nextip = self.regs[self.getidx(inst.r2)]
                dst = self.getidx(inst.r1)
            pass
        elif inst.op == 'syscall':
            self.syscall()
            pass
        elif inst.op == 'nop':
            pass
        # update context
        self.ip = nextip
        if dst is not None:
#            inst._print()
#            print self.ip
#            print dst
#            print len(self.regs)
            self.regs[dst] = r
        return

    def init(self):
        return

    def load (self, fname):
        f = open (fname)
        get_label = re.compile('([A-Za-z_.0-9]+):')
        text_flag = False
        max_reg = 0
        for line in f:
            l = line.strip()
            if l[0] == '#':
                continue
            elif l == '.data':
                text_flag = False
                continue
            elif l == '.text':
                text_flag = True
                continue
            elif text_flag is False:
                # data mode
                # label ?
                # data ?
                continue
            else:
                # text mode
                # label ?
                m = get_label.match(l)
                if m is not None:
                    self.inst_label[m.group(1)] = self.ip
                else:
                    i = Inst(l)
                    if self.get_max_reg (i) > max_reg:
                        max_reg = self.get_max_reg (i)
                    self.insts.append(i)
                    self.ip = self.ip + 1

        for i in xrange(0, max_reg - self.tempRegBase + 1):
            self.regs.append(0)

        return
        
    def start(self):
        self.regs[self.getidx('$ra')] = -1
        self.ip = self.inst_label['main']
        self.regs[self.getidx('$sp')] = 0x20000000
        self.regs[self.getidx('$gp')] = 0x10008000

        while True:
            self.execute ()
            if self.ip == -1:
                break
            else:
                pass

        print self.regs[self.getidx("$v0")]
        #print self.regs

    def stat (self):
        return

if __name__ == '__main__':
    m = Machine ();
    m.load (sys.argv[1])
    m.start()

