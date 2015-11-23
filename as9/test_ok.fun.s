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
	la 	$x64, _gt	# $x64 := _gt
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x65, $v0	# $x65 := $v0
	sw 	$x58, 0($x65)	# [$x65+0] := $x58
	li 	$x66, 0		# $x66 := 0
	sw 	$x66, 4($x65)	# [$x65+4] := $x66
	move 	$a0, $x65	# $a0 := $x65
	jalr 	$ra, $x64	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	beqz	$v1, L5   	# if (signed) $v1 == 0 goto L5
	li 	$v1, 7		# $v1 := 7
	seq	$v1, $x58, $v1	# $v1 := $x58==$v1
	li 	$a0, 0		# $a0 := 0
	seq	$v1, $v1, $a0	# $v1 := $v1==$a0
	beqz	$v1, L7   	# if (signed) $v1 == 0 goto L7
	la 	$x73, _addsome	# $x73 := _addsome
	la 	$x74, _add	# $x74 := _add
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x75, $v0	# $x75 := $v0
	sw 	$x58, 0($x75)	# [$x75+0] := $x58
	sw 	$x62, 4($x75)	# [$x75+4] := $x62
	move 	$a0, $x75	# $a0 := $x75
	jalr 	$ra, $x74	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x76, $v0	# $x76 := $v0
	move 	$a0, $x76	# $a0 := $x76
	jalr 	$ra, $x73	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
				# $v0 := $v0
	j 	L8		# goto L8
L7:
	li 	$v0, 1		# $v0 := 1
	neg	$v0, $v0	# $v0 := -$v0
				# $v0 := $v0
L8:
				# $v0 := $v0
	j 	L6		# goto L6
L5:
	li 	$v0, 2		# $v0 := 2
	neg	$v0, $v0	# $v0 := -$v0
	beqz	$v0, L9   	# if (signed) $v0 == 0 goto L9
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	j 	L10		# goto L10
L9:
	li 	$v0, 1		# $v0 := 1
				# $v0 := $v0
L10:
				# $v0 := $v0
L6:
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
