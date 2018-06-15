# This assembly language program reads in an integer, and
# prints out it's fibonacci, NONrecursively.
# Filename : FibonacciNon.asm

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
        move $s0,$v0                    # And copies it to temp reg 0.
        addi $s7,$zero,1
        add $s1,$zero,$zero
        add $s2,$zero,$zero
        addi $s3,$zero,1
        addi $s4,$zero,1

        beqz $s0,CaseZero              # Checks if equal to zero
        beq $s0,$s7,CaseOne            # Checks if equal to one

Loop:
        bge $s4,$s0,Exit
        add $s1,$s2,$s3
        add $s2,$zero,$s3
        add $s3,$zero,$s1
        addi $s4,$s4,1
        j Loop

Exit:                
        li $v0, 4
        la $a0, Output
        syscall                         # Prints out Message
        move $a0,$s1
        li $v0,1
        syscall                         # Prints out our Integer
        li $v0,10
        syscall                         # Program Exit


CaseZero:   
        add $s1,$zero,$zero             # Return 0
        j Exit

CaseOne:
        addi $s1,$zero,1                # Return 1
        j Exit