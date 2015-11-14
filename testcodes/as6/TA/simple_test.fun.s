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
_addsome:
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
	addi 	$v0, $v0, 5	# $v0 := $v0+5
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
_addsome.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_add:
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
_add.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_gt:
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
	slt	$t5, $a0, $v0	# $t5 := $a0<$v0
	beqz	$t5, L1   	# if (signed) $t5 == 0 goto L1
	seq	$v0, $a0, $v0	# $v0 := $a0==$v0
	li 	$a0, 0		# $a0 := 0
	seq	$v0, $v0, $a0	# $v0 := $v0==$a0
	beqz	$v0, L3   	# if (signed) $v0 == 0 goto L3
	li 	$v0, 1		# $v0 := 1
				# $v0 := $v0
	j 	L4		# goto L4
L3:
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
L4:
				# $v0 := $v0
	j 	L2		# goto L2
L1:
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
L2:
	li 	$a0, 0		# $a0 := 0
	seq	$v0, $v0, $a0	# $v0 := $v0==$a0
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
_gt.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	move 	$x48, $ra	# $x48 := $ra
	move 	$x49, $s0	# $x49 := $s0
	move 	$x50, $s1	# $x50 := $s1
	move 	$x51, $s2	# $x51 := $s2
	move 	$x52, $s3	# $x52 := $s3
	move 	$x53, $s4	# $x53 := $s4
	move 	$x54, $s5	# $x54 := $s5
	move 	$x55, $s6	# $x55 := $s6
	move 	$x56, $s7	# $x56 := $s7
	move 	$v1, $a0	# $v1 := $a0
	li 	$v1, 5		# $v1 := 5
	addi 	$v1, $v1, 3	# $v1 := $v1+3
	li 	$a0, 7		# $a0 := 7
	mulo	$x58, $v1, $a0	# $x58 := $v1*$a0
	addi 	$x62, $x58, 7	# $x62 := $x58+7
	la 	$x63, _printint	# $x63 := _printint
	la 	$x65, _gt	# $x65 := _gt
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x66, $v0	# $x66 := $v0
	sw 	$x58, 0($x66)	# [$x66+0] := $x58
	li 	$x67, 0		# $x67 := 0
	sw 	$x67, 4($x66)	# [$x66+4] := $x67
	move 	$a0, $x66	# $a0 := $x66
	jalr 	$ra, $x65	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x68, $v0	# $x68 := $v0
	beqz	$x68, L5   	# if (signed) $x68 == 0 goto L5
	li 	$x72, 7		# $x72 := 7
	seq	$x71, $x58, $x72	# $x71 := $x58==$x72
	li 	$x73, 0		# $x73 := 0
	seq	$x70, $x71, $x73	# $x70 := $x71==$x73
	beqz	$x70, L7   	# if (signed) $x70 == 0 goto L7
	la 	$x74, _addsome	# $x74 := _addsome
	la 	$x75, _add	# $x75 := _add
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x76, $v0	# $x76 := $v0
	sw 	$x58, 0($x76)	# [$x76+0] := $x58
	sw 	$x62, 4($x76)	# [$x76+4] := $x62
	move 	$a0, $x76	# $a0 := $x76
	jalr 	$ra, $x75	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x77, $v0	# $x77 := $v0
	move 	$a0, $x77	# $a0 := $x77
	jalr 	$ra, $x74	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x78, $v0	# $x78 := $v0
	move 	$x69, $x78	# $x69 := $x78
	j 	L8		# goto L8
L7:
	li 	$x80, 1		# $x80 := 1
	neg	$x79, $x80	# $x79 := -$x80
	move 	$x69, $x79	# $x69 := $x79
L8:
	move 	$x64, $x69	# $x64 := $x69
	j 	L6		# goto L6
L5:
	li 	$x83, 2		# $x83 := 2
	neg	$x82, $x83	# $x82 := -$x83
	beqz	$x82, L9   	# if (signed) $x82 == 0 goto L9
	li 	$x84, 0		# $x84 := 0
	move 	$x81, $x84	# $x81 := $x84
	j 	L10		# goto L10
L9:
	li 	$x85, 1		# $x85 := 1
	move 	$x81, $x85	# $x81 := $x85
L10:
	move 	$x64, $x81	# $x64 := $x81
L6:
	move 	$a0, $x64	# $a0 := $x64
	jalr 	$ra, $x63	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	move 	$ra, $x48	# $ra := $x48
	move 	$s0, $x49	# $s0 := $x49
	move 	$s1, $x50	# $s1 := $x50
	move 	$s2, $x51	# $s2 := $x51
	move 	$s3, $x52	# $s3 := $x52
	move 	$s4, $x53	# $s4 := $x53
	move 	$s5, $x54	# $s5 := $x54
	move 	$s6, $x55	# $s6 := $x55
	move 	$s7, $x56	# $s7 := $x56
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
