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
_int:
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
	lw 	$v0, 0($v0)	# $v0 := [$v0+0]
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
_int.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_foo:
	move 	$x12, $ra	# $x12 := $ra
	move 	$x13, $s0	# $x13 := $s0
	move 	$x14, $s1	# $x14 := $s1
	move 	$x15, $s2	# $x15 := $s2
	move 	$x16, $s3	# $x16 := $s3
	move 	$x17, $s4	# $x17 := $s4
	move 	$x18, $s5	# $x18 := $s5
	move 	$x19, $s6	# $x19 := $s6
	move 	$x20, $s7	# $x20 := $s7
	move 	$x21, $a0	# $x21 := $a0
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
				# $v0 := $v0
	sw 	$x21, 0($v0)	# [$v0+0] := $x21
				# $v0 := $v0
	move 	$ra, $x12	# $ra := $x12
	move 	$s0, $x13	# $s0 := $x13
	move 	$s1, $x14	# $s1 := $x14
	move 	$s2, $x15	# $s2 := $x15
	move 	$s3, $x16	# $s3 := $x16
	move 	$s4, $x17	# $s4 := $x17
	move 	$s5, $x18	# $s5 := $x18
	move 	$s6, $x19	# $s6 := $x19
	move 	$s7, $x20	# $s7 := $x20
_foo.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_fact:
	move 	$x23, $ra	# $x23 := $ra
	move 	$x24, $s0	# $x24 := $s0
	move 	$x25, $s1	# $x25 := $s1
	move 	$x26, $s2	# $x26 := $s2
	move 	$x27, $s3	# $x27 := $s3
	move 	$x28, $s4	# $x28 := $s4
	move 	$x29, $s5	# $x29 := $s5
	move 	$x30, $s6	# $x30 := $s6
	move 	$x31, $s7	# $x31 := $s7
	move 	$x32, $a0	# $x32 := $a0
	li 	$x35, 0		# $x35 := 0
	seq	$x34, $x32, $x35	# $x34 := $x32==$x35
	beqz	$x34, L1   	# if (signed) $x34 == 0 goto L1
	li 	$v0, 1		# $v0 := 1
				# $v0 := $v0
	j 	L2		# goto L2
L1:
	la 	$x38, _fact	# $x38 := _fact
	li 	$x40, 1		# $x40 := 1
	sub	$x39, $x32, $x40	# $x39 := $x32-$x40
	move 	$a0, $x39	# $a0 := $x39
	jalr 	$ra, $x38	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	mulo	$v0, $x32, $v0	# $v0 := $x32*$v0
				# $v0 := $v0
L2:
				# $v0 := $v0
	move 	$ra, $x23	# $ra := $x23
	move 	$s0, $x24	# $s0 := $x24
	move 	$s1, $x25	# $s1 := $x25
	move 	$s2, $x26	# $s2 := $x26
	move 	$s3, $x27	# $s3 := $x27
	move 	$s4, $x28	# $s4 := $x28
	move 	$s5, $x29	# $s5 := $x29
	move 	$s6, $x30	# $s6 := $x30
	move 	$s7, $x31	# $s7 := $x31
_fact.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_addsome:
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
	addi 	$v0, $v0, 5	# $v0 := $v0+5
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
_addsome.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_add:
	move 	$t5, $ra	# $t5 := $ra
	move 	$t4, $s0	# $t4 := $s0
	move 	$t3, $s1	# $t3 := $s1
	move 	$t2, $s2	# $t2 := $s2
	move 	$t1, $s3	# $t1 := $s3
	move 	$t0, $s4	# $t0 := $s4
	move 	$a3, $s5	# $a3 := $s5
	move 	$a2, $s6	# $a2 := $s6
	move 	$a1, $s7	# $a1 := $s7
	move 	$v0, $a0	# $v0 := $a0
	lw 	$v1, 0($v0)	# $v1 := [$v0+0]
	lw 	$v0, 4($v0)	# $v0 := [$v0+4]
	add	$v0, $v1, $v0	# $v0 := $v1+$v0
				# $v0 := $v0
	move 	$ra, $t5	# $ra := $t5
	move 	$s0, $t4	# $s0 := $t4
	move 	$s1, $t3	# $s1 := $t3
	move 	$s2, $t2	# $s2 := $t2
	move 	$s3, $t1	# $s3 := $t1
	move 	$s4, $t0	# $s4 := $t0
	move 	$s5, $a3	# $s5 := $a3
	move 	$s6, $a2	# $s6 := $a2
	move 	$s7, $a1	# $s7 := $a1
