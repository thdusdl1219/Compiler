	.data 
NL:	.asciiz	"\n"
	.text 
main:
	addi 	$sp, $sp, -4	# $sp := $sp+-4
	sw 	$ra, 0($sp)	# [$sp+0] := $ra
	li 	$a0, 3		# $a0 := 3
	jal 	_fibrec		# call _fibrec
	move 	$a0, $v0	# $a0 := $v0
	jal 	_printint		# call _printint
	li 	$a0, 3		# $a0 := 3
	jal 	_fibiter		# call _fibiter
	move 	$a0, $v0	# $a0 := $v0
	jal 	_printint		# call _printint
	lw 	$ra, 0($sp)	# $ra := [$sp+0]
	addi 	$sp, $sp, 4	# $sp := $sp+4
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_printint:
	li 	$v0, 1		# $v0 := 1
	syscall 
	la 	$a0, NL	# $a0 := NL
	li 	$v0, 4		# $v0 := 4
	syscall 
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_fibrec:
	addi 	$sp, $sp, -12	# $sp := $sp+-12
	sw 	$ra, 8($sp)	# [$sp+8] := $ra
	sw 	$a0, 4($sp)	# [$sp+4] := $a0
	addi 	$a0, $a0, -2	# $a0 := $a0+-2
	addi 	$v0, $zero, 1	# $v0 := $zero+1
	bltz	$a0, done   	# if (signed) $a0 < 0 goto done
	jal 	_fibrec		# call _fibrec
	sw 	$v0, 0($sp)	# [$sp+0] := $v0
	lw 	$a0, 4($sp)	# $a0 := [$sp+4]
	addi 	$a0, $a0, -1	# $a0 := $a0+-1
	jal 	_fibrec		# call _fibrec
	lw 	$t0, 0($sp)	# $t0 := [$sp+0]
	add	$v0, $t0, $v0	# $v0 := $t0+$v0
done:
	lw 	$ra, 8($sp)	# $ra := [$sp+8]
	addi 	$sp, $sp, 12	# $sp := $sp+12
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
_fibiter:
	addi 	$t0, $zero, 1	# $t0 := $zero+1
	addi 	$t1, $zero, 1	# $t1 := $zero+1
loop:
	beq	$a0, $zero, end	# if (signed) $a0 ==$zero goto end
	addi 	$a0, $a0, -1	# $a0 := $a0+-1
	move 	$t2, $t0	# $t2 := $t0
	move 	$t0, $t1	# $t0 := $t1
	add	$t1, $t2, $t0	# $t1 := $t2+$t0
	j 	loop		# goto loop
end:
	add	$v0, $t0, $zero	# $v0 := $t0+$zero
	jr 	$ra		# also uses: $v0,$s0,$s1,$s2,$s3,$s4,$s5,$s6,$s7
