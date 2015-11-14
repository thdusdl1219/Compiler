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
	li 	$x12, 1		# $x12 := 1
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x11, $v0	# $x11 := $v0
	sw 	$x12, 0($x11)	# [$x11+0] := $x12
	lw 	$v1, 0($x11)	# $v1 := [$x11+0]
	li 	$a0, 1		# $a0 := 1
	seq	$v1, $v1, $a0	# $v1 := $v1==$a0
	beqz	$v1, L1   	# if (signed) $v1 == 0 goto L1
	li 	$v1, 1		# $v1 := 1
	move 	$x14, $v1	# $x14 := $v1
	j 	L2		# goto L2
L1:
	li 	$v1, 0		# $v1 := 0
	sw 	$v1, 0($x11)	# [$x11+0] := $v1
	li 	$v1, 0		# $v1 := 0
	move 	$x14, $v1	# $x14 := $v1
L2:
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x13, $v0	# $x13 := $v0
	sw 	$x14, 0($x13)	# [$x13+0] := $x14
	lw 	$v1, 0($x13)	# $v1 := [$x13+0]
	li 	$a0, 0		# $a0 := 0
	seq	$v1, $v1, $a0	# $v1 := $v1==$a0
	beqz	$v1, L3   	# if (signed) $v1 == 0 goto L3
	li 	$v1, 0		# $v1 := 0
	sw 	$v1, 0($x13)	# [$x13+0] := $v1
	li 	$v1, 0		# $v1 := 0
	move 	$x22, $v1	# $x22 := $v1
	j 	L4		# goto L4
L3:
	li 	$v1, 1		# $v1 := 1
	move 	$x22, $v1	# $x22 := $v1
L4:
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x21, $v0	# $x21 := $v0
	sw 	$x22, 0($x21)	# [$x21+0] := $x22
	lw 	$v1, 0($x21)	# $v1 := [$x21+0]
	beqz	$v1, L5   	# if (signed) $v1 == 0 goto L5
	li 	$v1, 1		# $v1 := 1
	move 	$x30, $v1	# $x30 := $v1
	j 	L6		# goto L6
L5:
	li 	$v1, 0		# $v1 := 0
	sw 	$v1, 0($x21)	# [$x21+0] := $v1
	li 	$v1, 0		# $v1 := 0
	beqz	$v1, L7   	# if (signed) $v1 == 0 goto L7
	li 	$v1, 1		# $v1 := 1
				# $v1 := $v1
	j 	L8		# goto L8
L7:
	li 	$v1, 0		# $v1 := 0
				# $v1 := $v1
L8:
	move 	$x30, $v1	# $x30 := $v1
L6:
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x29, $v0	# $x29 := $v0
	sw 	$x30, 0($x29)	# [$x29+0] := $x30
	li 	$x39, 0		# $x39 := 0
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x38, $v0	# $x38 := $v0
	sw 	$x39, 0($x38)	# [$x38+0] := $x39
	lw 	$v1, 0($x29)	# $v1 := [$x29+0]
	beqz	$v1, L9   	# if (signed) $v1 == 0 goto L9
	li 	$v1, 1		# $v1 := 1
	sw 	$v1, 0($x38)	# [$x38+0] := $v1
	li 	$v1, 1		# $v1 := 1
	beqz	$v1, L11   	# if (signed) $v1 == 0 goto L11
	li 	$v1, 1		# $v1 := 1
				# $v1 := $v1
	j 	L12		# goto L12
L11:
	li 	$v1, 0		# $v1 := 0
				# $v1 := $v1
L12:
	move 	$x41, $v1	# $x41 := $v1
	j 	L10		# goto L10
L9:
	li 	$v1, 0		# $v1 := 0
	move 	$x41, $v1	# $x41 := $v1
L10:
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x40, $v0	# $x40 := $v0
	sw 	$x41, 0($x40)	# [$x40+0] := $x41
	la 	$x49, _printint	# $x49 := _printint
	lw 	$x55, 0($x11)	# $x55 := [$x11+0]
	lw 	$x56, 0($x13)	# $x56 := [$x13+0]
	add	$x54, $x55, $x56	# $x54 := $x55+$x56
	lw 	$x57, 0($x21)	# $x57 := [$x21+0]
	add	$x53, $x54, $x57	# $x53 := $x54+$x57
	lw 	$x58, 0($x29)	# $x58 := [$x29+0]
	add	$x52, $x53, $x58	# $x52 := $x53+$x58
	lw 	$x59, 0($x38)	# $x59 := [$x38+0]
	add	$x51, $x52, $x59	# $x51 := $x52+$x59
	lw 	$x60, 0($x40)	# $x60 := [$x40+0]
	add	$x50, $x51, $x60	# $x50 := $x51+$x60
	move 	$a0, $x50	# $a0 := $x50
	jalr 	$ra, $x49	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
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
