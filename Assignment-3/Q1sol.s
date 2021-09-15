# Assignment #3
# Problem #1
# Semester: Autumn 2021
# Group: 46
# Member1: Neha Dalmia - 19CS30055
# Member2: Rajat Bachhawat - 19CS10073

.data
# program output text constants
number_prompt1:
   .asciiz "Enter the first number:  "
number_prompt2:
   .asciiz "Enter the second number:  "
error_msg: 
    .asciiz "Input should be 16-bit signed number"
out_msg:
   .asciiz "\nProduct of the two numbers is: "
exit_msg: 
    .asciiz "\nExit"
newline:
   .asciiz "\n"
#####Code Segment###########
   .text
   .globl main
# main program
# program variables
#   a:   $s0
#   b:   $s1
#   product: $s2

# **WE HAVE HANDLED THE CASE WHERE INPUTS CAN BE -32768 SEPARATELY, AND IT GIVES THE CORRECT OUTPUT
# HENCE WE ARE NOT FLAGGING THIS CASE

main:

first_inp:

   # load immediate values of -2^15 and (2^15 - 1) for sanity check
   li $t2, -32768
   li $t3, 32767

   la $a0,number_prompt1           #  ask for the first input
   li $v0,4
   syscall
   
   li $v0, 5		           
   syscall                         # get the first input

   move $s0,$v0                    # s0 = a
   blt  $s0,$t2,Error_Exit                
   bgt  $s0,$t3,Error_Exit         # sanity check for first input    

   la $a0,number_prompt2           #  ask for the first input
   li $v0,4
   syscall
   
   li $v0, 5		           
   syscall                         # get the first input

   move $s1,$v0                    # s1 = b
   blt  $s1,$t2,Error_Exit                
   bgt  $s1,$t3,Error_Exit          # sanity check for second input    

   move $a0,$s0                     # input arguments
   move $a1,$s1

   beq  $a0,$t2,swap                # if a0 is -2^15

preprocess:

   andi $a1, $a1, 0x0000ffff        # lower half
   sll $a0, $a0, 16                 # upper half
   li  $t0,0                        # LSB  =0 
   li  $t1,16                       # Counter  = 16
   move $v0,$zero                   # return value 

   
   j multiply_booth

swap:
    beq $a1,$t2,load                # to handle the case when both numbers are -2^15
    move $t6,$a1                    # swapping when the multiplicand is -2^15 to prevent overflow
    move $a1,$a0
    move $a0,$t6 
    j preprocess

load:
    li $v0,1                        # exceptional case when both are -2^15
    sll $v0,$v0,30
    j print

multiply_booth: 

   andi $t2,$a1,1                    # getting LSB
   beq  $t2,$t0,shift                # 00 or 11
   beq  $t2,$zero,addition           # 01
   subu  $v0,$v0,$a0                 # 10
   j shift

addition:
   addu  $v0,$v0,$a0                 # adding M

shift:
    sra  $v0, $v0, 1                    # arithmetic right shift
    sra  $a1,$a1,1
    move $t0, $t2                       # move the LSB to t0
    addi $t1,$t1, -1                    # decrement the counter
    bne  $t1, $zero, multiply_booth     # if counter is non-zero, goto multiply_booth
    
   
print: 
    move    $s0,$v0               # return value in v0
    la      $a0, out_msg          # load address of print message in $a0
    li		$v0, 4  	        	   
    syscall                       # print message

    move    $a0,$s0                 
    li      $v0, 1                  # $v0 = 1
    syscall                         # syscall to print integer


    j Exit


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
    j Exit                          # Exit from program