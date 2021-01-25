	.data

	_true_print_string: .asciiz "true"
	_false_print_string: .asciiz "false"

	aa: .word 0
	_ab: .space 6
	_ac: .space 8
	_ad: .space 0

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

	# Storing string "Hello..." into data segment
	la $s0, _ab
	li $s1, 'H'
	sb $s1, 0($s0)
	li $s1, 'e'
	sb $s1, 1($s0)
	li $s1, 'l'
	sb $s1, 2($s0)
	li $s1, 'l'
	sb $s1, 3($s0)
	li $s1, 'o'
	sb $s1, 4($s0)
	li $s1, ' '
	sb $s1, 5($s0)
	# Storing string " world!..." into data segment
	la $s0, _ac
	li $s1, ' '
	sb $s1, 0($s0)
	li $s1, 'w'
	sb $s1, 1($s0)
	li $s1, 'o'
	sb $s1, 2($s0)
	li $s1, 'r'
	sb $s1, 3($s0)
	li $s1, 'l'
	sb $s1, 4($s0)
	li $s1, 'd'
	sb $s1, 5($s0)
	li $s1, '!'
	sb $s1, 6($s0)
	li $s1, ' '
	sb $s1, 7($s0)
	# Adding _ab and _ac
	# Storing string "Hello worl..." into data segment
	la $s0, _ad
	li $s1, 'H'
	sb $s1, 0($s0)
	li $s1, 'e'
	sb $s1, 1($s0)
	li $s1, 'l'
	sb $s1, 2($s0)
	li $s1, 'l'
	sb $s1, 3($s0)
	li $s1, 'o'
	sb $s1, 4($s0)
	li $s1, ' '
	sb $s1, 5($s0)
	li $s1, 'w'
	sb $s1, 6($s0)
	li $s1, 'o'
	sb $s1, 7($s0)
	li $s1, 'r'
	sb $s1, 8($s0)
	li $s1, 'l'
	sb $s1, 9($s0)
	li $s1, 'd'
	sb $s1, 10($s0)
	li $s1, '!'
	sb $s1, 11($s0)
	li $s1, ' '
	sb $s1, 12($s0)
	# Assigning _ad to aa
	la $s0, _ad
	la $s1, aa
	sw $s0, 0($s1)
	
	# Printing aa
	li $v0, 4
	lw $a0, aa
	syscall
	
	# Printing new line
	li $a0, 0xA
	li $v0, 0xB
	syscall
	
	# Exit!
	li $v0, 10
	syscall
	
	
