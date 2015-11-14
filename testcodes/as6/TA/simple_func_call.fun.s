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
_add:
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
	lw 	$v0, 4($v0)	# $v0 := [$v0+4]
	add	$v0, $a0, $v0	# $v0 := $a0+$v0
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
_add.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	move 	$x14, $ra	# $x14 := $ra
	move 	$x15, $s0	# $x15 := $s0
	move 	$x16, $s1	# $x16 := $s1
	move 	$x17, $s2	# $x17 := $s2
	move 	$x18, $s3	# $x18 := $s3
	move 	$x19, $s4	# $x19 := $s4
	move 	$x20, $s5	# $x20 := $s5
	move 	$x21, $s6	# $x21 := $s6
	move 	$x22, $s7	# $x22 := $s7
	move 	$v1, $a0	# $v1 := $a0
	la 	$x24, _printint	# $x24 := _printint
	la 	$x25, _add	# $x25 := _add
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x26, $v0	# $x26 := $v0
	li 	$x27, 5		# $x27 := 5
	sw 	$x27, 0($x26)	# [$x26+0] := $x27
	li 	$x28, 6		# $x28 := 6
	sw 	$x28, 4($x26)	# [$x26+4] := $x28
	move 	$a0, $x26	# $a0 := $x26
	jalr 	$ra, $x25	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x29, $v0	# $x29 := $v0
	move 	$a0, $x29	# $a0 := $x29
	jalr 	$ra, $x24	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	move 	$ra, $x14	# $ra := $x14
	move 	$s0, $x15	# $s0 := $x15
	move 	$s1, $x16	# $s1 := $x16
	move 	$s2, $x17	# $s2 := $x17
	move 	$s3, $x18	# $s3 := $x18
	move 	$s4, $x19	# $s4 := $x19
	move 	$s5, $x20	# $s5 := $x20
	move 	$s6, $x21	# $s6 := $x21
	move 	$s7, $x22	# $s7 := $x22
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
