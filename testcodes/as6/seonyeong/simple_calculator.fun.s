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
	move 	$t5, $ra	# $t5 := $ra
	move 	$t4, $s0	# $t4 := $s0
	move 	$t3, $s1	# $t3 := $s1
	move 	$t2, $s2	# $t2 := $s2
	move 	$t1, $s3	# $t1 := $s3
	move 	$t0, $s4	# $t0 := $s4
	move 	$a3, $s5	# $a3 := $s5
	move 	$a2, $s6	# $a2 := $s6
	move 	$a1, $s7	# $a1 := $s7
	move 	$v0, $a0	# $v0 := $a0
	lw 	$v1, 0($v0)	# $v1 := [$v0+0]
	lw 	$v0, 4($v0)	# $v0 := [$v0+4]
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
_add.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_sub:
	move 	$t5, $ra	# $t5 := $ra
	move 	$t4, $s0	# $t4 := $s0
	move 	$t3, $s1	# $t3 := $s1
	move 	$t2, $s2	# $t2 := $s2
	move 	$t1, $s3	# $t1 := $s3
	move 	$t0, $s4	# $t0 := $s4
	move 	$a3, $s5	# $a3 := $s5
	move 	$a2, $s6	# $a2 := $s6
	move 	$a1, $s7	# $a1 := $s7
	move 	$v0, $a0	# $v0 := $a0
	lw 	$v1, 4($v0)	# $v1 := [$v0+4]
	lw 	$v0, 0($v0)	# $v0 := [$v0+0]
	sub	$v0, $v0, $v1	# $v0 := $v0-$v1
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
_sub.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_mul:
	move 	$t5, $ra	# $t5 := $ra
	move 	$t4, $s0	# $t4 := $s0
	move 	$t3, $s1	# $t3 := $s1
	move 	$t2, $s2	# $t2 := $s2
	move 	$t1, $s3	# $t1 := $s3
	move 	$t0, $s4	# $t0 := $s4
	move 	$a3, $s5	# $a3 := $s5
	move 	$a2, $s6	# $a2 := $s6
	move 	$a1, $s7	# $a1 := $s7
	move 	$v0, $a0	# $v0 := $a0
	lw 	$v1, 0($v0)	# $v1 := [$v0+0]
	lw 	$v0, 4($v0)	# $v0 := [$v0+4]
	mulo	$v0, $v1, $v0	# $v0 := $v1*$v0
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
_mul.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_func:
	move 	$t4, $ra	# $t4 := $ra
	move 	$t3, $s0	# $t3 := $s0
	move 	$t2, $s1	# $t2 := $s1
	move 	$t1, $s2	# $t1 := $s2
	move 	$t0, $s3	# $t0 := $s3
	move 	$a3, $s4	# $a3 := $s4
	move 	$a2, $s5	# $a2 := $s5
	move 	$a1, $s6	# $a1 := $s6
	move 	$v1, $s7	# $v1 := $s7
				# $a0 := $a0
	li 	$v0, 1		# $v0 := 1
	seq	$v0, $a0, $v0	# $v0 := $a0==$v0
	beqz	$v0, L1   	# if (signed) $v0 == 0 goto L1
	la 	$v0, _add	# $v0 := _add
				# $v0 := $v0
	j 	L2		# goto L2
L1:
	li 	$v0, 2		# $v0 := 2
	seq	$v0, $a0, $v0	# $v0 := $a0==$v0
	beqz	$v0, L3   	# if (signed) $v0 == 0 goto L3
	la 	$v0, _sub	# $v0 := _sub
				# $v0 := $v0
	j 	L4		# goto L4
L3:
	la 	$v0, _mul	# $v0 := _mul
				# $v0 := $v0
L4:
				# $v0 := $v0
L2:
				# $v0 := $v0
	move 	$ra, $t4	# $ra := $t4
	move 	$s0, $t3	# $s0 := $t3
	move 	$s1, $t2	# $s1 := $t2
	move 	$s2, $t1	# $s2 := $t1
	move 	$s3, $t0	# $s3 := $t0
	move 	$s4, $a3	# $s4 := $a3
	move 	$s5, $a2	# $s5 := $a2
	move 	$s6, $a1	# $s6 := $a1
	move 	$s7, $v1	# $s7 := $v1
