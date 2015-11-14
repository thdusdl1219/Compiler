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
_main:
	move 	$x1, $ra	# $x1 := $ra
	move 	$x2, $s0	# $x2 := $s0
	move 	$x3, $s1	# $x3 := $s1
	move 	$x4, $s2	# $x4 := $s2
	move 	$x5, $s3	# $x5 := $s3
	move 	$x6, $s4	# $x6 := $s4
	move 	$x7, $s5	# $x7 := $s5
	move 	$x8, $s6	# $x8 := $s6
	move 	$x9, $s7	# $x9 := $s7
	move 	$v1, $a0	# $v1 := $a0
	li 	$x12, 2		# $x12 := 2
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x11, $v0	# $x11 := $v0
	sw 	$x12, 0($x11)	# [$x11+0] := $x12
	li 	$x14, 1		# $x14 := 1
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x13, $v0	# $x13 := $v0
	sw 	$x14, 0($x13)	# [$x13+0] := $x14
L1:
	lw 	$x17, 0($x11)	# $x17 := [$x11+0]
	li 	$x18, 10		# $x18 := 10
	slt	$x16, $x17, $x18	# $x16 := $x17<$x18
	beqz	$x16, L2   	# if (signed) $x16 == 0 goto L2
	li 	$x19, 1		# $x19 := 1
	sw 	$x19, 0($x13)	# [$x13+0] := $x19
L3:
	lw 	$x22, 0($x13)	# $x22 := [$x13+0]
	li 	$x23, 10		# $x23 := 10
	slt	$x21, $x22, $x23	# $x21 := $x22<$x23
	beqz	$x21, L4   	# if (signed) $x21 == 0 goto L4
	la 	$x24, _printint	# $x24 := _printint
	lw 	$x26, 0($x11)	# $x26 := [$x11+0]
	lw 	$x27, 0($x13)	# $x27 := [$x13+0]
	mulo	$x25, $x26, $x27	# $x25 := $x26*$x27
	move 	$a0, $x25	# $a0 := $x25
	jalr 	$ra, $x24	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x28, $v0	# $x28 := $v0
	lw 	$x30, 0($x13)	# $x30 := [$x13+0]
	addi 	$x29, $x30, 1	# $x29 := $x30+1
	sw 	$x29, 0($x13)	# [$x13+0] := $x29
	move 	$x20, $x13	# $x20 := $x13
	j 	L3		# goto L3
L4:
	lw 	$x32, 0($x11)	# $x32 := [$x11+0]
	addi 	$x31, $x32, 1	# $x31 := $x32+1
	sw 	$x31, 0($x11)	# [$x11+0] := $x31
	move 	$x15, $x11	# $x15 := $x11
	j 	L1		# goto L1
L2:
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	move 	$ra, $x1	# $ra := $x1
	move 	$s0, $x2	# $s0 := $x2
	move 	$s1, $x3	# $s1 := $x3
	move 	$s2, $x4	# $s2 := $x4
	move 	$s3, $x5	# $s3 := $x5
	move 	$s4, $x6	# $s4 := $x6
	move 	$s5, $x7	# $s5 := $x7
	move 	$s6, $x8	# $s6 := $x8
	move 	$s7, $x9	# $s7 := $x9
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
