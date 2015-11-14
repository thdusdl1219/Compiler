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
	move 	$v1, $ra	# $v1 := $ra
	move 	$a1, $s0	# $a1 := $s0
	move 	$a2, $s1	# $a2 := $s1
	move 	$a3, $s2	# $a3 := $s2
	move 	$t0, $s3	# $t0 := $s3
	move 	$t1, $s4	# $t1 := $s4
	move 	$t2, $s5	# $t2 := $s5
	move 	$t3, $s6	# $t3 := $s6
	move 	$t4, $s7	# $t4 := $s7
	move 	$v0, $a0	# $v0 := $a0
	li 	$a0, 5		# $a0 := 5
	li 	$t5, 3		# $t5 := 3
	mulo	$a0, $a0, $t5	# $a0 := $a0*$t5
	add	$a0, $v0, $a0	# $a0 := $v0+$a0
	li 	$t5, 1		# $t5 := 1
	neg	$t5, $t5	# $t5 := -$t5
	sub	$a0, $a0, $t5	# $a0 := $a0-$t5
	li 	$t5, 16		# $t5 := 16
	sub	$a0, $a0, $t5	# $a0 := $a0-$t5
	li 	$t5, 10		# $t5 := 10
	slt	$t5, $a0, $t5	# $t5 := $a0<$t5
	beqz	$t5, L5   	# if (signed) $t5 == 0 goto L5
	li 	$t5, 1		# $t5 := 1
				# $t5 := $t5
	j 	L6		# goto L6
L5:
	li 	$t5, 10		# $t5 := 10
	slt	$t5, $a0, $t5	# $t5 := $a0<$t5
	li 	$t6, 0		# $t6 := 0
	seq	$t5, $t5, $t6	# $t5 := $t5==$t6
	beqz	$t5, L7   	# if (signed) $t5 == 0 goto L7
	li 	$t5, 1		# $t5 := 1
				# $t5 := $t5
	j 	L8		# goto L8
L7:
	li 	$t5, 0		# $t5 := 0
				# $t5 := $t5
L8:
				# $t5 := $t5
L6:
	beqz	$t5, L3   	# if (signed) $t5 == 0 goto L3
	seq	$a0, $v0, $a0	# $a0 := $v0==$a0
	beqz	$a0, L9   	# if (signed) $a0 == 0 goto L9
	li 	$a0, 1		# $a0 := 1
				# $a0 := $a0
	j 	L10		# goto L10
L9:
	li 	$a0, 0		# $a0 := 0
				# $a0 := $a0
L10:
				# $a0 := $a0
	j 	L4		# goto L4
L3:
	li 	$a0, 0		# $a0 := 0
				# $a0 := $a0
L4:
	beqz	$a0, L1   	# if (signed) $a0 == 0 goto L1
				# $v0 := $v0
	j 	L2		# goto L2
L1:
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
L2:
				# $v0 := $v0
	move 	$ra, $v1	# $ra := $v1
	move 	$s0, $a1	# $s0 := $a1
	move 	$s1, $a2	# $s1 := $a2
	move 	$s2, $a3	# $s2 := $a3
	move 	$s3, $t0	# $s3 := $t0
	move 	$s4, $t1	# $s4 := $t1
	move 	$s5, $t2	# $s5 := $t2
	move 	$s6, $t3	# $s6 := $t3
	move 	$s7, $t4	# $s7 := $t4
_int_ops.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_dec_ref:
	move 	$v1, $ra	# $v1 := $ra
	move 	$a1, $s0	# $a1 := $s0
	move 	$a2, $s1	# $a2 := $s1
	move 	$a3, $s2	# $a3 := $s2
	move 	$t0, $s3	# $t0 := $s3
	move 	$t1, $s4	# $t1 := $s4
	move 	$t2, $s5	# $t2 := $s5
	move 	$t3, $s6	# $t3 := $s6
	move 	$t4, $s7	# $t4 := $s7
	move 	$v0, $a0	# $v0 := $a0
	lw 	$a0, 0($v0)	# $a0 := [$v0+0]
	li 	$t5, 1		# $t5 := 1
	sub	$a0, $a0, $t5	# $a0 := $a0-$t5
	sw 	$a0, 0($v0)	# [$v0+0] := $a0
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	move 	$ra, $v1	# $ra := $v1
	move 	$s0, $a1	# $s0 := $a1
	move 	$s1, $a2	# $s1 := $a2
	move 	$s2, $a3	# $s2 := $a3
	move 	$s3, $t0	# $s3 := $t0
	move 	$s4, $t1	# $s4 := $t1
	move 	$s5, $t2	# $s5 := $t2
	move 	$s6, $t3	# $s6 := $t3
	move 	$s7, $t4	# $s7 := $t4
