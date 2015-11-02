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
	li 	$x17, 1		# $x17 := 1
	neg	$x16, $x17	# $x16 := -$x17
	sub	$x15, $x11, $x16	# $x15 := $x11-$x16
	li 	$x19, 16		# $x19 := 16
	sub	$x18, $x15, $x19	# $x18 := $x15-$x19
	li 	$x23, 10		# $x23 := 10
	slt	$x22, $x18, $x23	# $x22 := $x18<$x23
	li 	$x26, 10		# $x26 := 10
	slt	$x25, $x18, $x26	# $x25 := $x18<$x26
	not	$x24, $x25	# $x24 := ~$x25
	or	$x21, $x22, $x24	# $x21 := $x22|$x24
	seq	$x27, $x10, $x18	# $x27 := $x10==$x18
	and	$x20, $x21, $x27	# $x20 := $x21&$x27
	move 	$x28, $zero	# $x28 := $zero
	beqz	$x20, L1   	# if (signed) $x20 == 0 goto L1
	move 	$x28, $x10	# $x28 := $x10
L1:
	move 	$v0, $x28	# $v0 := $x28
_int_ops.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_dec_ref:
	lw 	$x39, 0($x38)	# $x39 := [$x38+0]
	li 	$x41, 1		# $x41 := 1
	sub	$x40, $x39, $x41	# $x40 := $x39-$x41
	sw 	$x40, 0($x38)	# [$x38+0] := $x40
	li 	$x42, 0		# $x42 := 0
	move 	$v0, $x42	# $v0 := $x42
_dec_ref.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_fact:
	lw 	$x54, 0($x52)	# $x54 := [$x52+0]
	li 	$x55, 1		# $x55 := 1
	slt	$x53, $x54, $x55	# $x53 := $x54<$x55
	beqz	$x53, L2   	# if (signed) $x53 == 0 goto L2
	li 	$x57, 1		# $x57 := 1
	move 	$x56, $x57	# $x56 := $x57
	j 	L3		# goto L3
L2:
	lw 	$x58, 0($x52)	# $x58 := [$x52+0]
	la 	$x59, _dec_ref	# $x59 := _dec_ref
	move 	$a0, $x52	# $a0 := $x52
	jalr 	$ra, $x59	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x60, $v0	# $x60 := $v0
	la 	$x62, _fact	# $x62 := _fact
	move 	$a0, $x52	# $a0 := $x52
	jalr 	$ra, $x62	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x63, $v0	# $x63 := $v0
	mulo	$x61, $x58, $x63	# $x61 := $x58*$x63
	move 	$x56, $x61	# $x56 := $x61
L3:
	move 	$v0, $x56	# $v0 := $x56
_fact.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_add_pair:
	lw 	$x74, 0($x73)	# $x74 := [$x73+0]
	lw 	$x75, 4($x73)	# $x75 := [$x73+4]
	add	$x76, $x74, $x75	# $x76 := $x74+$x75
	move 	$v0, $x76	# $v0 := $x76
_add_pair.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_add_pair_silly:
	la 	$x87, _add_pair	# $x87 := _add_pair
	move 	$v0, $x87	# $v0 := $x87
_add_pair_silly.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_loop:
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x98, $v0	# $x98 := $v0
	sw 	$x97, 0($x98)	# [$x98+0] := $x97
	lw 	$x101, 0($x98)	# $x101 := [$x98+0]
	li 	$x102, 701		# $x102 := 701
	slt	$x100, $x101, $x102	# $x100 := $x101<$x102
	not	$x99, $x100	# $x99 := ~$x100
L4:
	beqz	$x99, L5   	# if (signed) $x99 == 0 goto L5
	li 	$x105, 1		# $x105 := 1
	lw 	$x106, 0($x98)	# $x106 := [$x98+0]
	sub	$x104, $x106, $x105	# $x104 := $x106-$x105
	sw 	$x104, 0($x98)	# [$x98+0] := $x104
	move 	$x103, $x98	# $x103 := $x98
	j 	L4		# goto L4
L5:
	lw 	$x107, 0($x98)	# $x107 := [$x98+0]
	move 	$v0, $x107	# $v0 := $x107
_loop.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	la 	$x118, _int_ops	# $x118 := _int_ops
	la 	$x119, _add_pair_silly	# $x119 := _add_pair_silly
	li 	$x120, 0		# $x120 := 0
	move 	$a0, $x120	# $a0 := $x120
	jalr 	$ra, $x119	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x121, $v0	# $x121 := $v0
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x122, $v0	# $x122 := $v0
	li 	$x123, 2		# $x123 := 2
	sw 	$x123, 0($x122)	# [$x122+0] := $x123
	li 	$x124, 4		# $x124 := 4
	sw 	$x124, 4($x122)	# [$x122+4] := $x124
	move 	$a0, $x122	# $a0 := $x122
	jalr 	$ra, $x121	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x125, $v0	# $x125 := $v0
	move 	$a0, $x125	# $a0 := $x125
	jalr 	$ra, $x118	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x126, $v0	# $x126 := $v0
	la 	$x127, _fact	# $x127 := _fact
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x128, $v0	# $x128 := $v0
	sw 	$x126, 0($x128)	# [$x128+0] := $x126
	move 	$a0, $x128	# $a0 := $x128
	jalr 	$ra, $x127	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x129, $v0	# $x129 := $v0
	la 	$x130, _loop	# $x130 := _loop
	move 	$a0, $x129	# $a0 := $x129
	jalr 	$ra, $x130	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x131, $v0	# $x131 := $v0
	la 	$x132, _printint	# $x132 := _printint
	move 	$a0, $x131	# $a0 := $x131
	jalr 	$ra, $x132	# ($s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7) := call $ra($a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x133, $v0	# $x133 := $v0
	move 	$v0, $x131	# $v0 := $x131
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
