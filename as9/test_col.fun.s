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
	addi 	$sp, $sp, -48	# $sp := $sp+-48
	sw 	$ra, 0($sp)	# [$sp+0] := $ra
	sw 	$s0, 4($sp)	# [$sp+4] := $s0
	sw 	$s1, 8($sp)	# [$sp+8] := $s1
	sw 	$s2, 12($sp)	# [$sp+12] := $s2
	sw 	$s3, 16($sp)	# [$sp+16] := $s3
	sw 	$s4, 20($sp)	# [$sp+20] := $s4
	sw 	$s5, 24($sp)	# [$sp+24] := $s5
	sw 	$s6, 28($sp)	# [$sp+28] := $s6
	sw 	$s7, 32($sp)	# [$sp+32] := $s7
	move 	$v1, $a0	# $v1 := $a0
	li 	$v1, 5		# $v1 := 5
	addi 	$v1, $v1, 3	# $v1 := $v1+3
	li 	$a0, 7		# $a0 := 7
	mulo	$s0, $v1, $a0	# $s0 := $v1*$a0
	addi 	$s1, $s0, 7	# $s1 := $s0+7
	la 	$s2, _gt	# $s2 := _gt
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	sw 	$v0, 36($sp)	# [$sp+36] := $v0
	lw 	$a0, 36($sp)	# $a0 := [$sp+36]
	sw 	$s0, 0($a0)	# [$a0+0] := $s0
	li 	$a0, 0		# $a0 := 0
	lw 	$s3, 36($sp)	# $s3 := [$sp+36]
	sw 	$a0, 4($s3)	# [$s3+4] := $a0
	lw 	$a0, 36($sp)	# $a0 := [$sp+36]
	jalr 	$ra, $s2	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	beqz	$v1, L5   	# if (signed) $v1 == 0 goto L5
	li 	$v1, 7		# $v1 := 7
	seq	$v1, $s0, $v1	# $v1 := $s0==$v1
	li 	$a0, 0		# $a0 := 0
	seq	$v1, $v1, $a0	# $v1 := $v1==$a0
	beqz	$v1, L7   	# if (signed) $v1 == 0 goto L7
	la 	$s2, _addsome	# $s2 := _addsome
	la 	$s3, _add	# $s3 := _add
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	sw 	$v0, 40($sp)	# [$sp+40] := $v0
	lw 	$a0, 40($sp)	# $a0 := [$sp+40]
	sw 	$s0, 0($a0)	# [$a0+0] := $s0
	lw 	$a0, 40($sp)	# $a0 := [$sp+40]
	sw 	$s1, 4($a0)	# [$a0+4] := $s1
	lw 	$a0, 40($sp)	# $a0 := [$sp+40]
	jalr 	$ra, $s3	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	sw 	$v0, 44($sp)	# [$sp+44] := $v0
	lw 	$a0, 44($sp)	# $a0 := [$sp+44]
	jalr 	$ra, $s2	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
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
	addi 	$sp, $sp, 48	# $sp := $sp+48
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
