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
_factorial:
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
	li 	$x13, 0		# $x13 := 0
	seq	$x12, $x10, $x13	# $x12 := $x10==$x13
	beqz	$x12, L1   	# if (signed) $x12 == 0 goto L1
	li 	$v0, 1		# $v0 := 1
				# $v0 := $v0
	j 	L2		# goto L2
L1:
	li 	$x17, 0		# $x17 := 0
	slt	$x16, $x10, $x17	# $x16 := $x10<$x17
	beqz	$x16, L3   	# if (signed) $x16 == 0 goto L3
	li 	$v0, 1		# $v0 := 1
				# $v0 := $v0
	j 	L4		# goto L4
L3:
	la 	$x20, _factorial	# $x20 := _factorial
	li 	$x22, 1		# $x22 := 1
	sub	$x21, $x10, $x22	# $x21 := $x10-$x22
	move 	$a0, $x21	# $a0 := $x21
	jalr 	$ra, $x20	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	mulo	$v0, $x10, $v0	# $v0 := $x10*$v0
				# $v0 := $v0
L4:
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
_factorial.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	move 	$x24, $ra	# $x24 := $ra
	move 	$x25, $s0	# $x25 := $s0
	move 	$x26, $s1	# $x26 := $s1
	move 	$x27, $s2	# $x27 := $s2
	move 	$x28, $s3	# $x28 := $s3
	move 	$x29, $s4	# $x29 := $s4
	move 	$x30, $s5	# $x30 := $s5
	move 	$x31, $s6	# $x31 := $s6
	move 	$x32, $s7	# $x32 := $s7
	move 	$x33, $a0	# $x33 := $a0
	la 	$x34, _printint	# $x34 := _printint
	la 	$x35, _factorial	# $x35 := _factorial
	li 	$x36, 10		# $x36 := 10
	move 	$a0, $x36	# $a0 := $x36
	jalr 	$ra, $x35	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x37, $v0	# $x37 := $v0
	move 	$a0, $x37	# $a0 := $x37
	jalr 	$ra, $x34	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	move 	$ra, $x24	# $ra := $x24
	move 	$s0, $x25	# $s0 := $x25
	move 	$s1, $x26	# $s1 := $x26
	move 	$s2, $x27	# $s2 := $x27
	move 	$s3, $x28	# $s3 := $x28
	move 	$s4, $x29	# $s4 := $x29
	move 	$s5, $x30	# $s5 := $x30
	move 	$s6, $x31	# $s6 := $x31
	move 	$s7, $x32	# $s7 := $x32
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
