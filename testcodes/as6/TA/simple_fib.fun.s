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
	li 	$x12, 0		# $x12 := 0
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x11, $v0	# $x11 := $v0
	sw 	$x12, 0($x11)	# [$x11+0] := $x12
	li 	$x14, 1		# $x14 := 1
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x13, $v0	# $x13 := $v0
	sw 	$x14, 0($x13)	# [$x13+0] := $x14
	li 	$x16, 1		# $x16 := 1
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x15, $v0	# $x15 := $v0
	sw 	$x16, 0($x15)	# [$x15+0] := $x16
L1:
	lw 	$x19, 0($x15)	# $x19 := [$x15+0]
	li 	$x20, 10		# $x20 := 10
	slt	$x18, $x19, $x20	# $x18 := $x19<$x20
	beqz	$x18, L2   	# if (signed) $x18 == 0 goto L2
	lw 	$x21, 0($x13)	# $x21 := [$x13+0]
	lw 	$x23, 0($x11)	# $x23 := [$x11+0]
	lw 	$x24, 0($x13)	# $x24 := [$x13+0]
	add	$x22, $x23, $x24	# $x22 := $x23+$x24
	sw 	$x22, 0($x13)	# [$x13+0] := $x22
	sw 	$x21, 0($x11)	# [$x11+0] := $x21
	lw 	$x26, 0($x15)	# $x26 := [$x15+0]
	addi 	$x25, $x26, 1	# $x25 := $x26+1
	sw 	$x25, 0($x15)	# [$x15+0] := $x25
	move 	$x17, $x15	# $x17 := $x15
	j 	L1		# goto L1
L2:
	la 	$x27, _printint	# $x27 := _printint
	lw 	$x28, 0($x13)	# $x28 := [$x13+0]
	move 	$a0, $x28	# $a0 := $x28
	jalr 	$ra, $x27	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
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
