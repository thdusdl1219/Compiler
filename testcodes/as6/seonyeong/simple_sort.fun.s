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
_get:
	move 	$t4, $ra	# $t4 := $ra
	move 	$t3, $s0	# $t3 := $s0
	move 	$t2, $s1	# $t2 := $s1
	move 	$t1, $s2	# $t1 := $s2
	move 	$t0, $s3	# $t0 := $s3
	move 	$a3, $s4	# $a3 := $s4
	move 	$a2, $s5	# $a2 := $s5
	move 	$a1, $s6	# $a1 := $s6
	move 	$v1, $s7	# $v1 := $s7
	move 	$v0, $a0	# $v0 := $a0
	lw 	$t5, 0($v0)	# $t5 := [$v0+0]
	lw 	$a0, 4($v0)	# $a0 := [$v0+4]
	li 	$v0, 0		# $v0 := 0
	seq	$v0, $a0, $v0	# $v0 := $a0==$v0
	beqz	$v0, L1   	# if (signed) $v0 == 0 goto L1
	lw 	$v0, 0($t5)	# $v0 := [$t5+0]
				# $v0 := $v0
	j 	L2		# goto L2
L1:
	li 	$v0, 1		# $v0 := 1
	seq	$v0, $a0, $v0	# $v0 := $a0==$v0
	beqz	$v0, L3   	# if (signed) $v0 == 0 goto L3
	lw 	$v0, 4($t5)	# $v0 := [$t5+4]
				# $v0 := $v0
	j 	L4		# goto L4
L3:
	li 	$v0, 2		# $v0 := 2
	seq	$v0, $a0, $v0	# $v0 := $a0==$v0
	beqz	$v0, L5   	# if (signed) $v0 == 0 goto L5
	lw 	$v0, 8($t5)	# $v0 := [$t5+8]
				# $v0 := $v0
	j 	L6		# goto L6
L5:
	li 	$v0, 3		# $v0 := 3
	seq	$v0, $a0, $v0	# $v0 := $a0==$v0
	beqz	$v0, L7   	# if (signed) $v0 == 0 goto L7
	lw 	$v0, 12($t5)	# $v0 := [$t5+12]
				# $v0 := $v0
	j 	L8		# goto L8
L7:
	lw 	$v0, 16($t5)	# $v0 := [$t5+16]
				# $v0 := $v0
L8:
				# $v0 := $v0
L6:
				# $v0 := $v0
L4:
				# $v0 := $v0
L2:
				# $v0 := $v0
	move 	$ra, $t4	# $ra := $t4
	move 	$s0, $t3	# $s0 := $t3
	move 	$s1, $t2	# $s1 := $t2
	move 	$s2, $t1	# $s2 := $t1
	move 	$s3, $t0	# $s3 := $t0
	move 	$s4, $a3	# $s4 := $a3
	move 	$s5, $a2	# $s5 := $a2
	move 	$s6, $a1	# $s6 := $a1
	move 	$s7, $v1	# $s7 := $v1
_get.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_swap:
	move 	$t6, $ra	# $t6 := $ra
	move 	$t5, $s0	# $t5 := $s0
	move 	$t4, $s1	# $t4 := $s1
	move 	$t3, $s2	# $t3 := $s2
	move 	$t2, $s3	# $t2 := $s3
	move 	$t1, $s4	# $t1 := $s4
	move 	$t0, $s5	# $t0 := $s5
	move 	$a3, $s6	# $a3 := $s6
	move 	$a2, $s7	# $a2 := $s7
	move 	$v0, $a0	# $v0 := $a0
	lw 	$a1, 0($v0)	# $a1 := [$v0+0]
	lw 	$a0, 4($v0)	# $a0 := [$v0+4]
	lw 	$v1, 0($a1)	# $v1 := [$a1+0]
	lw 	$v0, 0($a0)	# $v0 := [$a0+0]
	sw 	$v0, 0($a1)	# [$a1+0] := $v0
	sw 	$v1, 0($a0)	# [$a0+0] := $v1
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	move 	$ra, $t6	# $ra := $t6
	move 	$s0, $t5	# $s0 := $t5
	move 	$s1, $t4	# $s1 := $t4
	move 	$s2, $t3	# $s2 := $t3
	move 	$s3, $t2	# $s3 := $t2
	move 	$s4, $t1	# $s4 := $t1
	move 	$s5, $t0	# $s5 := $t0
	move 	$s6, $a3	# $s6 := $a3
	move 	$s7, $a2	# $s7 := $a2