_func.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_main:
	move 	$x59, $ra	# $x59 := $ra
	move 	$x60, $s0	# $x60 := $s0
	move 	$x61, $s1	# $x61 := $s1
	move 	$x62, $s2	# $x62 := $s2
	move 	$x63, $s3	# $x63 := $s3
	move 	$x64, $s4	# $x64 := $s4
	move 	$x65, $s5	# $x65 := $s5
	move 	$x66, $s6	# $x66 := $s6
	move 	$x67, $s7	# $x67 := $s7
	move 	$v1, $a0	# $v1 := $a0
	li 	$x70, 1		# $x70 := 1
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x69, $v0	# $x69 := $v0
	sw 	$x70, 0($x69)	# [$x69+0] := $x70
	li 	$x72, 2		# $x72 := 2
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x71, $v0	# $x71 := $v0
	sw 	$x72, 0($x71)	# [$x71+0] := $x72
	li 	$x74, 3		# $x74 := 3
	li 	$a0, 4		# $a0 := 4
	jal 	alloc		# call alloc
	move 	$x73, $v0	# $x73 := $v0
	sw 	$x74, 0($x73)	# [$x73+0] := $x74
	li 	$x75, 20		# $x75 := 20
	li 	$x76, 5		# $x76 := 5
	la 	$x77, _printint	# $x77 := _printint
	la 	$x78, _func	# $x78 := _func
	lw 	$x79, 0($x69)	# $x79 := [$x69+0]
	move 	$a0, $x79	# $a0 := $x79
	jalr 	$ra, $x78	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x80, $v0	# $x80 := $v0
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x81, $v0	# $x81 := $v0
	sw 	$x75, 0($x81)	# [$x81+0] := $x75
	sw 	$x76, 4($x81)	# [$x81+4] := $x76
	move 	$a0, $x81	# $a0 := $x81
	jalr 	$ra, $x80	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x82, $v0	# $x82 := $v0
	move 	$a0, $x82	# $a0 := $x82
	jalr 	$ra, $x77	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x83, $v0	# $x83 := $v0
	la 	$x84, _printint	# $x84 := _printint
	la 	$x85, _func	# $x85 := _func
	lw 	$x86, 0($x71)	# $x86 := [$x71+0]
	move 	$a0, $x86	# $a0 := $x86
	jalr 	$ra, $x85	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x87, $v0	# $x87 := $v0
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x88, $v0	# $x88 := $v0
	sw 	$x75, 0($x88)	# [$x88+0] := $x75
	sw 	$x76, 4($x88)	# [$x88+4] := $x76
	move 	$a0, $x88	# $a0 := $x88
	jalr 	$ra, $x87	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x89, $v0	# $x89 := $v0
	move 	$a0, $x89	# $a0 := $x89
	jalr 	$ra, $x84	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x90, $v0	# $x90 := $v0
	la 	$x91, _printint	# $x91 := _printint
	la 	$x92, _func	# $x92 := _func
	lw 	$x93, 0($x73)	# $x93 := [$x73+0]
	move 	$a0, $x93	# $a0 := $x93
	jalr 	$ra, $x92	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x94, $v0	# $x94 := $v0
	li 	$a0, 8		# $a0 := 8
	jal 	alloc		# call alloc
	move 	$x95, $v0	# $x95 := $v0
	sw 	$x75, 0($x95)	# [$x95+0] := $x75
	sw 	$x76, 4($x95)	# [$x95+4] := $x76
	move 	$a0, $x95	# $a0 := $x95
	jalr 	$ra, $x94	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
	move 	$x96, $v0	# $x96 := $v0
	move 	$a0, $x96	# $a0 := $x96
	jalr 	$ra, $x91	# ($a0) := call $ra($v0,$ra,$a0,$a1,$a2,$a3,$t0,$t1,$t2,$t3,$t4,$t5,$t6,$t7,$t8,$t9,$v0,$v1)
				# $v0 := $v0
	li 	$v0, 0		# $v0 := 0
				# $v0 := $v0
	move 	$ra, $x59	# $ra := $x59
	move 	$s0, $x60	# $s0 := $x60
	move 	$s1, $x61	# $s1 := $x61
	move 	$s2, $x62	# $s2 := $x62
	move 	$s3, $x63	# $s3 := $x63
	move 	$s4, $x64	# $s4 := $x64
	move 	$s5, $x65	# $s5 := $x65
	move 	$s6, $x66	# $s6 := $x66
	move 	$s7, $x67	# $s7 := $x67
_main.epilog:
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
