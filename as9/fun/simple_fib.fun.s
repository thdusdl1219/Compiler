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
	li 	$s1, 0		# $s1 := 0
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$s0, $v0	# $s0 := $v0
	sw 	$s1, 0($s0)	# [$s0+0] := $s1
	li 	$s2, 1		# $s2 := 1
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$s1, $v0	# $s1 := $v0
	sw 	$s2, 0($s1)	# [$s1+0] := $s2
	li 	$s2, 1		# $s2 := 1
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$a0, $v0	# $a0 := $v0
	sw 	$s2, 0($a0)	# [$a0+0] := $s2
L1:
	lw 	$s2, 0($a0)	# $s2 := [$a0+0]
	li 	$s3, 10		# $s3 := 10
	slt	$s2, $s2, $s3	# $s2 := $s2<$s3
	beqz	$s2, L2   	# if (signed) $s2 == 0 goto L2
	lw 	$s2, 0($s1)	# $s2 := [$s1+0]
	lw 	$s3, 0($s0)	# $s3 := [$s0+0]
	lw 	$s4, 0($s1)	# $s4 := [$s1+0]
	add	$s3, $s3, $s4	# $s3 := $s3+$s4
	sw 	$s3, 0($s1)	# [$s1+0] := $s3
	sw 	$s2, 0($s0)	# [$s0+0] := $s2
	lw 	$s2, 0($a0)	# $s2 := [$a0+0]
	addi 	$s2, $s2, 1	# $s2 := $s2+1
	sw 	$s2, 0($a0)	# [$a0+0] := $s2
	move 	$s2, $a0	# $s2 := $a0
	j 	L1		# goto L1
L2:
	la 	$s0, _printint	# $s0 := _printint
	lw 	$a0, 0($s1)	# $a0 := [$s1+0]
				# $a0 := $a0
	jalr 	$ra, $s0	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
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