_dec_ref.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_fact:
	move 	$x53, $ra	# $x53 := $ra
	move 	$x54, $s0	# $x54 := $s0
	move 	$x55, $s1	# $x55 := $s1
	move 	$x56, $s2	# $x56 := $s2
	move 	$x57, $s3	# $x57 := $s3
	move 	$x58, $s4	# $x58 := $s4
	move 	$x59, $s5	# $x59 := $s5
	move 	$x60, $s6	# $x60 := $s6
	move 	$x61, $s7	# $x61 := $s7
	move 	$x62, $a0	# $x62 := $a0
	lw 	$x65, 0($x62)	# $x65 := [$x62+0]
	li 	$x66, 1		# $x66 := 1
	slt	$x64, $x65, $x66	# $x64 := $x65<$x66
	beqz	$x64, L11   	# if (signed) $x64 == 0 goto L11
	li 	$v0, 1		# $v0 := 1
				# $v0 := $v0
	j 	L12		# goto L12
L11:
	lw 	$x68, 0($x62)	# $x68 := [$x62+0]
	la 	$x69, _dec_ref	# $x69 := _dec_ref
	move 	$a0, $x62	# $a0 := $x62
	jalr 	$ra, $x69	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x70, $v0	# $x70 := $v0
	la 	$x72, _fact	# $x72 := _fact
	move 	$a0, $x62	# $a0 := $x62
	jalr 	$ra, $x72	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	mulo	$v0, $x68, $v0	# $v0 := $x68*$v0
				# $v0 := $v0
L12:
				# $v0 := $v0
	move 	$ra, $x53	# $ra := $x53
	move 	$s0, $x54	# $s0 := $x54
	move 	$s1, $x55	# $s1 := $x55
	move 	$s2, $x56	# $s2 := $x56
	move 	$s3, $x57	# $s3 := $x57
	move 	$s4, $x58	# $s4 := $x58
	move 	$s5, $x59	# $s5 := $x59
	move 	$s6, $x60	# $s6 := $x60
	move 	$s7, $x61	# $s7 := $x61
_fact.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_add_pair:
	move 	$v1, $ra	# $v1 := $ra
	move 	$a1, $s0	# $a1 := $s0
	move 	$a2, $s1	# $a2 := $s1
	move 	$a3, $s2	# $a3 := $s2
	move 	$t0, $s3	# $t0 := $s3
	move 	$t1, $s4	# $t1 := $s4
	move 	$t2, $s5	# $t2 := $s5
	move 	$t3, $s6	# $t3 := $s6
	move 	$t4, $s7	# $t4 := $s7
	move 	$v0, $a0	# $v0 := $a0
	lw 	$a0, 0($v0)	# $a0 := [$v0+0]
	lw 	$v0, 4($v0)	# $v0 := [$v0+4]
	add	$v0, $a0, $v0	# $v0 := $a0+$v0
				# $v0 := $v0
	move 	$ra, $v1	# $ra := $v1
	move 	$s0, $a1	# $s0 := $a1
	move 	$s1, $a2	# $s1 := $a2
	move 	$s2, $a3	# $s2 := $a3
	move 	$s3, $t0	# $s3 := $t0
	move 	$s4, $t1	# $s4 := $t1
	move 	$s5, $t2	# $s5 := $t2
	move 	$s6, $t3	# $s6 := $t3
	move 	$s7, $t4	# $s7 := $t4
_add_pair.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_add_pair_silly:
	move 	$v1, $ra	# $v1 := $ra
	move 	$a1, $s0	# $a1 := $s0
	move 	$a2, $s1	# $a2 := $s1
	move 	$a3, $s2	# $a3 := $s2
	move 	$t0, $s3	# $t0 := $s3
	move 	$t1, $s4	# $t1 := $s4
	move 	$t2, $s5	# $t2 := $s5
	move 	$t3, $s6	# $t3 := $s6
	move 	$t4, $s7	# $t4 := $s7
	move 	$v0, $a0	# $v0 := $a0
	la 	$v0, _add_pair	# $v0 := _add_pair
				# $v0 := $v0
	move 	$ra, $v1	# $ra := $v1
	move 	$s0, $a1	# $s0 := $a1
	move 	$s1, $a2	# $s1 := $a2
	move 	$s2, $a3	# $s2 := $a3
	move 	$s3, $t0	# $s3 := $t0
	move 	$s4, $t1	# $s4 := $t1
	move 	$s5, $t2	# $s5 := $t2
	move 	$s6, $t3	# $s6 := $t3
	move 	$s7, $t4	# $s7 := $t4
