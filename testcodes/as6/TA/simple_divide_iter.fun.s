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
_divide_iter:
	move 	$x1, $ra	# $x1 := $ra
	move 	$x2, $s0	# $x2 := $s0
	move 	$x3, $s1	# $x3 := $s1
	move 	$x4, $s2	# $x4 := $s2
	move 	$x5, $s3	# $x5 := $s3
	move 	$x6, $s4	# $x6 := $s4
	move 	$x7, $s5	# $x7 := $s5
	move 	$x8, $s6	# $x8 := $s6
	move 	$x9, $s7	# $x9 := $s7
	move 	$x10, $a0	# $x10 := $a0
	lw 	$x12, 0($x10)	# $x12 := [$x10+0]
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x11, $v0	# $x11 := $v0
	sw 	$x12, 0($x11)	# [$x11+0] := $x12
	lw 	$x13, 4($x10)	# $x13 := [$x10+4]
	li 	$x15, 0		# $x15 := 0
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x14, $v0	# $x14 := $v0
	sw 	$x15, 0($x14)	# [$x14+0] := $x15
L1:
	lw 	$v1, 0($x11)	# $v1 := [$x11+0]
	slt	$v1, $v1, $x13	# $v1 := $v1<$x13
	li 	$a0, 0		# $a0 := 0
	seq	$v1, $v1, $a0	# $v1 := $v1==$a0
	beqz	$v1, L2   	# if (signed) $v1 == 0 goto L2
	lw 	$v1, 0($x11)	# $v1 := [$x11+0]
	sub	$v1, $v1, $x13	# $v1 := $v1-$x13
	sw 	$v1, 0($x11)	# [$x11+0] := $v1
	lw 	$v1, 0($x14)	# $v1 := [$x14+0]
	addi 	$v1, $v1, 1	# $v1 := $v1+1
	sw 	$v1, 0($x14)	# [$x14+0] := $v1
	move 	$v1, $x14	# $v1 := $x14
	j 	L1		# goto L1
L2:
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
				# $v0 := $v0
	lw 	$v1, 0($x14)	# $v1 := [$x14+0]
	sw 	$v1, 0($v0)	# [$v0+0] := $v1
	lw 	$v1, 0($x11)	# $v1 := [$x11+0]
	sw 	$v1, 4($v0)	# [$v0+4] := $v1
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
_divide_iter.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	move 	$x28, $ra	# $x28 := $ra
	move 	$x29, $s0	# $x29 := $s0
	move 	$x30, $s1	# $x30 := $s1
	move 	$x31, $s2	# $x31 := $s2
	move 	$x32, $s3	# $x32 := $s3
	move 	$x33, $s4	# $x33 := $s4
	move 	$x34, $s5	# $x34 := $s5
	move 	$x35, $s6	# $x35 := $s6
	move 	$x36, $s7	# $x36 := $s7
	move 	$v1, $a0	# $v1 := $a0
	la 	$x38, _divide_iter	# $x38 := _divide_iter
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x39, $v0	# $x39 := $v0
	li 	$x40, 10000		# $x40 := 10000
	sw 	$x40, 0($x39)	# [$x39+0] := $x40
	li 	$x41, 17		# $x41 := 17
	sw 	$x41, 4($x39)	# [$x39+4] := $x41
	move 	$a0, $x39	# $a0 := $x39
	jalr 	$ra, $x38	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x42, $v0	# $x42 := $v0
	la 	$x43, _printint	# $x43 := _printint
	lw 	$x44, 0($x42)	# $x44 := [$x42+0]
	move 	$a0, $x44	# $a0 := $x44
	jalr 	$ra, $x43	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x45, $v0	# $x45 := $v0
	la 	$x46, _printint	# $x46 := _printint
	lw 	$x47, 4($x42)	# $x47 := [$x42+4]
	move 	$a0, $x47	# $a0 := $x47
	jalr 	$ra, $x46	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	move 	$ra, $x28	# $ra := $x28
	move 	$s0, $x29	# $s0 := $x29
	move 	$s1, $x30	# $s1 := $x30
	move 	$s2, $x31	# $s2 := $x31
	move 	$s3, $x32	# $s3 := $x32
	move 	$s4, $x33	# $s4 := $x33
	move 	$s5, $x34	# $s5 := $x34
	move 	$s6, $x35	# $s6 := $x35
	move 	$s7, $x36	# $s7 := $x36
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
