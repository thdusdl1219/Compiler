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
_apple:
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
	lw 	$a0, 0($x10)	# $a0 := [$x10+0]
	li 	$v1, 1		# $v1 := 1
	seq	$v1, $a0, $v1	# $v1 := $a0==$v1
	beqz	$v1, L1   	# if (signed) $v1 == 0 goto L1
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	lw 	$v0, 4($x10)	# $v0 := [$x10+4]
	sw 	$v0, 0($v1)	# [$v1+0] := $v0
	lw 	$v0, 0($x10)	# $v0 := [$x10+0]
	sw 	$v0, 4($v1)	# [$v1+4] := $v0
	move 	$v0, $v1	# $v0 := $v1
	j 	L2		# goto L2
L1:
	move 	$v0, $x10	# $v0 := $x10
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
_apple.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_banana:
	move 	$t5, $ra	# $t5 := $ra
	move 	$t4, $s0	# $t4 := $s0
	move 	$t3, $s1	# $t3 := $s1
	move 	$t2, $s2	# $t2 := $s2
	move 	$t1, $s3	# $t1 := $s3
	move 	$t0, $s4	# $t0 := $s4
	move 	$a3, $s5	# $a3 := $s5
	move 	$a2, $s6	# $a2 := $s6
	move 	$a1, $s7	# $a1 := $s7
				# $a0 := $a0
	lw 	$v1, 4($a0)	# $v1 := [$a0+4]
	li 	$v0, 4		# $v0 := 4
	mulo	$v1, $v1, $v0	# $v1 := $v1*$v0
	lw 	$v0, 4($a0)	# $v0 := [$a0+4]
	add	$v0, $v1, $v0	# $v0 := $v1+$v0
				# $v0 := $v0
	move 	$ra, $t5	# $ra := $t5
	move 	$s0, $t4	# $s0 := $t4
	move 	$s1, $t3	# $s1 := $t3
	move 	$s2, $t2	# $s2 := $t2
	move 	$s3, $t1	# $s3 := $t1
	move 	$s4, $t0	# $s4 := $t0
	move 	$s5, $a3	# $s5 := $a3
	move 	$s6, $a2	# $s6 := $a2
	move 	$s7, $a1	# $s7 := $a1
_banana.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	move 	$x33, $ra	# $x33 := $ra
	move 	$x34, $s0	# $x34 := $s0
	move 	$x35, $s1	# $x35 := $s1
	move 	$x36, $s2	# $x36 := $s2
	move 	$x37, $s3	# $x37 := $s3
	move 	$x38, $s4	# $x38 := $s4
	move 	$x39, $s5	# $x39 := $s5
	move 	$x40, $s6	# $x40 := $s6
	move 	$x41, $s7	# $x41 := $s7
	move 	$v1, $a0	# $v1 := $a0
	li 	$x44, 1		# $x44 := 1
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x43, $v0	# $x43 := $v0
	sw 	$x44, 0($x43)	# [$x43+0] := $x44
	li 	$x46, 10		# $x46 := 10
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x45, $v0	# $x45 := $v0
	sw 	$x46, 0($x45)	# [$x45+0] := $x46
	la 	$x47, _printint	# $x47 := _printint
	la 	$x48, _banana	# $x48 := _banana
	la 	$x49, _apple	# $x49 := _apple
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x50, $v0	# $x50 := $v0
	lw 	$x51, 0($x43)	# $x51 := [$x43+0]
	sw 	$x51, 0($x50)	# [$x50+0] := $x51
	lw 	$x52, 0($x45)	# $x52 := [$x45+0]
	sw 	$x52, 4($x50)	# [$x50+4] := $x52
	move 	$a0, $x50	# $a0 := $x50
	jalr 	$ra, $x49	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x53, $v0	# $x53 := $v0
	move 	$a0, $x53	# $a0 := $x53
	jalr 	$ra, $x48	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x54, $v0	# $x54 := $v0
	move 	$a0, $x54	# $a0 := $x54
	jalr 	$ra, $x47	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	lw 	$v0, 0($x43)	# $v0 := [$x43+0]
				# $v0 := $v0
	move 	$ra, $x33	# $ra := $x33
	move 	$s0, $x34	# $s0 := $x34
	move 	$s1, $x35	# $s1 := $x35
	move 	$s2, $x36	# $s2 := $x36
	move 	$s3, $x37	# $s3 := $x37
	move 	$s4, $x38	# $s4 := $x38
	move 	$s5, $x39	# $s5 := $x39
	move 	$s6, $x40	# $s6 := $x40
	move 	$s7, $x41	# $s7 := $x41
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