_add_pair_silly.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_loop:
	move 	$x98, $ra	# $x98 := $ra
	move 	$x99, $s0	# $x99 := $s0
	move 	$x100, $s1	# $x100 := $s1
	move 	$x101, $s2	# $x101 := $s2
	move 	$x102, $s3	# $x102 := $s3
	move 	$x103, $s4	# $x103 := $s4
	move 	$x104, $s5	# $x104 := $s5
	move 	$x105, $s6	# $x105 := $s6
	move 	$x106, $s7	# $x106 := $s7
	move 	$x107, $a0	# $x107 := $a0
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
				# $v0 := $v0
	sw 	$x107, 0($v0)	# [$v0+0] := $x107
L13:
	lw 	$v1, 0($v0)	# $v1 := [$v0+0]
	li 	$a0, 701		# $a0 := 701
	slt	$v1, $v1, $a0	# $v1 := $v1<$a0
	li 	$a0, 0		# $a0 := 0
	seq	$v1, $v1, $a0	# $v1 := $v1==$a0
	beqz	$v1, L14   	# if (signed) $v1 == 0 goto L14
	li 	$v1, 1		# $v1 := 1
	lw 	$a0, 0($v0)	# $a0 := [$v0+0]
	sub	$v1, $a0, $v1	# $v1 := $a0-$v1
	sw 	$v1, 0($v0)	# [$v0+0] := $v1
	move 	$v1, $v0	# $v1 := $v0
	j 	L13		# goto L13
L14:
	lw 	$v0, 0($v0)	# $v0 := [$v0+0]
				# $v0 := $v0
	move 	$ra, $x98	# $ra := $x98
	move 	$s0, $x99	# $s0 := $x99
	move 	$s1, $x100	# $s1 := $x100
	move 	$s2, $x101	# $s2 := $x101
	move 	$s3, $x102	# $s3 := $x102
	move 	$s4, $x103	# $s4 := $x103
	move 	$s5, $x104	# $s5 := $x104
	move 	$s6, $x105	# $s6 := $x105
	move 	$s7, $x106	# $s7 := $x106
_loop.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	move 	$x119, $ra	# $x119 := $ra
	move 	$x120, $s0	# $x120 := $s0
	move 	$x121, $s1	# $x121 := $s1
	move 	$x122, $s2	# $x122 := $s2
	move 	$x123, $s3	# $x123 := $s3
	move 	$x124, $s4	# $x124 := $s4
	move 	$x125, $s5	# $x125 := $s5
	move 	$x126, $s6	# $x126 := $s6
	move 	$x127, $s7	# $x127 := $s7
	move 	$x128, $a0	# $x128 := $a0
	la 	$x129, _int_ops	# $x129 := _int_ops
	la 	$x130, _add_pair_silly	# $x130 := _add_pair_silly
	li 	$x131, 0		# $x131 := 0
	move 	$a0, $x131	# $a0 := $x131
	jalr 	$ra, $x130	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x132, $v0	# $x132 := $v0
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x133, $v0	# $x133 := $v0
	li 	$x134, 2		# $x134 := 2
	sw 	$x134, 0($x133)	# [$x133+0] := $x134
	li 	$x135, 4		# $x135 := 4
	sw 	$x135, 4($x133)	# [$x133+4] := $x135
	move 	$a0, $x133	# $a0 := $x133
	jalr 	$ra, $x132	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x136, $v0	# $x136 := $v0
	move 	$a0, $x136	# $a0 := $x136
	jalr 	$ra, $x129	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x137, $v0	# $x137 := $v0
	la 	$x138, _fact	# $x138 := _fact
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x139, $v0	# $x139 := $v0
	sw 	$x137, 0($x139)	# [$x139+0] := $x137
	move 	$a0, $x139	# $a0 := $x139
	jalr 	$ra, $x138	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x140, $v0	# $x140 := $v0
	la 	$x141, _loop	# $x141 := _loop
	move 	$a0, $x140	# $a0 := $x140
	jalr 	$ra, $x141	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x142, $v0	# $x142 := $v0
	la 	$x143, _printint	# $x143 := _printint
	move 	$a0, $x142	# $a0 := $x142
	jalr 	$ra, $x143	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	move 	$v0, $x142	# $v0 := $x142
	move 	$ra, $x119	# $ra := $x119
	move 	$s0, $x120	# $s0 := $x120
	move 	$s1, $x121	# $s1 := $x121
	move 	$s2, $x122	# $s2 := $x122
	move 	$s3, $x123	# $s3 := $x123
	move 	$s4, $x124	# $s4 := $x124
	move 	$s5, $x125	# $s5 := $x125
	move 	$s6, $x126	# $s6 := $x126
	move 	$s7, $x127	# $s7 := $x127
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