_swap.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_sort:
	move 	$x45, $ra	# $x45 := $ra
	move 	$x46, $s0	# $x46 := $s0
	move 	$x47, $s1	# $x47 := $s1
	move 	$x48, $s2	# $x48 := $s2
	move 	$x49, $s3	# $x49 := $s3
	move 	$x50, $s4	# $x50 := $s4
	move 	$x51, $s5	# $x51 := $s5
	move 	$x52, $s6	# $x52 := $s6
	move 	$x53, $s7	# $x53 := $s7
	move 	$x54, $a0	# $x54 := $a0
	li 	$x56, 0		# $x56 := 0
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x55, $v0	# $x55 := $v0
	sw 	$x56, 0($x55)	# [$x55+0] := $x56
	li 	$x58, 0		# $x58 := 0
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x57, $v0	# $x57 := $v0
	sw 	$x58, 0($x57)	# [$x57+0] := $x58
L9:
	lw 	$a0, 0($x55)	# $a0 := [$x55+0]
	li 	$v1, 4		# $v1 := 4
	slt	$v1, $a0, $v1	# $v1 := $a0<$v1
	beqz	$v1, L10   	# if (signed) $v1 == 0 goto L10
	li 	$v1, 0		# $v1 := 0
	sw 	$v1, 0($x57)	# [$x57+0] := $v1
L11:
	lw 	$a1, 0($x57)	# $a1 := [$x57+0]
	lw 	$a0, 0($x55)	# $a0 := [$x55+0]
	li 	$v1, 4		# $v1 := 4
	sub	$v1, $v1, $a0	# $v1 := $v1-$a0
	slt	$v1, $a1, $v1	# $v1 := $a1<$v1
	beqz	$v1, L12   	# if (signed) $v1 == 0 goto L12
	la 	$x73, _get	# $x73 := _get
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x74, $v0	# $x74 := $v0
	sw 	$x54, 0($x74)	# [$x74+0] := $x54
	lw 	$x75, 0($x57)	# $x75 := [$x57+0]
	sw 	$x75, 4($x74)	# [$x74+4] := $x75
	move 	$a0, $x74	# $a0 := $x74
	jalr 	$ra, $x73	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	lw 	$x77, 0($v1)	# $x77 := [$v1+0]
	la 	$x78, _get	# $x78 := _get
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x79, $v0	# $x79 := $v0
	sw 	$x54, 0($x79)	# [$x79+0] := $x54
	lw 	$x81, 0($x57)	# $x81 := [$x57+0]
	addi 	$x80, $x81, 1	# $x80 := $x81+1
	sw 	$x80, 4($x79)	# [$x79+4] := $x80
	move 	$a0, $x79	# $a0 := $x79
	jalr 	$ra, $x78	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	lw 	$v1, 0($v1)	# $v1 := [$v1+0]
	slt	$a0, $x77, $v1	# $a0 := $x77<$v1
	li 	$v1, 0		# $v1 := 0
	seq	$v1, $a0, $v1	# $v1 := $a0==$v1
	beqz	$v1, L13   	# if (signed) $v1 == 0 goto L13
	la 	$x85, _swap	# $x85 := _swap
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x86, $v0	# $x86 := $v0
	la 	$x87, _get	# $x87 := _get
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x88, $v0	# $x88 := $v0
	sw 	$x54, 0($x88)	# [$x88+0] := $x54
	lw 	$x89, 0($x57)	# $x89 := [$x57+0]
	sw 	$x89, 4($x88)	# [$x88+4] := $x89
	move 	$a0, $x88	# $a0 := $x88
	jalr 	$ra, $x87	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	sw 	$v1, 0($x86)	# [$x86+0] := $v1
	la 	$x91, _get	# $x91 := _get
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x92, $v0	# $x92 := $v0
	sw 	$x54, 0($x92)	# [$x92+0] := $x54
	lw 	$x94, 0($x57)	# $x94 := [$x57+0]
	addi 	$x93, $x94, 1	# $x93 := $x94+1
	sw 	$x93, 4($x92)	# [$x92+4] := $x93
	move 	$a0, $x92	# $a0 := $x92
	jalr 	$ra, $x91	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x95, $v0	# $x95 := $v0
	sw 	$x95, 4($x86)	# [$x86+4] := $x95
	move 	$a0, $x86	# $a0 := $x86
	jalr 	$ra, $x85	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
				# $v1 := $v1
	j 	L14		# goto L14
L13:
	li 	$v1, 0		# $v1 := 0
				# $v1 := $v1
L14:
	lw 	$v1, 0($x57)	# $v1 := [$x57+0]
	addi 	$v1, $v1, 1	# $v1 := $v1+1
	sw 	$v1, 0($x57)	# [$x57+0] := $v1
	move 	$v1, $x57	# $v1 := $x57
	j 	L11		# goto L11
L12:
	lw 	$v1, 0($x55)	# $v1 := [$x55+0]
	addi 	$v1, $v1, 1	# $v1 := $v1+1
	sw 	$v1, 0($x55)	# [$x55+0] := $v1
	move 	$x59, $x55	# $x59 := $x55
	j 	L9		# goto L9
