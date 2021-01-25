	.data

	_true_print_string: .asciiz "true"
	_false_print_string: .asciiz "false"

	aa: .word 0
	ab: .word 0
	_ac: .word 5
	_ad: .word 3
	_ae: .word 3
	_af: .word 0
	_ah: .word 0
	_ai: .word 2

	.text
	.globl main

	
_print_true:
	li $v0, 4
	la $a0, _true_print_string
	syscall
	jr $ra
	
_print_false:
	li $v0, 4
	la $a0, _false_print_string
	syscall
	jr $ra
	
	
main:

	# Assigning _ac to aa
	lw $a0, _ac
	la $a1, aa
	sw $a0, 0($a1)
	
	# Assigning _ad to ab
	lw $a0, _ad
	la $a1, ab
	sw $a0, 0($a1)
	
	# Is ab less or equal to _ae? 
	lw $a0, ab
	lw $a1, _ae
	sle $t0, $a0, $a1
	la $a2, _af
	sw $t0, 0($a2)
	
	# if statement
	lw $a0, _af
	beq $a0, 0, ag
	
	# Assigning _ah to aa
	lw $a0, _ah
	la $a1, aa
	sw $a0, 0($a1)
	
	# Assigning _ai to ab
	lw $a0, _ai
	la $a1, ab
	sw $a0, 0($a1)
	
ag:

	# Printing aa
	li $v0, 1
	lw $a0, aa
	syscall
	
	# Printing new line
	li $a0, 0xA
	li $v0, 0xB
	syscall
	
	# Printing ab
	li $v0, 1
	lw $a0, ab
	syscall
	
	# Printing new line
	li $a0, 0xA
	li $v0, 0xB
	syscall
	
	# Exit!
	li $v0, 10
	syscall
	
	
