# Assignment #2
# Problem #2 [GCD]
# Semester: Autumn 2021
# Group: 46
# Member1: Neha Dalmia - 19CS30055
# Member2: Rajat Bachhawat - 19CS10073

.data
# program output text constants
number_prompt1:
   .asciiz "Enter the first positive integer:  "
number_prompt2:
   .asciiz "Enter the second positive integer:  "
error_msg: 
    .asciiz "Input should be positive number, input again: "
out_msg:
   .asciiz "\nGCD of the two integers is: "
exit_msg: 
    .asciiz "Exit"
newline:
   .asciiz "\n"
#####Code Segment###########
   .text
   .globl main
# main program
# program variables
#   a:   $s0
#   b:   $s1
#   gcd: $s2

main:

first_inp:
   la $a0,number_prompt1            #  ask for the first input
   li $v0,4
   syscall
   li $v0, 5		           
   syscall                         # get the first input
   addi $s0,$v0,0                  # s0 = a
   slti  $t0,$s0,0                 # t0 = 1 if a<0
   bne  $t0,$zero,first_inp        # Input again if t0=1

   

second_inp:
   la $a0,number_prompt2            #  ask for the second input
   li $v0,4
   syscall
   li $v0, 5		           
   syscall                         # get the first input
   addi $s1,$v0,0                  # s1 = b
   slti  $t0,$s1,0                 # t0 = 1 if b<0
   bne  $t0,$zero,second_inp       # Input again if t0=1

   bne $s0,$zero,gcd_loop          # if a!=0, calculate the gcd
   add $s2,$s1,$zero               # otherwise, make gcd(s2) = b
   
print: 
    la      $a0, out_msg          # load address of print message in $a0
    li		$v0, 4  	        	   
    syscall                       # print message

    move    $a0,$s2                 # load gcd to a0
    li      $v0, 1                  # $v0 = 1
    syscall                         # syscall to print integer

    la      $a0, newline            # load address of newline in$a0
    li		$v0, 4      		    # $v0 = 4
    syscall                         # syscall to print string

    j Exit

gcd_loop: 
    beq $s1,$zero,return          # if b==0, go to return 
    sgt $t0,$s0,$s1               # if a>b, t0 =1
    bne $t0,$zero,reduce_a        # if a>b, go to reduce_a
    sub $s1,$s1,$s0               # else b = b-a
    j gcd_loop

reduce_a:
    sub $s0,$s0,$s1               # a = a-b
    j gcd_loop

return:
    add $s2,$s0,$zero               # make gcd(s2) = a
    j print                         # go to print

Exit:
    la      $a0, exit_msg          # load address of err message in $a0
    li		$v0, 4	        	   
    syscall                         # print exit message
    li		$v0, 10		            
    syscall                         # syscall to exit from the program