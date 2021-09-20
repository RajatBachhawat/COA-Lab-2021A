# Assignment #4
# Problem #2
# Semester: Autumn 2021
# Group: 46
# Member1: Neha Dalmia - 19CS30055
# Member2: Rajat Bachhawat - 19CS10073

.data
# program output text constants
number_prompt1:
   .asciiz "Enter 10 numbers (one in each line):  "
print_msg: 
    .asciiz "Sorted array :\n"
exit_msg: 
    .asciiz "\nExitted."
newline:
   .asciiz "\n"
space:
    .asciiz " "
array: 
    .align 2
    .space 40
    .align 0
length:
    .word 10
#####Code Segment###########
   .text
   .globl main
# main program


main:
    jal initStack

first_inp:  

   la $a0,number_prompt1           #  ask for the  input
   li $v0,4
   syscall

   li		$v0, 4		        # $v0 = 4
   la		$a0, newline	    # load address of newline string
   syscall

   la $s0,array
   li $t0,0                     # loop variable  = 0;

loop: 
   
   li		$v0, 5		        # $v0 = 5
   syscall
   sw   $v0,0($s0)              # taking input for current array element
   addi $s0,$s0,4               # updating array pointer
   addi $t0,$t0,1               # updating loop variable
   blt  $t0,10,loop             # checking if loop should continue

   la $a0,array     # arguments for recursive_sort
   li $a1,0
   li $a2,9

   jal recursive_sort

   la $a0,array     # arguments for print_array
   li $a1,10

   jal printArray

Exit:
    la      $a0, exit_msg          # load address of err message in $a0
    li		$v0, 4	        	   
    syscall                         # print exit message
    li		$v0, 10		            
    syscall                         # syscall to exit from the program

Error_Exit:
    la      $a0, error_msg          # load address of err message in $a0
    li		$v0, 4	        	   
    syscall                         # print error message
    j find_k_largest                       # re-input


printArray:
# prints the array elements
# $a0 = array pointer
# $a1 = size of array

    li $t0,0                     # loop variable
    move $t3,$a0
    
    la $a0,print_msg
    li $v0,4
    syscall

loop2:

               
    lw $a0,0($t3)               # printing the current element
    li		$v0, 1		        
    syscall

    li		$v0, 4		    # $v0 = 4   
    la		$a0, space	    # load address of newline string
    syscall

    addi $t3,$t3,4          # updating the pointer to memory location
    addi $t0,$t0,1          # incrementing loop variable
    blt  $t0,$a1,loop2
    jr $ra                  # after printing done return from function

swap:
# swaps two array elements
# a0 = memory address of first array element
# a1 = memory address of second array element
    lw $t0,0($a0)
    lw $t1,0($a1)
    sw $t0,0($a1)
    sw $t1,0($a0)
    jr $ra

initStack:
# initialises the stack pointer
    addi    $sp, $sp, -4
    sw		$fp, 0($sp)
    move 	$fp, $sp		    # $fp = $sp
    jr      $ra

pushToStack:
# $a0 is input
# pushed input to stack

    addi    $sp, $sp, -4
    sw		$a0, 0($sp) 
    jr      $ra

recursive_sort:
# sorts an array recursively
# $a0 = array address
# $a1 = start index
# $a2 = endex index

      
    move $t0,$ra    # temporarily saving the return address before calling push to stack
    move $t1,$a0

    jal initStack

    move $a0,$s0    # saving s0 in stack
    jal pushToStack
    move $a0,$s1    # saving s1 in stack
    jal pushToStack
    move $a0,$s2    # saving s2 in stack
    jal pushToStack
    move $a0,$t1    # saving a0 in stack
    jal pushToStack 
    move $a0,$a1    # saving a1 in stack
    jal pushToStack
    move $a0,$a2    # saving a2 in stack
    jal pushToStack
    move $a0,$t0    # saving ra in stack
    jal pushToStack
    

    lw $a0,-16($fp)
    move $s0,$a1    # l <--left
    move $s1,$a2    # r <--right
    move $s2,$a1    # p <--left

outer_while:
    bge $s0,$s1,return_from_sort  # return if l>=r

inner_while_one: 
    sll $t4,$s0,2
    add $t4,$t4,$a0 # t4 = array+4*l
    lw  $t4,0($t4)  # t4 = array[l]

    sll $t5,$s2,2   
    add $t5,$t5,$a0 # t5 = array+4*p
    lw  $t5,0($t5)  # t5 = array[p]

    bgt $t4,$t5,inner_while_two     # exit when array[l]>array[p]
    bge $s0,$a2,inner_while_two     # exit when l>=right

    addi $s0,$s0,1                  # l<--l+1
    j inner_while_one

inner_while_two:

    sll $t4,$s1,2
    add $t4,$t4,$a0 # t4 = array+4*r
    lw  $t4,0($t4)  # t4 = array[r]

    sll $t5,$s2,2   
    add $t5,$t5,$a0 # t5 = array+4*p
    lw  $t5,0($t5)  # t5 = array[p]

    blt $t4,$t5,condition_check     # exit when array[r]<array[p]
    ble $s1,$a1,condition_check     # exit when r<=left

    addi $s1,$s1,-1                  # r<--r-1
    j inner_while_two

condition_check:

    blt $s0,$s1,outer_loop_end

    sll $t4,$s1,2
    add $t4,$t4,$a0 # t4 = array+4*r
    sll $t5,$s2,2   
    add $t5,$t5,$a0 # t5 = array+4*p

    move $a0,$t5    # calling swap
    move $a1,$t4
    jal swap
    lw $a0,-16($fp)  # restoring arguments after call
    lw $a1,-20($fp)

    addi $t4,$s1,-1 # $t4=r-1
    move $a2,$t4    # right = r-1
    jal recursive_sort

    lw $a0,-16($fp)  # restoring arguments after call
    lw $a1,-20($fp)
    lw $a2,-24($fp)

    addi $t4,$s1,1  # $t4 = r+1
    move $a1,$t4    # left = r+1
    jal recursive_sort
    j return_from_sort


outer_loop_end:   

    sll $t4,$s1,2
    add $t4,$t4,$a0 # t4 = array+4*r
    sll $t5,$s0,2   
    add $t5,$t5,$a0 # t5 = array+4*l

    move $a0,$t5    # calling swap
    move $a1,$t4
    jal swap
    
    lw $a0,-16($fp)  # restoring arguments after call
    lw $a1,-20($fp)

    j outer_while   # jump to outer while loop


return_from_sort:

    lw $s2,-4($fp)
    lw $s1,-8($fp)
    lw $s2,-12($fp)
    lw $a0,-16($fp)  # restoring arguments after call
    lw $a1,-20($fp)
    lw $a2,-24($fp)
    lw $ra,-28($fp)
    addi $sp,$sp,28

    lw $fp,0($fp)     # restore frame ponter
    addi $sp,$sp,4   # restore stack pointer

    jr $ra          # returning from function