# This assembly language program reads in three integers, takes the smallest
# two and adds them, then prints the result.
# Filename : SampleProgram.asm

        .data
        .align 2
        .space 12
String: .space 16
Input1: .asciiz "\nEnter 1st integer = "
Input2: .asciiz "\nEnter 2nd integer = "
Input3: .asciiz "\nEnter 3rd integer = "
Output: .asciiz "\n\nThe sum of the smallest two integers entered is "

        .text
        .globl main
main:
        li $v0,4                    
        la $a0,Input                # System calls to print the string
        syscall                        

        li $v0,5                     # System call to read input
        syscall                      
        move $t0,$v0                 # Move the input into temp reg 0

        li $v0,4
        la $a0, Input2               # repeats process above for next two inputs
        syscall

        li $v0, 5
        syscall                      # input 2 stored in temp reg 1, and 3 in temp reg 2
        move $t1, $v0

        li $v0,4
        la $a0, Input3
        syscall

        li $v0, 5
        syscall
        move $t2, $v0

        bge $t2, $t1, A              # Jumps if $t2 holds the higher value
        move $t3, $t2
        move $t2, $t1
        move $t1, $t3				 # swaps the two registers

        A:
        bge $t2, $t0, B              # Jumps if $t2 holds the higher value
        move $t3, $t2
        move $t2, $t0
        move $t0, $t3                # swaps if it doesn't

        B:
        addu $t0, $t0, $t1           # adds the two smallest integers
        li $v0, 4 
		la $a0, Output
		syscall                      

		li $v0, 1 
		move $a0, $t0 
		syscall                      # displays the sum to the user

		li $2, 10
		syscall

