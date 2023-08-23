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

.macro printChr(%chr)
	li	$v0, 11
	add	$a0, $zero, %chr
	syscall
.end_macro
#readStr
.macro readStr(%buff, %len)
	li	$v0, 8
	la	$a0, %buff
	add	$a1, $zero, %len
	syscall
.end_macro

.macro PUSH
	sw	$ra, 0($sp)
	sw	$a0, -4($sp)
	sw	$a1, -8($sp)
	sw	$a2, -12($sp)
	sw	$a3, -16($sp)
	sw	$s0, -20($sp)
	sw	$s1, -24($sp)
	sw	$s2, -28($sp)
	sw	$s3, -32($sp)
	sw	$s4, -36($sp)
	sw	$s5, -40($sp)
	sw	$s6, -44($sp)
	sw	$s7, -48($sp)
	addi $sp, $sp, -52
.end_macro

.macro POP
	addi $sp, $sp, 52
	lw	$ra, 0($sp)
	lw	$a0, -4($sp)
	lw	$a1, -8($sp)
	lw	$a2, -12($sp)
	lw	$a3, -16($sp)
	lw	$s0, -20($sp)
	lw	$s1, -24($sp)
	lw	$s2, -28($sp)
	lw	$s3, -32($sp)
	lw	$s4, -36($sp)
	lw	$s5, -40($sp)
	lw	$s6, -44($sp)
	lw	$s7, -48($sp)
.end_macro