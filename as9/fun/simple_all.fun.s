	.data 
NL:	.asciiz	"\n"
	.text 
main:
	addi 	$sp, $sp, -4	# $sp := $sp+-4
	sw 	$ra, 0($sp)	# [$sp+0] := $ra
	li 	$a0, 32000		# $a0 := 32000
	li 	$v0, 9		# $v0 := 9
	syscall 
	sw 	$v0, 0($gp)	# [$gp+0] := $v0
	jal 	_main		# call _main
	lw 	$ra, 0($sp)	# $ra := [$sp+0]
main.epilog:
	addi 	$sp, $sp, 4	# $sp := $sp+4
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
	addi 	$sp, $sp, -36	# $sp := $sp+-36
	sw 	$ra, 0($sp)	# [$sp+0] := $ra
	sw 	$s0, 4($sp)	# [$sp+4] := $s0
	sw 	$s1, 8($sp)	# [$sp+8] := $s1
	sw 	$s2, 12($sp)	# [$sp+12] := $s2
	sw 	$s3, 16($sp)	# [$sp+16] := $s3
	sw 	$s4, 20($sp)	# [$sp+20] := $s4
	sw 	$s5, 24($sp)	# [$sp+24] := $s5
	sw 	$s6, 28($sp)	# [$sp+28] := $s6
	sw 	$s7, 32($sp)	# [$sp+32] := $s7
	move 	$s0, $a0	# $s0 := $a0
	lw 	$a0, 0($s0)	# $a0 := [$s0+0]
	li 	$s1, 1		# $s1 := 1
	slt	$a0, $a0, $s1	# $a0 := $a0<$s1
	beqz	$a0, L11   	# if (signed) $a0 == 0 goto L11
	li 	$v0, 1		# $v0 := 1
				# $v0 := $v0
	j 	L12		# goto L12
L11:
	lw 	$s1, 0($s0)	# $s1 := [$s0+0]
	la 	$s2, _dec_ref	# $s2 := _dec_ref
	move 	$a0, $s0	# $a0 := $s0
	jalr 	$ra, $s2	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$a0, $v0	# $a0 := $v0
	la 	$s2, _fact	# $s2 := _fact
	move 	$a0, $s0	# $a0 := $s0
	jalr 	$ra, $s2	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	mulo	$v0, $s1, $v0	# $v0 := $s1*$v0
				# $v0 := $v0
L12:
				# $v0 := $v0
	lw 	$ra, 0($sp)	# $ra := [$sp+0]
	lw 	$s0, 4($sp)	# $s0 := [$sp+4]
	lw 	$s1, 8($sp)	# $s1 := [$sp+8]
	lw 	$s2, 12($sp)	# $s2 := [$sp+12]
	lw 	$s3, 16($sp)	# $s3 := [$sp+16]
	lw 	$s4, 20($sp)	# $s4 := [$sp+20]
	lw 	$s5, 24($sp)	# $s5 := [$sp+24]
	lw 	$s6, 28($sp)	# $s6 := [$sp+28]
	lw 	$s7, 32($sp)	# $s7 := [$sp+32]
_fact.epilog:
	addi 	$sp, $sp, 36	# $sp := $sp+36
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
	addi 	$sp, $sp, -36	# $sp := $sp+-36
	sw 	$ra, 0($sp)	# [$sp+0] := $ra
	sw 	$s0, 4($sp)	# [$sp+4] := $s0
	sw 	$s1, 8($sp)	# [$sp+8] := $s1
	sw 	$s2, 12($sp)	# [$sp+12] := $s2
	sw 	$s3, 16($sp)	# [$sp+16] := $s3
	sw 	$s4, 20($sp)	# [$sp+20] := $s4
	sw 	$s5, 24($sp)	# [$sp+24] := $s5
	sw 	$s6, 28($sp)	# [$sp+28] := $s6
	sw 	$s7, 32($sp)	# [$sp+32] := $s7
	move 	$s0, $a0	# $s0 := $a0
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
				# $v0 := $v0
	sw 	$s0, 0($v0)	# [$v0+0] := $s0
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
	lw 	$ra, 0($sp)	# $ra := [$sp+0]
	lw 	$s0, 4($sp)	# $s0 := [$sp+4]
	lw 	$s1, 8($sp)	# $s1 := [$sp+8]
	lw 	$s2, 12($sp)	# $s2 := [$sp+12]
	lw 	$s3, 16($sp)	# $s3 := [$sp+16]
	lw 	$s4, 20($sp)	# $s4 := [$sp+20]
	lw 	$s5, 24($sp)	# $s5 := [$sp+24]
	lw 	$s6, 28($sp)	# $s6 := [$sp+28]
	lw 	$s7, 32($sp)	# $s7 := [$sp+32]
