# Assignment #4
# Problem #3
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
number_prompt2:
    .asciiz "Enter the value of key:  "
exit_msg: 
    .asciiz "\nExitted."
newline:
    .asciiz "\n"
m1: 
    .asciiz " is NOT found in the array."
m2: 
    .asciiz " is FOUND in the array at index "
m3:
    .asciiz "."
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

    la $a0,newline          #  newline
    li $v0,4
    syscall


    la $a0,number_prompt2       #  ask for the  input
    li $v0,4
    syscall
    li		$v0, 5		        # $v0 = 5
    syscall
    move $s0,$v0                # s0 stores key


    la $a0,array                # arguments for search
    li $a1,0
    li $a2,9
    move $a3,$s0
    jal recursive_search

    move $s1,$v0 
    li $t0,-1
    beq $s1,$t0,not_found_print     # if number not found

    move $a0,$s0
    li   $v0,1
    syscall
    la      $a0, m2          # load address of err message in $a0
    li		$v0, 4	        	   
    syscall       
    move $a0,$s1
    li   $v0,1
    syscall
    la      $a0, m3          # load address of err message in $a0
    li		$v0, 4	        	   
    syscall     

    j Exit

not_found_print:

    move $a0,$s0
    li   $v0,1
    syscall
    la      $a0, m1          # load address of err message in $a0
    li		$v0, 4	        	   
    syscall           


Exit:
    la      $a0, exit_msg          # load address of err message in $a0
    li		$v0, 4	        	   
    syscall                         # print exit message
    li		$v0, 10		            
    syscall                         # syscall to exit from the program

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

    
recursive_search:
# searches for key in sorted array
# $a0 is address of array
# $a1 = start
# $a2 = end
# $a3 = key
    move $t0,$ra    # temporarily saving the return address before calling push to stack
    move $t1,$a0

    jal initStack    #initialise fp and sp

    move $a0,$s0    # saving s0 in stack
    jal pushToStack
    move $a0,$s1    # saving s1 in stack
    jal pushToStack
    move $a0,$a3    # saving a3 in stack
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
    li $v0,-1                       # default return value is -1

    

while_loop:

    bgt $a1,$a2,return_from_search  # if start>end, return

    sub $t0,$a2,$a1    # t0 = end - start
    li $t1,3
    div $t0,$t1
    mflo $t0            # $t0 = (end-start)/3
    add $s0,$t0,$a1     # mid1 = $s0 = start + (end-start)/3

    sub $t0,$a2,$a1    # t0 = end - start
    li $t1,3
    div $t0,$t1
    mflo $t0            # $t0 = (end-start)/3
    sub $s1,$a2,$t0    # mid2 = $s1 = end - (end-start)/3

   

    sll $t0,$s0,2
    add $t0,$t0,$a0
    lw $t0,0($t0)       # t0 = A[mid1]
    bne $a3,$t0,cond1   # if A[mid1]!=key , jump
    move $v0,$s0        # else return mid1
    j return_from_search

cond1:


    sll $t0,$s1,2
    add $t0,$t0,$a0
    lw $t0,0($t0)       # t0 = A[mid2]
    bne $a3,$t0,cond2   # if A[mid2]!=key , jump
    move $v0,$s1        # else return mid2
    j return_from_search

cond2:

    sll $t0,$s0,2
    add $t0,$t0,$a0
    lw $t0,0($t0)       # t0 = A[mid1]
    bge $a3,$t0,cond3   # if key>=A[mid1], jump

    addi $t0,$s0,-1     # t0 = mid1-1
    move $a2,$t0 
    jal recursive_search    

    lw $a0,-16($fp)      # restore arguments
    lw $a1,-20($fp)
    lw $a2,-24($fp) 
    lw $a3,-12($fp)

    j return_from_search    # return the value from the previous function call

cond3:


    sll $t0,$s1,2
    add $t0,$t0,$a0
    lw $t0,0($t0)       # t0 = A[mid2]

    ble $a3,$t0,cond4   # if key<=A[mid2], jump
    addi $t0,$s1,1     # t0 = mid2+1

    move $a1,$t0 
    jal recursive_search    

   
    lw $a0,-16($fp)      # restore arguments
    lw $a1,-20($fp)
    lw $a2,-24($fp) 
    lw $a3,-12($fp)

    j return_from_search    # return the value from the previous function call

cond4:

    addi $t0,$s1,-1      # t0 = mid2-1
    move $a2,$t0
    addi $t1,$s0,1      # t1 = mid1+1
    move $a1,$t1
    jal recursive_search

    lw $a0,-16($fp)      # restore arguments
    lw $a1,-20($fp)
    lw $a2,-24($fp) 
    lw $a3,-12($fp)

    j return_from_search    # return the value from the previous function call


return_from_search:

    lw $s0,-4($fp)
    lw $s1,-8($fp)
    lw $a3,-12($fp)
    lw $a0,-16($fp)  # restoring arguments after call
    lw $a1,-20($fp)
    lw $a2,-24($fp)
    lw $ra,-28($fp)
    addi $sp,$sp,28 
    
    lw $fp,0($fp)     # restore frame ponter
    addi $sp,$sp,4   # restore stack pointer

    jr $ra          # returning from function