	.data 
NL:	.asciiz	"\n"
	.text 
main:
	addi	$sp,$sp,-4
	sw	$ra,0($sp)	
	li	$a0,3
	jal	_fibrec
	move	$a0,$v0
	jal	_printint
	li	$a0,3
	jal	_fibiter
	move	$a0,$v0
	jal	_printint
	lw	$ra,0($sp)	
	addi	$sp,$sp,4
	jr	$ra

_fibrec:
  addi $sp,$sp,-12
  sw $ra,8($sp)
  sw $a0,4($sp)
  addi $a0,$a0,-2
  addi $v0,$0,1
  bltz $a0, done
  jal _fibrec
  sw $v0,0($sp)
  lw $a0,4($sp)
  addi $a0,$a0,-1
  jal _fibrec
  lw $t0,0($sp)
  add $v0,$t0,$v0
done:
  lw $ra,8($sp)
  addi $sp,$sp,12
  jr $ra

_fibiter:
  addi $t0,$0,1
  addi $t1,$0,1
loop:
  beq $a0,$0,end
  addi $a0,$a0,-1
  move $t2,$t0
  move $t0,$t1
  add $t1,$t2,$t0
  j loop
end:
  add $v0,$t0,$0
  jr $ra

_printint:
	li 	$v0, 1		# $v0 := 1
	syscall 
	la 	$a0, NL	# $a0 := NL
	li 	$v0, 4		# $v0 := 4
	syscall 
	jr 	$ra		
 



 # fibrec ( n ) = if n<2 then r=1 else (d=fibrec(n-2); e=fibrec(n-1); r=d+e); return r 
 # The iterative Fibonnacci function is,
 # fibiter ( n ) = a=1; b=1; while (n!=0) do (n=n-1; c=a; a=b; b=c+b); return a; 