_loop.epilog:
	addi 	$sp, $sp, 36	# $sp := $sp+36
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	addi 	$sp, $sp, -36	# $sp := $sp+-36
	sw 	$ra, 0($sp)	# [$sp+0] := $ra
	sw 	$s0, 4($sp)	# [$sp+4] := $s0
	sw 	$s1, 8($sp)	# [$sp+8] := $s1
	sw 	$s2, 12($sp)	# [$sp+12] := $s2
	sw 	$s3, 16($sp)	# [$sp+16] := $s3
	sw 	$s4, 20($sp)	# [$sp+20] := $s4
	sw 	$s5, 24($sp)	# [$sp+24] := $s5
	sw 	$s6, 28($sp)	# [$sp+28] := $s6
	sw 	$s7, 32($sp)	# [$sp+32] := $s7
				# $a0 := $a0
	la 	$s0, _int_ops	# $s0 := _int_ops
	la 	$s1, _add_pair_silly	# $s1 := _add_pair_silly
	li 	$a0, 0		# $a0 := 0
				# $a0 := $a0
	jalr 	$ra, $s1	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$s1, $v0	# $s1 := $v0
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$a0, $v0	# $a0 := $v0
	li 	$s2, 2		# $s2 := 2
	sw 	$s2, 0($a0)	# [$a0+0] := $s2
	li 	$s2, 4		# $s2 := 4
	sw 	$s2, 4($a0)	# [$a0+4] := $s2
				# $a0 := $a0
	jalr 	$ra, $s1	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$a0, $v0	# $a0 := $v0
				# $a0 := $a0
	jalr 	$ra, $s0	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$s0, $v0	# $s0 := $v0
	la 	$s1, _fact	# $s1 := _fact
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$a0, $v0	# $a0 := $v0
	sw 	$s0, 0($a0)	# [$a0+0] := $s0
				# $a0 := $a0
	jalr 	$ra, $s1	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$a0, $v0	# $a0 := $v0
	la 	$s0, _loop	# $s0 := _loop
				# $a0 := $a0
	jalr 	$ra, $s0	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$s0, $v0	# $s0 := $v0
	la 	$s1, _printint	# $s1 := _printint
	move 	$a0, $s0	# $a0 := $s0
	jalr 	$ra, $s1	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	move 	$v0, $s0	# $v0 := $s0
	lw 	$ra, 0($sp)	# $ra := [$sp+0]
	lw 	$s0, 4($sp)	# $s0 := [$sp+4]
	lw 	$s1, 8($sp)	# $s1 := [$sp+8]
	lw 	$s2, 12($sp)	# $s2 := [$sp+12]
	lw 	$s3, 16($sp)	# $s3 := [$sp+16]
	lw 	$s4, 20($sp)	# $s4 := [$sp+20]
	lw 	$s5, 24($sp)	# $s5 := [$sp+24]
	lw 	$s6, 28($sp)	# $s6 := [$sp+28]
	lw 	$s7, 32($sp)	# $s7 := [$sp+32]
_main.epilog:
	addi 	$sp, $sp, 36	# $sp := $sp+36
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