_add.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_gt:
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
	slt	$v0, $t5, $a0	# $v0 := $t5<$a0
	beqz	$v0, L3   	# if (signed) $v0 == 0 goto L3
	seq	$a0, $t5, $a0	# $a0 := $t5==$a0
	li 	$v0, 0		# $v0 := 0
	seq	$v0, $a0, $v0	# $v0 := $a0==$v0
	beqz	$v0, L5   	# if (signed) $v0 == 0 goto L5
	li 	$v0, 1		# $v0 := 1
				# $v0 := $v0
	j 	L6		# goto L6
L5:
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
L6:
	move 	$a0, $v0	# $a0 := $v0
	j 	L4		# goto L4
L3:
	li 	$v0, 0		# $v0 := 0
	move 	$a0, $v0	# $a0 := $v0
L4:
	li 	$v0, 0		# $v0 := 0
	seq	$v0, $a0, $v0	# $v0 := $a0==$v0
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
_gt.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_test:
	move 	$x89, $ra	# $x89 := $ra
	move 	$x90, $s0	# $x90 := $s0
	move 	$x91, $s1	# $x91 := $s1
	move 	$x92, $s2	# $x92 := $s2
	move 	$x93, $s3	# $x93 := $s3
	move 	$x94, $s4	# $x94 := $s4
	move 	$x95, $s5	# $x95 := $s5
	move 	$x96, $s6	# $x96 := $s6
	move 	$x97, $s7	# $x97 := $s7
	move 	$x98, $a0	# $x98 := $a0
	lw 	$x99, 0($x98)	# $x99 := [$x98+0]
	lw 	$x100, 4($x98)	# $x100 := [$x98+4]
	lw 	$x101, 8($x98)	# $x101 := [$x98+8]
	lw 	$x102, 0($x101)	# $x102 := [$x101+0]
	seq	$x105, $x99, $x100	# $x105 := $x99==$x100
	li 	$x106, 0		# $x106 := 0
	seq	$x104, $x105, $x106	# $x104 := $x105==$x106
	beqz	$x104, L7   	# if (signed) $x104 == 0 goto L7
	la 	$x107, _printint	# $x107 := _printint
	move 	$a0, $x99	# $a0 := $x99
	jalr 	$ra, $x107	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	addi 	$v0, $x102, 1	# $v0 := $x102+1
	sw 	$v0, 0($x101)	# [$x101+0] := $v0
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	j 	L8		# goto L8
L7:
	la 	$x111, _printint	# $x111 := _printint
	move 	$a0, $x99	# $a0 := $x99
	jalr 	$ra, $x111	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
L8:
				# $v0 := $v0
	move 	$ra, $x89	# $ra := $x89
	move 	$s0, $x90	# $s0 := $x90
	move 	$s1, $x91	# $s1 := $x91
	move 	$s2, $x92	# $s2 := $x92
	move 	$s3, $x93	# $s3 := $x93
	move 	$s4, $x94	# $s4 := $x94
	move 	$s5, $x95	# $s5 := $x95
	move 	$s6, $x96	# $s6 := $x96
	move 	$s7, $x97	# $s7 := $x97
_test.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	move 	$x114, $ra	# $x114 := $ra
	move 	$x115, $s0	# $x115 := $s0
	move 	$x116, $s1	# $x116 := $s1
	move 	$x117, $s2	# $x117 := $s2
	move 	$x118, $s3	# $x118 := $s3
	move 	$x119, $s4	# $x119 := $s4
	move 	$x120, $s5	# $x120 := $s5
	move 	$x121, $s6	# $x121 := $s6
	move 	$x122, $s7	# $x122 := $s7
	move 	$v1, $a0	# $v1 := $a0
	li 	$x125, 0		# $x125 := 0
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x124, $v0	# $x124 := $v0
	sw 	$x125, 0($x124)	# [$x124+0] := $x125
	li 	$x126, 1		# $x126 := 1
	li 	$x127, 0		# $x127 := 0
	la 	$x128, _test	# $x128 := _test
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x129, $v0	# $x129 := $v0
	la 	$x130, _fact	# $x130 := _fact
	li 	$x131, 5		# $x131 := 5
	move 	$a0, $x131	# $a0 := $x131
	jalr 	$ra, $x130	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x132, $v0	# $x132 := $v0
	la 	$x133, _printint	# $x133 := _printint
	move 	$a0, $x132	# $a0 := $x132
	jalr 	$ra, $x133	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x134, $v0	# $x134 := $v0
	sw 	$x132, 0($x129)	# [$x129+0] := $x132
	li 	$x135, 120		# $x135 := 120
	sw 	$x135, 4($x129)	# [$x129+4] := $x135
	sw 	$x124, 8($x129)	# [$x129+8] := $x124
	move 	$a0, $x129	# $a0 := $x129
	jalr 	$ra, $x128	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x137, _test	# $x137 := _test
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x138, $v0	# $x138 := $v0
	beqz	$x126, L11   	# if (signed) $x126 == 0 goto L11
	beqz	$x126, L13   	# if (signed) $x126 == 0 goto L13
	li 	$x142, 1		# $x142 := 1
	move 	$x141, $x142	# $x141 := $x142
	j 	L14		# goto L14
