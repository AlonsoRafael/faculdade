#bubblesort.asm

.include "utils.asm"


.data
#  int n;
	n:	.space 4
	temp:	.space 4
#  int arr[100]; 
	arr:	.space 400
	str1:	.asciiz "Digite n:"
	str2:   .asciiz "digite o num: "
	str3:   .asciiz "Array after implementing Bubble sort: "
.text
#	printf("Digite n:")
	printStr(str1)
	readInt($s0)
#salva o num lido na mem ria(n)
	la		$t0, n
	sw		$s0, 0($t0)

	#ganha acesso ao array
	la		$s7, arr
#for(int i = 0; i <n; i++)	
	addi	$s1, $zero, 0  # s1 = 0 (i)
F1:	slt		$t7, $s1, $s0
	beq		$t7, $zero, S1
	#corpo do for		
	#printf("digite o num: ");
	printStr(str2)
	#scanf("%d", arr[i]);
	readInt($s2)
	sll	$t3, $s1, 2   # tmp = i * 4 eq multi $t3, $s1, 4
	add $t3, $t3, $s7
	sw	$s2, 0($t3)
	#sw	$s2, 0($s7)
	#addi	$s7, $s7, 4
	
	#\corpo do for
	addi	$s1, $s1, 1
	j		F1
S1:
	#COMECA O BUBBLE#
	
#for (int i = 0; i < n - 1; i++)
	add		$s1, $zero,$zero  # i = 0
F2:	addi	$t0, $s0, -1
	slt		$t1, $s1, $t0
	beq		$t1, $zero, S2
	#corpo de F2	
	#for (int j = 0; j < n - i - 1; j++)
	add		$s2, $zero, $zero   # j = 0
F3: sub		$t2, $s0, $s1
	addi	$t2, $t2, -1
	slt		$t3, $s2, $t2
	beq		$t3, $zero, S3
	#corpo do F3
	
	#if (arr[j] > arr[j + 1])
	la		$s7, arr
	sll		$t4, $s2, 2		
	add		$t4, $t4, $s7	#&arr[j]
	lw		$t5, 0($t4)		#*arr[j]
	lw		$t6, 4($t4) 	#*arr[j+1]
	slt		$t7, $t6, $t5
	beq		$t7, $zero, SF1	 	
	#corpo do IF
	#int temp = arr[j];
	la	$at, temp
	sw	$t5, 0($at)
	
	#arr[j] = arr[j + 1];
	sw	$t6, 0($t4)
	
	#arr[j + 1] = temp;
	sw	$t5,4($t4)	 	
	#\corpo do IF
SF1:		 		 		 	
	#\corpo do F3
	addi	$s2, $s2, 1
	j		F3	 		 	
S3:		 		 		 		 	
	#\corpo do F2
	addi	$s1, $s1, 1
	j		F2

S2:	
#  printf("Array after implementing Bubble sort: ");
	printStr(str3)

	la	$s7, arr
#  for (int i = 0; i < n; i++) {		
	add		$s1, $zero, $zero
F4:	slt		$t0, $s1, $s0
	beq		$t0, $zero, S4
	#corpo do F4
	#    printf("%d  ", arr[i]);	
	sll	$t2, $s1, 2
	add	$t2, $t2, $s7
	lw	$t3, 0($t2)		
	printInt($t3)
	#\corpo do F4
	addi	$s1, $s1, 1
	j		F4
S4:
	return0
