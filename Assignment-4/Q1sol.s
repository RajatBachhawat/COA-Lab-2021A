# Assignment #3
# Problem #3
# Semester: Autumn 2021
# Group: 46
# Member1: Neha Dalmia - 19CS30055
# Member2: Rajat Bachhawat - 19CS10073

.data
# program output text constants
inp_prompt:
    .asciiz "Enter four positive integers m, n, a, r:  "
matrixA_msg:
    .asciiz "\nMatrix A:\n"
matrixB_msg:
    .asciiz "\nMatrix B (Transpose of Matrix A):\n"
exit_msg: 
    .asciiz "\nExitted."
space:
    .asciiz " "
newline:
    .asciiz "\n"
#####Code Segment###########
    .text
    .globl main
# main program
# program variables

main:

initStack:                      # procedure for initialising the stack pointer & frame pointer
    addi    $sp, $sp, -4
    sw		$fp, 0($sp)
    move 	$fp, $sp
    j       $ra

pushToStack:                    # procedure for pushing to stack
    # $a0 = data to be pushed to stack
    addi    $sp, $sp, -4
    sw		$a0, 0($sp)
    j		$ra

popFromStack:
    lw      $v0, 0($sp)
    addi    $sp, $sp, 4
    j       $ra