L10:
	move 	$v0, $x59	# $v0 := $x59
	move 	$ra, $x45	# $ra := $x45
	move 	$s0, $x46	# $s0 := $x46
	move 	$s1, $x47	# $s1 := $x47
	move 	$s2, $x48	# $s2 := $x48
	move 	$s3, $x49	# $s3 := $x49
	move 	$s4, $x50	# $s4 := $x50
	move 	$s5, $x51	# $s5 := $x51
	move 	$s6, $x52	# $s6 := $x52
	move 	$s7, $x53	# $s7 := $x53
_sort.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	move 	$x102, $ra	# $x102 := $ra
	move 	$x103, $s0	# $x103 := $s0
	move 	$x104, $s1	# $x104 := $s1
	move 	$x105, $s2	# $x105 := $s2
	move 	$x106, $s3	# $x106 := $s3
	move 	$x107, $s4	# $x107 := $s4
	move 	$x108, $s5	# $x108 := $s5
	move 	$x109, $s6	# $x109 := $s6
	move 	$x110, $s7	# $x110 := $s7
	move 	$v1, $a0	# $v1 := $a0
	li 	$a0, 20		# $a0 := 20
	jal 	alloc		# call alloc
	move 	$x112, $v0	# $x112 := $v0
	li 	$x114, 5		# $x114 := 5
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	sw 	$x114, 0($v1)	# [$v1+0] := $x114
	sw 	$v1, 0($x112)	# [$x112+0] := $v1
	li 	$x116, 2		# $x116 := 2
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	sw 	$x116, 0($v1)	# [$v1+0] := $x116
	sw 	$v1, 4($x112)	# [$x112+4] := $v1
	li 	$x118, 3		# $x118 := 3
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	sw 	$x118, 0($v1)	# [$v1+0] := $x118
	sw 	$v1, 8($x112)	# [$x112+8] := $v1
	li 	$x120, 4		# $x120 := 4
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	sw 	$x120, 0($v1)	# [$v1+0] := $x120
	sw 	$v1, 12($x112)	# [$x112+12] := $v1
	li 	$x122, 1		# $x122 := 1
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x121, $v0	# $x121 := $v0
	sw 	$x122, 0($x121)	# [$x121+0] := $x122
	sw 	$x121, 16($x112)	# [$x112+16] := $x121
	la 	$x123, _sort	# $x123 := _sort
	move 	$a0, $x112	# $a0 := $x112
	jalr 	$ra, $x123	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x124, $v0	# $x124 := $v0
	la 	$x125, _printint	# $x125 := _printint
	lw 	$x126, 0($x112)	# $x126 := [$x112+0]
	lw 	$x127, 0($x126)	# $x127 := [$x126+0]
	move 	$a0, $x127	# $a0 := $x127
	jalr 	$ra, $x125	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x128, $v0	# $x128 := $v0
	la 	$x129, _printint	# $x129 := _printint
	lw 	$x130, 4($x112)	# $x130 := [$x112+4]
	lw 	$x131, 0($x130)	# $x131 := [$x130+0]
	move 	$a0, $x131	# $a0 := $x131
	jalr 	$ra, $x129	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x132, $v0	# $x132 := $v0
	la 	$x133, _printint	# $x133 := _printint
	lw 	$x134, 8($x112)	# $x134 := [$x112+8]
	lw 	$x135, 0($x134)	# $x135 := [$x134+0]
	move 	$a0, $x135	# $a0 := $x135
	jalr 	$ra, $x133	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x136, $v0	# $x136 := $v0
	la 	$x137, _printint	# $x137 := _printint
	lw 	$x138, 12($x112)	# $x138 := [$x112+12]
	lw 	$x139, 0($x138)	# $x139 := [$x138+0]
	move 	$a0, $x139	# $a0 := $x139
	jalr 	$ra, $x137	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x140, $v0	# $x140 := $v0
	la 	$x141, _printint	# $x141 := _printint
	lw 	$x142, 16($x112)	# $x142 := [$x112+16]
	lw 	$x143, 0($x142)	# $x143 := [$x142+0]
	move 	$a0, $x143	# $a0 := $x143
	jalr 	$ra, $x141	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	move 	$ra, $x102	# $ra := $x102
	move 	$s0, $x103	# $s0 := $x103
	move 	$s1, $x104	# $s1 := $x104
	move 	$s2, $x105	# $s2 := $x105
	move 	$s3, $x106	# $s3 := $x106
	move 	$s4, $x107	# $s4 := $x107
	move 	$s5, $x108	# $s5 := $x108
	move 	$s6, $x109	# $s6 := $x109
	move 	$s7, $x110	# $s7 := $x110
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