L13:
	li 	$x143, 0		# $x143 := 0
	move 	$x141, $x143	# $x141 := $x143
L14:
	move 	$x140, $x141	# $x140 := $x141
	j 	L12		# goto L12
L11:
	li 	$x144, 0		# $x144 := 0
	move 	$x140, $x144	# $x140 := $x144
L12:
	beqz	$x140, L9   	# if (signed) $x140 == 0 goto L9
	beqz	$x126, L17   	# if (signed) $x126 == 0 goto L17
	li 	$x147, 1		# $x147 := 1
	move 	$x146, $x147	# $x146 := $x147
	j 	L18		# goto L18
L17:
	beqz	$x127, L19   	# if (signed) $x127 == 0 goto L19
	li 	$x149, 1		# $x149 := 1
	move 	$x148, $x149	# $x148 := $x149
	j 	L20		# goto L20
L19:
	li 	$x150, 0		# $x150 := 0
	move 	$x148, $x150	# $x148 := $x150
L20:
	move 	$x146, $x148	# $x146 := $x148
L18:
	beqz	$x146, L15   	# if (signed) $x146 == 0 goto L15
	beqz	$x127, L21   	# if (signed) $x127 == 0 goto L21
	li 	$x152, 1		# $x152 := 1
	move 	$x151, $x152	# $x151 := $x152
	j 	L22		# goto L22
L21:
	beqz	$x126, L23   	# if (signed) $x126 == 0 goto L23
	li 	$x154, 1		# $x154 := 1
	move 	$x153, $x154	# $x153 := $x154
	j 	L24		# goto L24
L23:
	li 	$x155, 0		# $x155 := 0
	move 	$x153, $x155	# $x153 := $x155
L24:
	move 	$x151, $x153	# $x151 := $x153
L22:
	move 	$x145, $x151	# $x145 := $x151
	j 	L16		# goto L16
L15:
	move 	$x145, $x127	# $x145 := $x127
L16:
	move 	$x139, $x145	# $x139 := $x145
	j 	L10		# goto L10
L9:
	beqz	$x127, L25   	# if (signed) $x127 == 0 goto L25
	li 	$x157, 1		# $x157 := 1
	move 	$x156, $x157	# $x156 := $x157
	j 	L26		# goto L26
L25:
	beqz	$x127, L27   	# if (signed) $x127 == 0 goto L27
	li 	$x159, 1		# $x159 := 1
	move 	$x158, $x159	# $x158 := $x159
	j 	L28		# goto L28
L27:
	li 	$x160, 0		# $x160 := 0
	move 	$x158, $x160	# $x158 := $x160
L28:
	move 	$x156, $x158	# $x156 := $x158
L26:
	move 	$x139, $x156	# $x139 := $x156
L10:
	sw 	$x139, 0($x138)	# [$x138+0] := $x139
	sw 	$x126, 4($x138)	# [$x138+4] := $x126
	sw 	$x124, 8($x138)	# [$x138+8] := $x124
	move 	$a0, $x138	# $a0 := $x138
	jalr 	$ra, $x137	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x162, _test	# $x162 := _test
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x163, $v0	# $x163 := $v0
	li 	$x166, 0		# $x166 := 0
	seq	$x165, $x127, $x166	# $x165 := $x127==$x166
	beqz	$x165, L29   	# if (signed) $x165 == 0 goto L29
	li 	$x167, 1		# $x167 := 1
	move 	$x164, $x167	# $x164 := $x167
	j 	L30		# goto L30
L29:
	beqz	$x126, L31   	# if (signed) $x126 == 0 goto L31
	li 	$x169, 1		# $x169 := 1
	move 	$x168, $x169	# $x168 := $x169
	j 	L32		# goto L32
