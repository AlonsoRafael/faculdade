# Segundo trabalho extra
#RA 22/04/23
.data
	
	pala: 	.space 128
	
.text

    # lendo a string
    li $v0, 8      
    la $a0, pala  
    li $a1, 8    
    syscall        

    
    move $t0, $a0   
    li $t1, 'a'    # valor ASCII da letra 'a'
    li $t2, 'z'    # valor ASCII da letra 'z'

while:
    lb $t3, ($t0)   # carrega um byte da palavra
    beqz $t3, sai  # se chegou ao fim da palavra, sai do while
    blt $t3, $t1, prox  # se a letra não for uma letra minúscula, pula para o próximo byte
    bgt $t3, $t2, prox  # se a letra não for uma letra minúscula, pula para o próximo byte
    subi $t3, $t3, 32   # converte a letra minúscula para maiúscula (subtrai 32 do valor ASCII)
    sb $t3, ($t0)       # salva o byte de volta na string
prox:
    addi $t0, $t0, 1   # incrementando para o próximo byte da string
    j while             

sai:
    # imprimindo a string
    li $v0, 4      
    la $a0, pala
    syscall        

    # return 0
    li $v0, 10
    syscall
