#factorial
.text
.globl main
main:
subu $sp,$sp,32
sw $ra,20,($sp)
sw $fp,16,($sp)
addu $fp,$sp,32

li $a0,10
la $t0,fact
jalr $t0

lw $ra,20($sp)
lw $fp,16($sp)
j $ra
fact:
subu $sp,$sp,32
sw $ra,20($sp)
sw $fp,16($sp)
addu $fp,$sp,32

sw $a0,0($fp)

lw $2,0($fp)
move $2,$a0

bgtz $2,$L2
li $2,1
j $L1

$L2:
lw $3,0($fp)
subu $2,$3,1
#subu $2, $2,1
move $a0,$2
jal fact

lw $3,0($fp)
mul $2,$2,$3

$L1:
lw $31,20($sp)
lw $fp,16($sp)
addu $sp,$sp,32
j $31


