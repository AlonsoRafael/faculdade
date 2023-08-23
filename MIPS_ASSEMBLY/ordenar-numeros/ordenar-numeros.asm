#Primeiro trabalho pratico

.include "utils.asm"


.data 
#  int n;
	i:	.space 4
	count:	.space 4

	arr:	.space 8000   # int arr[2000]; 
	
	str1:	.asciiz "(obs: mao deve ser inferior a 1000)\nDigite quantos numeros quer: "
	str2:   .asciiz "digite os "
	str2_2: .asciiz " numeros: "
	str3:   .asciiz "Array ordenado: "
	str_espaco: .asciiz " "
.text

v:	#printf("Digite n:")
	printStr(str1)
	readInt($s0)
	
	slti $t1,$s0,5	# mude aqui para testa com um valor menor
	addi $t2,$zero,1
	beq $t1,$t2,v

	la		$t0, count
	sw		$s0, 0($t0)	
	
	#printf("digite os numeros que quer: ");
	printStr(str2)
	printInt($s0)
	printStr(str2_2)
		
	

#ganha acesso ao array
	la		$s7, arr
#for(int i = 0; i <n; i++)	
	addi	$s1, $zero, 0  # s1 = 0 (i)
F1:	slt		$t7, $s1, $s0
	beq		$t7, $zero, S1
	#corpo do for
	#scanf("%d", arr[i]);
	readInt($s2)
	sw	$s2, 0($s7)
	addi $s7,$s7,4
	#\corpo do for
	addi	$s1, $s1, 1
	j		F1
S1:	#	quicksort(number,0,count-1);
	#(1) setar argumentos
	#arg0 - ponteiro para o array number
	la		$a0, arr
	#arg1 - primeiro
	add		$a1, $zero, $zero 
	#arg2 - ultimo
	la		$t0, count
	lw		$a2, 0($t0)
	#(2) chamar a funcao
	jal		quicksort
	#(7) recuperar o valor de retorno
	#-----
	
	la		$s7, arr
	printStr(str3)
	addi		$s1, $zero, 0     	#i = 0
	
F2:	slt		$t0, $s1, $s0		# se i < count
	beq		$t0, $zero, SF2
	#corpo do for
	lw		$t1, 4 ($s7)
	printInt($t1)
	printStr(str_espaco)
	addi	$s7, $s7, 4
	#/corpo do for
	addi	$s1, $s1, 1
	j		F2
SF2:		
			


return0

#--------------------------------------------------------------------------------


quicksort:

addi $sp,$sp,-20  

sw $ra,0($sp)       

sw $s0,4($sp)      

sw $s1,8($sp)       

sw $s2,12($sp)      

sw $s3,16($sp)      

bge $a1,$a2,endif1          

move $s0,$a0                # a0 = s0

move $s1,$a1                # a1 = s1

move $s2,$a2                # a2 = s2

jal partition               # j = partition( a, l, r);

move $s3,$v0                # retorno em s3 (j)

move $a0,$s0                # a0 = s0

move $a1,$s1                # a1 = s1

addi $a2,$s3,-1             # j-1

jal  quicksort              # quickSort( a, l, j-1);

move $a0,$s0                #  a0 = s0

addi $a1,$s3,1              # j+1

move $a2,$s2                #  a2 = s2

jal  quicksort              # quickSort( a, j+1, r);


endif1:                         

lw $ra,0($sp)       

lw $s0,4($sp)       

lw $s1,8($sp)       

lw $s2,12($sp)      

lw $s3,16($sp)      

addi $sp,$sp,20     

jr $ra


partition:

addi $sp,$sp,-16    

sw $ra,0($sp)       

sw $s0,4($sp)      

sw $s1,8($sp)       

sw $s2,12($sp)      

sll $t4,$a1,2       # 1x4

add $t4,$t4,$a0     

lw  $s0,($t4)       # pivot = a[l]

move $s1,$a1        # i = l

addi $s2,$a2,1      # j = r+1

while1:                 



do1:                    

addi $s1,$s1,1      #   ++i;

sll $t1,$s1,2       # i x 4

add $t1,$t1,$a0     # a[i] em t1

lw  $t0,($t1)       # $t0 = a[i]

bgt $t0,$s0,do2     # while( a[i] <= pivot && i <= r )

bgt $s1,$a2,do2

b   do1

do2:                    

addi $s2,$s2,-1     # –j;

sll $t2,$s2,2       # j x 4 

add $t2,$t2,$a0     # [j] em t2

lw  $t0,($t2)       # $t0 = a[j]

bgt $t0,$s0,do2     # while( a[j] > pivot );

bge $s1,$s2,brk1    # if( i >= j ) break;

lw $t0,($t1)        # t = a[i];

lw $t3,($t2)        # a[i] = a[j];

sw $t3,($t1)

sw $t0,($t2)        # a[j] = t;

b while1            

brk1:

lw $t0,($t4)        # t = a[l];

lw $t3,($t2)        # a[l] = a[j];

sw $t3,($t4)

sw $t0,($t2)        # a[j] = t;

move $v0,$s2        # return j;

lw $ra,0($sp)       

lw $s0,4($sp)       

lw $s1,8($sp)       

lw $s2,12($sp)      

addi $sp,$sp,16     

jr $ra