L31:
	li 	$x170, 0		# $x170 := 0
	move 	$x168, $x170	# $x168 := $x170
L32:
	move 	$x164, $x168	# $x164 := $x168
L30:
	sw 	$x164, 0($x163)	# [$x163+0] := $x164
	sw 	$x126, 4($x163)	# [$x163+4] := $x126
	sw 	$x124, 8($x163)	# [$x163+8] := $x124
	move 	$a0, $x163	# $a0 := $x163
	jalr 	$ra, $x162	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x172, _test	# $x172 := _test
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x173, $v0	# $x173 := $v0
	li 	$x177, 0		# $x177 := 0
	seq	$x176, $x126, $x177	# $x176 := $x126==$x177
	li 	$x178, 0		# $x178 := 0
	seq	$x175, $x176, $x178	# $x175 := $x176==$x178
	li 	$x179, 0		# $x179 := 0
	seq	$x174, $x175, $x179	# $x174 := $x175==$x179
	sw 	$x174, 0($x173)	# [$x173+0] := $x174
	sw 	$x127, 4($x173)	# [$x173+4] := $x127
	sw 	$x124, 8($x173)	# [$x173+8] := $x124
	move 	$a0, $x173	# $a0 := $x173
	jalr 	$ra, $x172	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x181, _test	# $x181 := _test
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x182, $v0	# $x182 := $v0
	li 	$x184, 3		# $x184 := 3
	li 	$x187, 1		# $x187 := 1
	neg	$x186, $x187	# $x186 := -$x187
	li 	$x188, 2		# $x188 := 2
	mulo	$x185, $x186, $x188	# $x185 := $x186*$x188
	sub	$x183, $x185, $x184	# $x183 := $x185-$x184
	sw 	$x183, 0($x182)	# [$x182+0] := $x183
	li 	$x190, 5		# $x190 := 5
	neg	$x189, $x190	# $x189 := -$x190
	sw 	$x189, 4($x182)	# [$x182+4] := $x189
	sw 	$x124, 8($x182)	# [$x182+8] := $x124
	move 	$a0, $x182	# $a0 := $x182
	jalr 	$ra, $x181	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x192, _test	# $x192 := _test
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x193, $v0	# $x193 := $v0
	li 	$x196, 7		# $x196 := 7
	li 	$x197, 3		# $x197 := 3
	mulo	$x195, $x196, $x197	# $x195 := $x196*$x197
	li 	$x201, 1		# $x201 := 1
	neg	$x200, $x201	# $x200 := -$x201
	li 	$x203, 5		# $x203 := 5
	neg	$x202, $x203	# $x202 := -$x203
	mulo	$x199, $x200, $x202	# $x199 := $x200*$x202
	addi 	$x198, $x199, 2	# $x198 := $x199+2
	sub	$x194, $x198, $x195	# $x194 := $x198-$x195
	sw 	$x194, 0($x193)	# [$x193+0] := $x194
	li 	$x205, 14		# $x205 := 14
	neg	$x204, $x205	# $x204 := -$x205
	sw 	$x204, 4($x193)	# [$x193+4] := $x204
	sw 	$x124, 8($x193)	# [$x193+8] := $x124
	move 	$a0, $x193	# $a0 := $x193
	jalr 	$ra, $x192	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x207, _test	# $x207 := _test
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x208, $v0	# $x208 := $v0
	li 	$x210, 0		# $x210 := 0
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x209, $v0	# $x209 := $v0
	sw 	$x210, 0($x209)	# [$x209+0] := $x210
	li 	$x212, 10		# $x212 := 10
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x211, $v0	# $x211 := $v0
	sw 	$x212, 0($x211)	# [$x211+0] := $x212
L33:
	lw 	$x214, 0($x211)	# $x214 := [$x211+0]
	beqz	$x214, L34   	# if (signed) $x214 == 0 goto L34
	lw 	$x215, 0($x211)	# $x215 := [$x211+0]
	li 	$x217, 1		# $x217 := 1
	sub	$x216, $x215, $x217	# $x216 := $x215-$x217
	sw 	$x216, 0($x211)	# [$x211+0] := $x216
	lw 	$x218, 0($x209)	# $x218 := [$x209+0]
	add	$x219, $x218, $x215	# $x219 := $x218+$x215
	sw 	$x219, 0($x209)	# [$x209+0] := $x219
	move 	$x213, $x209	# $x213 := $x209
	j 	L33		# goto L33
