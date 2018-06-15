# This assembly language program reads in an integer, and
# prints out it's fibonacci, recursively.
# Filename : FibonacciRecursive.asm

        .data
Input:  .asciiz "\nEnter an Integer: "
Output: .asciiz "\n\nIt's fibonacci is "
        .text
        .globl main

main:

        li $v0,4
        la $a0,Input
        syscall                         # System calls to print message
        li $v0,5
        syscall                         # System reads in an integer
        move $t0,$v0                    # And copies it to temp reg 0.
        jal Recursion                   # Jump can link to function.

        move $t0, $v0                   
        li $v0, 4
        la $a0, Output
        syscall                         # Prints out Message
        move $a0,$t0
        li $v0,1
        syscall                         # Prints out our Integer
        li $v0,10
        syscall                         # Program Exit

Recursion:

        addi $sp,$sp,-12 
        sw $ra,0($sp)
        sw $s0,4($sp)
        sw $s1,8($sp)                   # Saves onto the Stack

        add $s0,$t0,$zero

        addi $t1,$zero,1                # Initializes to 1 for Comparison
        beq $s0,$zero, CaseZero         # Checks if equal to zero
        beq $s0,$t1, CaseOne            # Checks if equal to one

        addi $t0,$s0,-1                 # Otherwise Subtracts one from integer (N - 1)

        jal Recursion                   # Calls recursively until equal to 1 or 0.

        add $s1,$zero,$v0               

        addi $t0,$s0,-2                 # N - 2

        jal Recursion               

        add $v0,$v0,$s1                 # (N - 1) + (N - 2)

Exit:

        lw $ra,0($sp)       
        lw $s0,4($sp)
        lw $s1,8($sp)
        addi $sp,$sp,12                 # Pops stack
        jr $ra                          # Returns to address on stack

CaseZero:   
        li $v0,0                        # Return 0
        j Exit

CaseOne:
        li $v0,1                        # Return 1
        j Exit