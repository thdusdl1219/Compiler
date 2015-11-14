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
	move 	$x20, $ra	# $x20 := $ra
	move 	$x21, $s0	# $x21 := $s0
	move 	$x22, $s1	# $x22 := $s1
	move 	$x23, $s2	# $x23 := $s2
	move 	$x24, $s3	# $x24 := $s3
	move 	$x25, $s4	# $x25 := $s4
	move 	$x26, $s5	# $x26 := $s5
	move 	$x27, $s6	# $x27 := $s6
	move 	$x28, $s7	# $x28 := $s7
	move 	$v1, $a0	# $v1 := $a0
	la 	$x30, _printint	# $x30 := _printint
	la 	$x31, _long_tuples	# $x31 := _long_tuples
	li 	$a0, 20		# $a0 := 20
	jal 	alloc		# call alloc
	move 	$x32, $v0	# $x32 := $v0
	li 	$x33, 1		# $x33 := 1
	sw 	$x33, 0($x32)	# [$x32+0] := $x33
	li 	$x34, 2		# $x34 := 2
	sw 	$x34, 4($x32)	# [$x32+4] := $x34
	li 	$x35, 3		# $x35 := 3
	sw 	$x35, 8($x32)	# [$x32+8] := $x35
	li 	$x36, 4		# $x36 := 4
	sw 	$x36, 12($x32)	# [$x32+12] := $x36
	li 	$x37, 5		# $x37 := 5
	sw 	$x37, 16($x32)	# [$x32+16] := $x37
	move 	$a0, $x32	# $a0 := $x32
	jalr 	$ra, $x31	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x38, $v0	# $x38 := $v0
	move 	$a0, $x38	# $a0 := $x38
	jalr 	$ra, $x30	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	move 	$ra, $x20	# $ra := $x20
	move 	$s0, $x21	# $s0 := $x21
	move 	$s1, $x22	# $s1 := $x22
	move 	$s2, $x23	# $s2 := $x23
	move 	$s3, $x24	# $s3 := $x24
	move 	$s4, $x25	# $s4 := $x25
	move 	$s5, $x26	# $s5 := $x26
	move 	$s6, $x27	# $s6 := $x27
	move 	$s7, $x28	# $s7 := $x28
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
