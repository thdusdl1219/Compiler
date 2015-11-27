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
	move 	$v1, $a0	# $v1 := $a0
	li 	$s1, 1		# $s1 := 1
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$s0, $v0	# $s0 := $v0
	sw 	$s1, 0($s0)	# [$s0+0] := $s1
	lw 	$v1, 0($s0)	# $v1 := [$s0+0]
	li 	$a0, 1		# $a0 := 1
	seq	$v1, $v1, $a0	# $v1 := $v1==$a0
	beqz	$v1, L1   	# if (signed) $v1 == 0 goto L1
	li 	$s2, 1		# $s2 := 1
				# $s2 := $s2
	j 	L2		# goto L2
L1:
	li 	$v1, 0		# $v1 := 0
	sw 	$v1, 0($s0)	# [$s0+0] := $v1
	li 	$s2, 0		# $s2 := 0
				# $s2 := $s2
L2:
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$s1, $v0	# $s1 := $v0
	sw 	$s2, 0($s1)	# [$s1+0] := $s2
	lw 	$v1, 0($s1)	# $v1 := [$s1+0]
	li 	$a0, 0		# $a0 := 0
	seq	$v1, $v1, $a0	# $v1 := $v1==$a0
	beqz	$v1, L3   	# if (signed) $v1 == 0 goto L3
	li 	$v1, 0		# $v1 := 0
	sw 	$v1, 0($s1)	# [$s1+0] := $v1
	li 	$s3, 0		# $s3 := 0
				# $s3 := $s3
	j 	L4		# goto L4
L3:
	li 	$s3, 1		# $s3 := 1
				# $s3 := $s3
L4:
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$s2, $v0	# $s2 := $v0
	sw 	$s3, 0($s2)	# [$s2+0] := $s3
	lw 	$v1, 0($s2)	# $v1 := [$s2+0]
	beqz	$v1, L5   	# if (signed) $v1 == 0 goto L5
	li 	$s4, 1		# $s4 := 1
				# $s4 := $s4
	j 	L6		# goto L6
L5:
	li 	$v1, 0		# $v1 := 0
	sw 	$v1, 0($s2)	# [$s2+0] := $v1
	li 	$v1, 0		# $v1 := 0
	beqz	$v1, L7   	# if (signed) $v1 == 0 goto L7
	li 	$v1, 1		# $v1 := 1
	move 	$s4, $v1	# $s4 := $v1
	j 	L8		# goto L8
L7:
	li 	$v1, 0		# $v1 := 0
	move 	$s4, $v1	# $s4 := $v1
L8:
				# $s4 := $s4
L6:
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$s3, $v0	# $s3 := $v0
	sw 	$s4, 0($s3)	# [$s3+0] := $s4
	li 	$s5, 0		# $s5 := 0
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$s4, $v0	# $s4 := $v0
	sw 	$s5, 0($s4)	# [$s4+0] := $s5
	lw 	$v1, 0($s3)	# $v1 := [$s3+0]
	beqz	$v1, L9   	# if (signed) $v1 == 0 goto L9
	li 	$v1, 1		# $v1 := 1
	sw 	$v1, 0($s4)	# [$s4+0] := $v1
	li 	$v1, 1		# $v1 := 1
	beqz	$v1, L11   	# if (signed) $v1 == 0 goto L11
	li 	$v1, 1		# $v1 := 1
	move 	$s5, $v1	# $s5 := $v1
	j 	L12		# goto L12
L11:
	li 	$v1, 0		# $v1 := 0
	move 	$s5, $v1	# $s5 := $v1
L12:
				# $s5 := $s5
	j 	L10		# goto L10
L9:
	li 	$s5, 0		# $s5 := 0
				# $s5 := $s5
L10:
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$a0, $v0	# $a0 := $v0
	sw 	$s5, 0($a0)	# [$a0+0] := $s5
	la 	$s5, _printint	# $s5 := _printint
	lw 	$s0, 0($s0)	# $s0 := [$s0+0]
	lw 	$s1, 0($s1)	# $s1 := [$s1+0]
	add	$s0, $s0, $s1	# $s0 := $s0+$s1
	lw 	$s1, 0($s2)	# $s1 := [$s2+0]
	add	$s0, $s0, $s1	# $s0 := $s0+$s1
	lw 	$s1, 0($s3)	# $s1 := [$s3+0]
	add	$s0, $s0, $s1	# $s0 := $s0+$s1
	lw 	$s1, 0($s4)	# $s1 := [$s4+0]
	add	$s0, $s0, $s1	# $s0 := $s0+$s1
	lw 	$a0, 0($a0)	# $a0 := [$a0+0]
	add	$a0, $s0, $a0	# $a0 := $s0+$a0
				# $a0 := $a0
	jalr 	$ra, $s5	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	li 	$v0, 0		# $v0 := 0
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
	addi 	$sp, $sp, 36	# $sp := $sp+36
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
