#utils.asm

#return0
.macro return0
	li $v0, 10
	syscall
.end_macro

#printInt
.macro printInt(%int)
	li	$v0, 1
	add	$a0, $zero, %int
	syscall
.end_macro

#readInt readInt
.macro readInt(%reg)
	li	$v0, 5
	syscall
	move %reg, $v0
.end_macro

#printStr
.macro printStr(%str)
	li	$v0, 4
	la	$a0, %str
	syscall
.end_macro

#readStr
.macro readStr(%buff, %len)
	li	$v0, 8
	la	$a0, %buff
	add	$a1, $zero, %len
	syscall
.end_macro