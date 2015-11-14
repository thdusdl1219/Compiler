	.data 
NL:	.asciiz	"\n"
	.text 
main:
	move 	$x0, $ra	# $x0 := $ra
	li 	$a0, 32000		# $a0 := 32000
	li 	$v0, 9		# $v0 := 9
	syscall 
	sw 	$v0, 0($gp)	# [$gp+0] := $v0
	jal 	_main		# call _main
	move 	$ra, $x0	# $ra := $x0
main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
alloc:
	lw 	$v0, 0($gp)	# $v0 := [$gp+0]
	add	$t0, $v0, $a0	# $t0 := $v0+$a0
	sw 	$t0, 0($gp)	# [$gp+0] := $t0
alloc.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_printint:
	li 	$v0, 1		# $v0 := 1
	syscall 
	la 	$a0, NL	# $a0 := NL
	li 	$v0, 4		# $v0 := 4
	syscall 
_printint.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	move 	$x1, $ra	# $x1 := $ra
	move 	$x2, $s0	# $x2 := $s0
	move 	$x3, $s1	# $x3 := $s1
	move 	$x4, $s2	# $x4 := $s2
	move 	$x5, $s3	# $x5 := $s3
	move 	$x6, $s4	# $x6 := $s4
	move 	$x7, $s5	# $x7 := $s5
	move 	$x8, $s6	# $x8 := $s6
	move 	$x9, $s7	# $x9 := $s7
	move 	$v1, $a0	# $v1 := $a0
	la 	$x11, _printint	# $x11 := _printint
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x12, $v0	# $x12 := $v0
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 1		# $a0 := 1
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	sw 	$v1, 0($x12)	# [$x12+0] := $v1
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 4		# $a0 := 4
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	sw 	$v1, 4($x12)	# [$x12+4] := $v1
	li 	$a0, 16		# $a0 := 16
	jal 	alloc		# call alloc
	move 	$x21, $v0	# $x21 := $v0
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x22, $v0	# $x22 := $v0
	li 	$a0, 16		# $a0 := 16
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 1		# $a0 := 1
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	li 	$a0, 4		# $a0 := 4
	sw 	$a0, 12($v1)	# [$v1+12] := $a0
	sw 	$v1, 0($x22)	# [$x22+0] := $v1
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x28, $v0	# $x28 := $v0
	li 	$x29, 2		# $x29 := 2
	sw 	$x29, 0($x28)	# [$x28+0] := $x29
	li 	$x30, 3		# $x30 := 3
	sw 	$x30, 4($x28)	# [$x28+4] := $x30
	li 	$x31, 4		# $x31 := 4
	sw 	$x31, 8($x28)	# [$x28+8] := $x31
	sw 	$x28, 4($x22)	# [$x22+4] := $x28
	sw 	$x22, 0($x21)	# [$x21+0] := $x22
	li 	$x32, 1		# $x32 := 1
	sw 	$x32, 4($x21)	# [$x21+4] := $x32
	li 	$x33, 2		# $x33 := 2
	sw 	$x33, 8($x21)	# [$x21+8] := $x33
	li 	$x34, 3		# $x34 := 3
	sw 	$x34, 12($x21)	# [$x21+12] := $x34
	sw 	$x21, 8($x12)	# [$x12+8] := $x21
	lw 	$x35, 0($x12)	# $x35 := [$x12+0]
	lw 	$x36, 4($x35)	# $x36 := [$x35+4]
	move 	$a0, $x36	# $a0 := $x36
	jalr 	$ra, $x11	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x38, _printint	# $x38 := _printint
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x39, $v0	# $x39 := $v0
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 1		# $a0 := 1
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	sw 	$v1, 0($x39)	# [$x39+0] := $v1
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 4		# $a0 := 4
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	sw 	$v1, 4($x39)	# [$x39+4] := $v1
	li 	$a0, 16		# $a0 := 16
	jal 	alloc		# call alloc
	move 	$x48, $v0	# $x48 := $v0
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x49, $v0	# $x49 := $v0
	li 	$a0, 16		# $a0 := 16
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 1		# $a0 := 1
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	li 	$a0, 4		# $a0 := 4
	sw 	$a0, 12($v1)	# [$v1+12] := $a0
	sw 	$v1, 0($x49)	# [$x49+0] := $v1
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x55, $v0	# $x55 := $v0
	li 	$x56, 2		# $x56 := 2
	sw 	$x56, 0($x55)	# [$x55+0] := $x56
	li 	$x57, 3		# $x57 := 3
	sw 	$x57, 4($x55)	# [$x55+4] := $x57
	li 	$x58, 4		# $x58 := 4
	sw 	$x58, 8($x55)	# [$x55+8] := $x58
	sw 	$x55, 4($x49)	# [$x49+4] := $x55
	sw 	$x49, 0($x48)	# [$x48+0] := $x49
	li 	$x59, 1		# $x59 := 1
	sw 	$x59, 4($x48)	# [$x48+4] := $x59
	li 	$x60, 2		# $x60 := 2
	sw 	$x60, 8($x48)	# [$x48+8] := $x60
	li 	$x61, 3		# $x61 := 3
	sw 	$x61, 12($x48)	# [$x48+12] := $x61
	sw 	$x48, 8($x39)	# [$x39+8] := $x48
	lw 	$x62, 4($x39)	# $x62 := [$x39+4]
	lw 	$x63, 0($x62)	# $x63 := [$x62+0]
	move 	$a0, $x63	# $a0 := $x63
	jalr 	$ra, $x38	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x65, _printint	# $x65 := _printint
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x66, $v0	# $x66 := $v0
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 1		# $a0 := 1
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	sw 	$v1, 0($x66)	# [$x66+0] := $v1
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 4		# $a0 := 4
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	sw 	$v1, 4($x66)	# [$x66+4] := $v1
	li 	$a0, 16		# $a0 := 16
	jal 	alloc		# call alloc
	move 	$x75, $v0	# $x75 := $v0
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x76, $v0	# $x76 := $v0
	li 	$a0, 16		# $a0 := 16
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 1		# $a0 := 1
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	li 	$a0, 4		# $a0 := 4
	sw 	$a0, 12($v1)	# [$v1+12] := $a0
	sw 	$v1, 0($x76)	# [$x76+0] := $v1
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x82, $v0	# $x82 := $v0
	li 	$x83, 2		# $x83 := 2
	sw 	$x83, 0($x82)	# [$x82+0] := $x83
	li 	$x84, 3		# $x84 := 3
	sw 	$x84, 4($x82)	# [$x82+4] := $x84
	li 	$x85, 4		# $x85 := 4
	sw 	$x85, 8($x82)	# [$x82+8] := $x85
	sw 	$x82, 4($x76)	# [$x76+4] := $x82
	sw 	$x76, 0($x75)	# [$x75+0] := $x76
	li 	$x86, 1		# $x86 := 1
	sw 	$x86, 4($x75)	# [$x75+4] := $x86
	li 	$x87, 2		# $x87 := 2
	sw 	$x87, 8($x75)	# [$x75+8] := $x87
	li 	$x88, 3		# $x88 := 3
	sw 	$x88, 12($x75)	# [$x75+12] := $x88
	sw 	$x75, 8($x66)	# [$x66+8] := $x75
	lw 	$x89, 8($x66)	# $x89 := [$x66+8]
	lw 	$x90, 8($x89)	# $x90 := [$x89+8]
	move 	$a0, $x90	# $a0 := $x90
	jalr 	$ra, $x65	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x92, _printint	# $x92 := _printint
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x93, $v0	# $x93 := $v0
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 1		# $a0 := 1
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	sw 	$v1, 0($x93)	# [$x93+0] := $v1
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 4		# $a0 := 4
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	sw 	$v1, 4($x93)	# [$x93+4] := $v1
	li 	$a0, 16		# $a0 := 16
	jal 	alloc		# call alloc
	move 	$x102, $v0	# $x102 := $v0
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x103, $v0	# $x103 := $v0
	li 	$a0, 16		# $a0 := 16
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 1		# $a0 := 1
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	li 	$a0, 4		# $a0 := 4
	sw 	$a0, 12($v1)	# [$v1+12] := $a0
	sw 	$v1, 0($x103)	# [$x103+0] := $v1
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x109, $v0	# $x109 := $v0
	li 	$x110, 2		# $x110 := 2
	sw 	$x110, 0($x109)	# [$x109+0] := $x110
	li 	$x111, 3		# $x111 := 3
	sw 	$x111, 4($x109)	# [$x109+4] := $x111
	li 	$x112, 4		# $x112 := 4
	sw 	$x112, 8($x109)	# [$x109+8] := $x112
	sw 	$x109, 4($x103)	# [$x103+4] := $x109
	sw 	$x103, 0($x102)	# [$x102+0] := $x103
	li 	$x113, 1		# $x113 := 1
	sw 	$x113, 4($x102)	# [$x102+4] := $x113
	li 	$x114, 2		# $x114 := 2
	sw 	$x114, 8($x102)	# [$x102+8] := $x114
	li 	$x115, 3		# $x115 := 3
	sw 	$x115, 12($x102)	# [$x102+12] := $x115
	sw 	$x102, 8($x93)	# [$x93+8] := $x102
	lw 	$x116, 8($x93)	# $x116 := [$x93+8]
	lw 	$x117, 0($x116)	# $x117 := [$x116+0]
	lw 	$x118, 0($x117)	# $x118 := [$x117+0]
	lw 	$x119, 4($x118)	# $x119 := [$x118+4]
	move 	$a0, $x119	# $a0 := $x119
	jalr 	$ra, $x92	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x121, _printint	# $x121 := _printint
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x122, $v0	# $x122 := $v0
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 1		# $a0 := 1
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	sw 	$v1, 0($x122)	# [$x122+0] := $v1
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 4		# $a0 := 4
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	sw 	$v1, 4($x122)	# [$x122+4] := $v1
	li 	$a0, 16		# $a0 := 16
	jal 	alloc		# call alloc
	move 	$x131, $v0	# $x131 := $v0
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x132, $v0	# $x132 := $v0
	li 	$a0, 16		# $a0 := 16
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 1		# $a0 := 1
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 2		# $a0 := 2
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	li 	$a0, 3		# $a0 := 3
	sw 	$a0, 8($v1)	# [$v1+8] := $a0
	li 	$a0, 4		# $a0 := 4
	sw 	$a0, 12($v1)	# [$v1+12] := $a0
	sw 	$v1, 0($x132)	# [$x132+0] := $v1
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x138, $v0	# $x138 := $v0
	li 	$x139, 2		# $x139 := 2
	sw 	$x139, 0($x138)	# [$x138+0] := $x139
	li 	$x140, 3		# $x140 := 3
	sw 	$x140, 4($x138)	# [$x138+4] := $x140
	li 	$x141, 4		# $x141 := 4
	sw 	$x141, 8($x138)	# [$x138+8] := $x141
	sw 	$x138, 4($x132)	# [$x132+4] := $x138
	sw 	$x132, 0($x131)	# [$x131+0] := $x132
	li 	$x142, 1		# $x142 := 1
	sw 	$x142, 4($x131)	# [$x131+4] := $x142
	li 	$x143, 2		# $x143 := 2
	sw 	$x143, 8($x131)	# [$x131+8] := $x143
	li 	$x144, 3		# $x144 := 3
	sw 	$x144, 12($x131)	# [$x131+12] := $x144
	sw 	$x131, 8($x122)	# [$x122+8] := $x131
	lw 	$x145, 8($x122)	# $x145 := [$x122+8]
	lw 	$x146, 0($x145)	# $x146 := [$x145+0]
	lw 	$x147, 4($x146)	# $x147 := [$x146+4]
	lw 	$x148, 0($x147)	# $x148 := [$x147+0]
	move 	$a0, $x148	# $a0 := $x148
	jalr 	$ra, $x121	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x149, $v0	# $x149 := $v0
	la 	$x150, _printint	# $x150 := _printint
	li 	$x151, 1414		# $x151 := 1414
	move 	$a0, $x151	# $a0 := $x151
	jalr 	$ra, $x150	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	move 	$ra, $x1	# $ra := $x1
	move 	$s0, $x2	# $s0 := $x2
	move 	$s1, $x3	# $s1 := $x3
	move 	$s2, $x4	# $s2 := $x4
	move 	$s3, $x5	# $s3 := $x5
	move 	$s4, $x6	# $s4 := $x6
	move 	$s5, $x7	# $s5 := $x7
	move 	$s6, $x8	# $s6 := $x8
	move 	$s7, $x9	# $s7 := $x9
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
