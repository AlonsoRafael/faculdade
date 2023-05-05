# Rafael Alonso 04/05/2023
        
.data
        
msg:    .asciiz "Digite um número: "
resultado: .asciiz "O fatorial é: "
num:	.word 0
a:	.word 0

.text
        
        # imprimir pergunta
        li $v0, 4
        la $a0, msg
        syscall

        # ler número
        li $v0, 5
        syscall
        
        sw $v0,num

        # calcular o fatorial
        lw $a0,num
        jal fatorial
        sw $v0,a

        # imprimir mensagem do resultado
        li $v0, 4
        la $a0, resultado
        syscall
        
        # imprimindo numedo do resuldado
        li $v0,1
        lw $a0,a
        syscall
        
        # retur 0
	li $v0, 10
	syscall

        
######################################################

fatorial:
	subu $sp,$sp,8
	sw $ra,($sp)
	sw $s0,4($sp)

	li $v0,1
	beq $a0,0,fatorialrecur
	
	move $s0,$a0
	sub $a0,$a0,1
	jal fatorial
	
	mul $v0,$s0,$v0
	
	fatorialrecur:
		lw $ra,($sp)
		lw $s0,4($sp)
		addu $sp,$sp,8
		jr $ra
		