L34:
	lw 	$x220, 0($x209)	# $x220 := [$x209+0]
	sw 	$x220, 0($x208)	# [$x208+0] := $x220
	li 	$x221, 55		# $x221 := 55
	sw 	$x221, 4($x208)	# [$x208+4] := $x221
	sw 	$x124, 8($x208)	# [$x208+8] := $x124
	move 	$a0, $x208	# $a0 := $x208
	jalr 	$ra, $x207	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x223, _test	# $x223 := _test
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x224, $v0	# $x224 := $v0
	li 	$x225, 1		# $x225 := 1
	li 	$x227, 2		# $x227 := 2
	sub	$x226, $x225, $x227	# $x226 := $x225-$x227
	addi 	$x228, $x225, 2	# $x228 := $x225+2
	sw 	$x228, 0($x224)	# [$x224+0] := $x228
	li 	$x229, 3		# $x229 := 3
	sw 	$x229, 4($x224)	# [$x224+4] := $x229
	sw 	$x124, 8($x224)	# [$x224+8] := $x124
	move 	$a0, $x224	# $a0 := $x224
	jalr 	$ra, $x223	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x231, _test	# $x231 := _test
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x232, $v0	# $x232 := $v0
	la 	$x234, _int	# $x234 := _int
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x235, $v0	# $x235 := $v0
	li 	$x236, 1		# $x236 := 1
	sw 	$x236, 0($x235)	# [$x235+0] := $x236
	move 	$a0, $x235	# $a0 := $x235
	jalr 	$ra, $x234	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x237, $v0	# $x237 := $v0
	la 	$x238, _int	# $x238 := _int
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x239, $v0	# $x239 := $v0
	li 	$x240, 2		# $x240 := 2
	sw 	$x240, 0($x239)	# [$x239+0] := $x240
	move 	$a0, $x239	# $a0 := $x239
	jalr 	$ra, $x238	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x241, $v0	# $x241 := $v0
	add	$x233, $x237, $x241	# $x233 := $x237+$x241
	li 	$x244, 6		# $x244 := 6
	li 	$x245, 2		# $x245 := 2
	mulo	$x243, $x244, $x245	# $x243 := $x244*$x245
	add	$x242, $x233, $x243	# $x242 := $x233+$x243
	sw 	$x242, 0($x232)	# [$x232+0] := $x242
	li 	$x246, 15		# $x246 := 15
	sw 	$x246, 4($x232)	# [$x232+4] := $x246
	sw 	$x124, 8($x232)	# [$x232+8] := $x124
	move 	$a0, $x232	# $a0 := $x232
	jalr 	$ra, $x231	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x248, _test	# $x248 := _test
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x249, $v0	# $x249 := $v0
	li 	$x250, 16		# $x250 := 16
	la 	$x251, _foo	# $x251 := _foo
	move 	$a0, $x250	# $a0 := $x250
	jalr 	$ra, $x251	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x252, $v0	# $x252 := $v0
	lw 	$x253, 0($x252)	# $x253 := [$x252+0]
	sw 	$x253, 0($x249)	# [$x249+0] := $x253
	li 	$x254, 16		# $x254 := 16
	sw 	$x254, 4($x249)	# [$x249+4] := $x254
	sw 	$x124, 8($x249)	# [$x249+8] := $x124
	move 	$a0, $x249	# $a0 := $x249
	jalr 	$ra, $x248	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x256, _test	# $x256 := _test
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x257, $v0	# $x257 := $v0
	li 	$x259, 0		# $x259 := 0
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x258, $v0	# $x258 := $v0
	sw 	$x259, 0($x258)	# [$x258+0] := $x259
	li 	$x260, 1		# $x260 := 1
	sw 	$x260, 0($x258)	# [$x258+0] := $x260
	li 	$x261, 2		# $x261 := 2
	sw 	$x261, 0($x258)	# [$x258+0] := $x261
	li 	$x262, 3		# $x262 := 3
	sw 	$x262, 0($x258)	# [$x258+0] := $x262
	li 	$x263, 4		# $x263 := 4
	sw 	$x263, 0($x258)	# [$x258+0] := $x263
	lw 	$x264, 0($x258)	# $x264 := [$x258+0]
	sw 	$x264, 0($x257)	# [$x257+0] := $x264
	li 	$x265, 4		# $x265 := 4
	sw 	$x265, 4($x257)	# [$x257+4] := $x265
	sw 	$x124, 8($x257)	# [$x257+8] := $x124
	move 	$a0, $x257	# $a0 := $x257
	jalr 	$ra, $x256	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x267, _test	# $x267 := _test
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x268, $v0	# $x268 := $v0
	li 	$x273, 1		# $x273 := 1
	neg	$x272, $x273	# $x272 := -$x273
	neg	$x271, $x272	# $x271 := -$x272
	neg	$x270, $x271	# $x270 := -$x271
	addi 	$x269, $x270, 1	# $x269 := $x270+1
	sw 	$x269, 0($x268)	# [$x268+0] := $x269
	li 	$x274, 0		# $x274 := 0
	sw 	$x274, 4($x268)	# [$x268+4] := $x274
	sw 	$x124, 8($x268)	# [$x268+8] := $x124
	move 	$a0, $x268	# $a0 := $x268
	jalr 	$ra, $x267	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x276, _test	# $x276 := _test
	li 	$a0, 12		# $a0 := 12
	jal 	alloc		# call alloc
	move 	$x277, $v0	# $x277 := $v0
	li 	$v1, 5		# $v1 := 5
	addi 	$a0, $v1, 3	# $a0 := $v1+3
	li 	$v1, 7		# $v1 := 7
	mulo	$x278, $a0, $v1	# $x278 := $a0*$v1
	addi 	$x282, $x278, 7	# $x282 := $x278+7
	la 	$x284, _gt	# $x284 := _gt
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x285, $v0	# $x285 := $v0
	sw 	$x278, 0($x285)	# [$x285+0] := $x278
	li 	$x286, 0		# $x286 := 0
	sw 	$x286, 4($x285)	# [$x285+4] := $x286
	move 	$a0, $x285	# $a0 := $x285
	jalr 	$ra, $x284	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x287, $v0	# $x287 := $v0
	beqz	$x287, L35   	# if (signed) $x287 == 0 goto L35
	li 	$x291, 7		# $x291 := 7
	seq	$x290, $x278, $x291	# $x290 := $x278==$x291
	li 	$x292, 0		# $x292 := 0
	seq	$x289, $x290, $x292	# $x289 := $x290==$x292
	beqz	$x289, L37   	# if (signed) $x289 == 0 goto L37
	la 	$x293, _addsome	# $x293 := _addsome
	la 	$x294, _add	# $x294 := _add
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x295, $v0	# $x295 := $v0
	sw 	$x278, 0($x295)	# [$x295+0] := $x278
	sw 	$x282, 4($x295)	# [$x295+4] := $x282
	move 	$a0, $x295	# $a0 := $x295
	jalr 	$ra, $x294	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x296, $v0	# $x296 := $v0
	move 	$a0, $x296	# $a0 := $x296
	jalr 	$ra, $x293	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x297, $v0	# $x297 := $v0
	move 	$x288, $x297	# $x288 := $x297
	j 	L38		# goto L38
