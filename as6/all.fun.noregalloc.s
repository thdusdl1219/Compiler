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
_int_ops:
	li 	$x13, 5		# $x13 := 5
	li 	$x14, 3		# $x14 := 3
	mulo	$x12, $x13, $x14	# $x12 := $x13*$x14
	add	$x11, $x10, $x12	# $x11 := $x10+$x12
	li 	$x17, 0		# $x17 := 0
	li 	$x18, 1		# $x18 := 1
	sub	$x16, $x17, $x18	# $x16 := $x17-$x18
	sub	$x15, $x11, $x16	# $x15 := $x11-$x16
	li 	$x20, 16		# $x20 := 16
	sub	$x19, $x15, $x20	# $x19 := $x15-$x20
	li 	$x22, 10		# $x22 := 10
	slt	$x21, $x19, $x22	# $x21 := $x19<$x22
	beqz	$x21, L1   	# if (signed) $x21 == 0 goto L1
	li 	$x24, 1		# $x24 := 1
	move 	$x23, $x24	# $x23 := $x24
	j 	L2		# goto L2
L1:
	li 	$x27, 10		# $x27 := 10
	slt	$x26, $x19, $x27	# $x26 := $x19<$x27
	li 	$x28, 0		# $x28 := 0
	seq	$x25, $x26, $x28	# $x25 := $x26==$x28
	beqz	$x25, L3   	# if (signed) $x25 == 0 goto L3
	li 	$x30, 1		# $x30 := 1
	move 	$x29, $x30	# $x29 := $x30
	j 	L4		# goto L4
L3:
	li 	$x31, 0		# $x31 := 0
	move 	$x29, $x31	# $x29 := $x31
L4:
	move 	$x23, $x29	# $x23 := $x29
L2:
	beqz	$x23, L5   	# if (signed) $x23 == 0 goto L5
	seq	$x33, $x10, $x19	# $x33 := $x10==$x19
	beqz	$x33, L7   	# if (signed) $x33 == 0 goto L7
	li 	$x35, 1		# $x35 := 1
	move 	$x34, $x35	# $x34 := $x35
	j 	L8		# goto L8
L7:
	li 	$x36, 0		# $x36 := 0
	move 	$x34, $x36	# $x34 := $x36
L8:
	move 	$x32, $x34	# $x32 := $x34
	j 	L6		# goto L6
L5:
	li 	$x37, 0		# $x37 := 0
	move 	$x32, $x37	# $x32 := $x37
L6:
	beqz	$x32, L9   	# if (signed) $x32 == 0 goto L9
	move 	$x38, $x10	# $x38 := $x10
	j 	L10		# goto L10
L9:
	li 	$x39, 0		# $x39 := 0
	move 	$x38, $x39	# $x38 := $x39
L10:
	move 	$v0, $x38	# $v0 := $x38
_int_ops.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_dec_ref:
	lw 	$x50, 0($x49)	# $x50 := [$x49+0]
	li 	$x52, 1		# $x52 := 1
	sub	$x51, $x50, $x52	# $x51 := $x50-$x52
	sw 	$x51, 0($x49)	# [$x49+0] := $x51
	li 	$x53, 0		# $x53 := 0
	move 	$v0, $x53	# $v0 := $x53
_dec_ref.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_fact:
	lw 	$x65, 0($x63)	# $x65 := [$x63+0]
	li 	$x66, 1		# $x66 := 1
	slt	$x64, $x65, $x66	# $x64 := $x65<$x66
	beqz	$x64, L11   	# if (signed) $x64 == 0 goto L11
	li 	$x68, 1		# $x68 := 1
	move 	$x67, $x68	# $x67 := $x68
	j 	L12		# goto L12
L11:
	lw 	$x69, 0($x63)	# $x69 := [$x63+0]
	la 	$x70, _dec_ref	# $x70 := _dec_ref
	move 	$a0, $x63	# $a0 := $x63
	jalr 	$ra, $x70	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x71, $v0	# $x71 := $v0
	la 	$x73, _fact	# $x73 := _fact
	move 	$a0, $x63	# $a0 := $x63
	jalr 	$ra, $x73	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x74, $v0	# $x74 := $v0
	mulo	$x72, $x69, $x74	# $x72 := $x69*$x74
	move 	$x67, $x72	# $x67 := $x72
L12:
	move 	$v0, $x67	# $v0 := $x67
_fact.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_add_pair:
	lw 	$x85, 0($x84)	# $x85 := [$x84+0]
	lw 	$x86, 4($x84)	# $x86 := [$x84+4]
	add	$x87, $x85, $x86	# $x87 := $x85+$x86
	move 	$v0, $x87	# $v0 := $x87
_add_pair.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_add_pair_silly:
	la 	$x98, _add_pair	# $x98 := _add_pair
	move 	$v0, $x98	# $v0 := $x98
_add_pair_silly.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_loop:
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x109, $v0	# $x109 := $v0
	sw 	$x108, 0($x109)	# [$x109+0] := $x108
	lw 	$x112, 0($x109)	# $x112 := [$x109+0]
	li 	$x113, 701		# $x113 := 701
	slt	$x111, $x112, $x113	# $x111 := $x112<$x113
	li 	$x114, 0		# $x114 := 0
	seq	$x110, $x111, $x114	# $x110 := $x111==$x114
L13:
	beqz	$x110, L14   	# if (signed) $x110 == 0 goto L14
	lw 	$x117, 0($x109)	# $x117 := [$x109+0]
	li 	$x118, 1		# $x118 := 1
	sub	$x116, $x117, $x118	# $x116 := $x117-$x118
	sw 	$x116, 0($x109)	# [$x109+0] := $x116
	move 	$x115, $x109	# $x115 := $x109
	j 	L13		# goto L13
L14:
	lw 	$x119, 0($x109)	# $x119 := [$x109+0]
	move 	$v0, $x119	# $v0 := $x119
_loop.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	la 	$x130, _int_ops	# $x130 := _int_ops
	la 	$x131, _add_pair_silly	# $x131 := _add_pair_silly
	li 	$x132, 0		# $x132 := 0
	move 	$a0, $x132	# $a0 := $x132
	jalr 	$ra, $x131	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x133, $v0	# $x133 := $v0
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x134, $v0	# $x134 := $v0
	li 	$x135, 2		# $x135 := 2
	sw 	$x135, 0($x134)	# [$x134+0] := $x135
	li 	$x136, 4		# $x136 := 4
	sw 	$x136, 4($x134)	# [$x134+4] := $x136
	move 	$a0, $x134	# $a0 := $x134
	jalr 	$ra, $x133	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x137, $v0	# $x137 := $v0
	move 	$a0, $x137	# $a0 := $x137
	jalr 	$ra, $x130	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x138, $v0	# $x138 := $v0
	la 	$x139, _fact	# $x139 := _fact
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x140, $v0	# $x140 := $v0
	sw 	$x138, 0($x140)	# [$x140+0] := $x138
	move 	$a0, $x140	# $a0 := $x140
	jalr 	$ra, $x139	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x141, $v0	# $x141 := $v0
	la 	$x142, _loop	# $x142 := _loop
	move 	$a0, $x141	# $a0 := $x141
	jalr 	$ra, $x142	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x143, $v0	# $x143 := $v0
	la 	$x144, _printint	# $x144 := _printint
	move 	$a0, $x143	# $a0 := $x143
	jalr 	$ra, $x144	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x145, $v0	# $x145 := $v0
	move 	$v0, $x143	# $v0 := $x143
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
