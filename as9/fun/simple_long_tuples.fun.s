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
_long_tuples:
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
	lw 	$t5, 4($v0)	# $t5 := [$v0+4]
	mulo	$a0, $a0, $t5	# $a0 := $a0*$t5
	lw 	$t5, 8($v0)	# $t5 := [$v0+8]
	mulo	$a0, $a0, $t5	# $a0 := $a0*$t5
	lw 	$t5, 12($v0)	# $t5 := [$v0+12]
	mulo	$a0, $a0, $t5	# $a0 := $a0*$t5
	lw 	$v0, 16($v0)	# $v0 := [$v0+16]
	mulo	$v0, $a0, $v0	# $v0 := $a0*$v0
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
_long_tuples.epilog:
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
	la 	$s0, _printint	# $s0 := _printint
	la 	$s1, _long_tuples	# $s1 := _long_tuples
	li 	$a0, 20		# $a0 := 20
	jal 	alloc		# call alloc
	move 	$a0, $v0	# $a0 := $v0
	li 	$s2, 1		# $s2 := 1
	sw 	$s2, 0($a0)	# [$a0+0] := $s2
	li 	$s2, 2		# $s2 := 2
	sw 	$s2, 4($a0)	# [$a0+4] := $s2
	li 	$s2, 3		# $s2 := 3
	sw 	$s2, 8($a0)	# [$a0+8] := $s2
	li 	$s2, 4		# $s2 := 4
	sw 	$s2, 12($a0)	# [$a0+12] := $s2
	li 	$s2, 5		# $s2 := 5
	sw 	$s2, 16($a0)	# [$a0+16] := $s2
				# $a0 := $a0
	jalr 	$ra, $s1	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$a0, $v0	# $a0 := $v0
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
