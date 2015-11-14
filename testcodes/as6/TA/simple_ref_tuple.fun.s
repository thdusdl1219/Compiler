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
	li 	$a0, 16		# $a0 := 16
	jal 	alloc		# call alloc
	move 	$x12, $v0	# $x12 := $v0
	li 	$v1, 1		# $v1 := 1
	sw 	$v1, 0($x12)	# [$x12+0] := $v1
	li 	$v1, 2		# $v1 := 2
	sw 	$v1, 4($x12)	# [$x12+4] := $v1
	li 	$v1, 3		# $v1 := 3
	sw 	$v1, 8($x12)	# [$x12+8] := $v1
	li 	$v1, 4		# $v1 := 4
	sw 	$v1, 12($x12)	# [$x12+12] := $v1
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x11, $v0	# $x11 := $v0
	sw 	$x12, 0($x11)	# [$x11+0] := $x12
	la 	$x17, _printint	# $x17 := _printint
	lw 	$x18, 0($x11)	# $x18 := [$x11+0]
	lw 	$x19, 8($x18)	# $x19 := [$x18+8]
	move 	$a0, $x19	# $a0 := $x19
	jalr 	$ra, $x17	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
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