L37:
	li 	$x299, 1		# $x299 := 1
	neg	$x298, $x299	# $x298 := -$x299
	move 	$x288, $x298	# $x288 := $x298
L38:
	move 	$x283, $x288	# $x283 := $x288
	j 	L36		# goto L36
L35:
	li 	$x302, 2		# $x302 := 2
	neg	$x301, $x302	# $x301 := -$x302
	beqz	$x301, L39   	# if (signed) $x301 == 0 goto L39
	li 	$x303, 0		# $x303 := 0
	move 	$x300, $x303	# $x300 := $x303
	j 	L40		# goto L40
L39:
	li 	$x304, 1		# $x304 := 1
	move 	$x300, $x304	# $x300 := $x304
L40:
	move 	$x283, $x300	# $x283 := $x300
L36:
	sw 	$x283, 0($x277)	# [$x277+0] := $x283
	li 	$x305, 124		# $x305 := 124
	sw 	$x305, 4($x277)	# [$x277+4] := $x305
	sw 	$x124, 8($x277)	# [$x277+8] := $x124
	move 	$a0, $x277	# $a0 := $x277
	jalr 	$ra, $x276	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	lw 	$v0, 0($x124)	# $v0 := [$x124+0]
				# $v0 := $v0
	move 	$ra, $x114	# $ra := $x114
	move 	$s0, $x115	# $s0 := $x115
	move 	$s1, $x116	# $s1 := $x116
	move 	$s2, $x117	# $s2 := $x117
	move 	$s3, $x118	# $s3 := $x118
	move 	$s4, $x119	# $s4 := $x119
	move 	$s5, $x120	# $s5 := $x120
	move 	$s6, $x121	# $s6 := $x121
	move 	$s7, $x122	# $s7 := $x122
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
