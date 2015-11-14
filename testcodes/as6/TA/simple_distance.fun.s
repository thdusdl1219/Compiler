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
_sqrt_ceil_iter:
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
	li 	$x12, 0		# $x12 := 0
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
				# $v0 := $v0
	sw 	$x12, 0($v0)	# [$v0+0] := $x12
L1:
	lw 	$v1, 0($v0)	# $v1 := [$v0+0]
	lw 	$a0, 0($v0)	# $a0 := [$v0+0]
	mulo	$v1, $v1, $a0	# $v1 := $v1*$a0
	slt	$v1, $v1, $x10	# $v1 := $v1<$x10
	beqz	$v1, L2   	# if (signed) $v1 == 0 goto L2
	lw 	$v1, 0($v0)	# $v1 := [$v0+0]
	addi 	$v1, $v1, 1	# $v1 := $v1+1
	sw 	$v1, 0($v0)	# [$v0+0] := $v1
	move 	$v1, $v0	# $v1 := $v0
	j 	L1		# goto L1
L2:
	lw 	$v0, 0($v0)	# $v0 := [$v0+0]
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
_sqrt_ceil_iter.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_distance:
	move 	$x21, $ra	# $x21 := $ra
	move 	$x22, $s0	# $x22 := $s0
	move 	$x23, $s1	# $x23 := $s1
	move 	$x24, $s2	# $x24 := $s2
	move 	$x25, $s3	# $x25 := $s3
	move 	$x26, $s4	# $x26 := $s4
	move 	$x27, $s5	# $x27 := $s5
	move 	$x28, $s6	# $x28 := $s6
	move 	$x29, $s7	# $x29 := $s7
	move 	$x30, $a0	# $x30 := $a0
	lw 	$x31, 0($x30)	# $x31 := [$x30+0]
	lw 	$x32, 4($x30)	# $x32 := [$x30+4]
	la 	$x33, _sqrt_ceil_iter	# $x33 := _sqrt_ceil_iter
	lw 	$x37, 0($x32)	# $x37 := [$x32+0]
	lw 	$x38, 0($x31)	# $x38 := [$x31+0]
	sub	$x36, $x38, $x37	# $x36 := $x38-$x37
	lw 	$x40, 0($x32)	# $x40 := [$x32+0]
	lw 	$x41, 0($x31)	# $x41 := [$x31+0]
	sub	$x39, $x41, $x40	# $x39 := $x41-$x40
	mulo	$x35, $x36, $x39	# $x35 := $x36*$x39
	lw 	$x44, 4($x32)	# $x44 := [$x32+4]
	lw 	$x45, 4($x31)	# $x45 := [$x31+4]
	sub	$x43, $x45, $x44	# $x43 := $x45-$x44
	lw 	$x47, 4($x32)	# $x47 := [$x32+4]
	lw 	$x48, 4($x31)	# $x48 := [$x31+4]
	sub	$x46, $x48, $x47	# $x46 := $x48-$x47
	mulo	$x42, $x43, $x46	# $x42 := $x43*$x46
	add	$x34, $x35, $x42	# $x34 := $x35+$x42
	move 	$a0, $x34	# $a0 := $x34
	jalr 	$ra, $x33	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
				# $v0 := $v0
	move 	$ra, $x21	# $ra := $x21
	move 	$s0, $x22	# $s0 := $x22
	move 	$s1, $x23	# $s1 := $x23
	move 	$s2, $x24	# $s2 := $x24
	move 	$s3, $x25	# $s3 := $x25
	move 	$s4, $x26	# $s4 := $x26
	move 	$s5, $x27	# $s5 := $x27
	move 	$s6, $x28	# $s6 := $x28
	move 	$s7, $x29	# $s7 := $x29
_distance.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	move 	$x50, $ra	# $x50 := $ra
	move 	$x51, $s0	# $x51 := $s0
	move 	$x52, $s1	# $x52 := $s1
	move 	$x53, $s2	# $x53 := $s2
	move 	$x54, $s3	# $x54 := $s3
	move 	$x55, $s4	# $x55 := $s4
	move 	$x56, $s5	# $x56 := $s5
	move 	$x57, $s6	# $x57 := $s6
	move 	$x58, $s7	# $x58 := $s7
	move 	$v1, $a0	# $v1 := $a0
	la 	$x60, _printint	# $x60 := _printint
	la 	$x61, _distance	# $x61 := _distance
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x62, $v0	# $x62 := $v0
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$v1, $v0	# $v1 := $v0
	li 	$a0, 7		# $a0 := 7
	sw 	$a0, 0($v1)	# [$v1+0] := $a0
	li 	$a0, 5		# $a0 := 5
	sw 	$a0, 4($v1)	# [$v1+4] := $a0
	sw 	$v1, 0($x62)	# [$x62+0] := $v1
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x66, $v0	# $x66 := $v0
	li 	$x67, 3		# $x67 := 3
	sw 	$x67, 0($x66)	# [$x66+0] := $x67
	li 	$x68, 8		# $x68 := 8
	sw 	$x68, 4($x66)	# [$x66+4] := $x68
	sw 	$x66, 4($x62)	# [$x62+4] := $x66
	move 	$a0, $x62	# $a0 := $x62
	jalr 	$ra, $x61	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x69, $v0	# $x69 := $v0
	move 	$a0, $x69	# $a0 := $x69
	jalr 	$ra, $x60	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	move 	$ra, $x50	# $ra := $x50
	move 	$s0, $x51	# $s0 := $x51
	move 	$s1, $x52	# $s1 := $x52
	move 	$s2, $x53	# $s2 := $x53
	move 	$s3, $x54	# $s3 := $x54
	move 	$s4, $x55	# $s4 := $x55
	move 	$s5, $x56	# $s5 := $x56
	move 	$s6, $x57	# $s6 := $x57
	move 	$s7, $x58	# $s7 := $x58
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
