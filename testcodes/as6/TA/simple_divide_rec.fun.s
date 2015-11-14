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
_divide_rec:
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
	lw 	$x11, 0($v1)	# $x11 := [$v1+0]
	lw 	$x12, 4($v1)	# $x12 := [$v1+4]
	slt	$v1, $x11, $x12	# $v1 := $x11<$x12
	beqz	$v1, L1   	# if (signed) $v1 == 0 goto L1
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
				# $v0 := $v0
	li 	$v1, 0		# $v1 := 0
	sw 	$v1, 0($v0)	# [$v0+0] := $v1
	sw 	$x11, 4($v0)	# [$v0+4] := $x11
				# $v0 := $v0
	j 	L2		# goto L2
L1:
	la 	$x17, _divide_rec	# $x17 := _divide_rec
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x18, $v0	# $x18 := $v0
	sub	$x19, $x11, $x12	# $x19 := $x11-$x12
	sw 	$x19, 0($x18)	# [$x18+0] := $x19
	sw 	$x12, 4($x18)	# [$x18+4] := $x12
	move 	$a0, $x18	# $a0 := $x18
	jalr 	$ra, $x17	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x20, $v0	# $x20 := $v0
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
				# $v0 := $v0
	lw 	$v1, 0($x20)	# $v1 := [$x20+0]
	addi 	$v1, $v1, 1	# $v1 := $v1+1
	sw 	$v1, 0($v0)	# [$v0+0] := $v1
	lw 	$v1, 4($x20)	# $v1 := [$x20+4]
	sw 	$v1, 4($v0)	# [$v0+4] := $v1
				# $v0 := $v0
L2:
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
_divide_rec.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	move 	$x25, $ra	# $x25 := $ra
	move 	$x26, $s0	# $x26 := $s0
	move 	$x27, $s1	# $x27 := $s1
	move 	$x28, $s2	# $x28 := $s2
	move 	$x29, $s3	# $x29 := $s3
	move 	$x30, $s4	# $x30 := $s4
	move 	$x31, $s5	# $x31 := $s5
	move 	$x32, $s6	# $x32 := $s6
	move 	$x33, $s7	# $x33 := $s7
	move 	$v1, $a0	# $v1 := $a0
	la 	$x35, _printint	# $x35 := _printint
	la 	$x36, _divide_rec	# $x36 := _divide_rec
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x37, $v0	# $x37 := $v0
	li 	$x38, 1000		# $x38 := 1000
	sw 	$x38, 0($x37)	# [$x37+0] := $x38
	li 	$x39, 17		# $x39 := 17
	sw 	$x39, 4($x37)	# [$x37+4] := $x39
	move 	$a0, $x37	# $a0 := $x37
	jalr 	$ra, $x36	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x40, $v0	# $x40 := $v0
	lw 	$x41, 0($x40)	# $x41 := [$x40+0]
	move 	$a0, $x41	# $a0 := $x41
	jalr 	$ra, $x35	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$v1, $v0	# $v1 := $v0
	la 	$x43, _printint	# $x43 := _printint
	la 	$x44, _divide_rec	# $x44 := _divide_rec
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x45, $v0	# $x45 := $v0
	li 	$x46, 1000		# $x46 := 1000
	sw 	$x46, 0($x45)	# [$x45+0] := $x46
	li 	$x47, 17		# $x47 := 17
	sw 	$x47, 4($x45)	# [$x45+4] := $x47
	move 	$a0, $x45	# $a0 := $x45
	jalr 	$ra, $x44	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x48, $v0	# $x48 := $v0
	lw 	$x49, 4($x48)	# $x49 := [$x48+4]
	move 	$a0, $x49	# $a0 := $x49
	jalr 	$ra, $x43	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	move 	$ra, $x25	# $ra := $x25
	move 	$s0, $x26	# $s0 := $x26
	move 	$s1, $x27	# $s1 := $x27
	move 	$s2, $x28	# $s2 := $x28
	move 	$s3, $x29	# $s3 := $x29
	move 	$s4, $x30	# $s4 := $x30
	move 	$s5, $x31	# $s5 := $x31
	move 	$s6, $x32	# $s6 := $x32
	move 	$s7, $x33	# $s7 := $x33
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
