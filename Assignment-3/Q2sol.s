# Assignment #3
# Problem #2
# Semester: Autumn 2021
# Group: 46
# Member1: Neha Dalmia - 19CS30055
# Member2: Rajat Bachhawat - 19CS10073

.data
# program output text constants
number_prompt1:
   .asciiz "Enter 10 numbers (one in each line):  "
number_prompt2:
   .asciiz "Enter the value of k:  "
error_msg: 
    .asciiz "k should lie between 1 and 10"
print_msg: 
    .asciiz "Sorted array is:\n"
out_msg:
   .asciiz "\nKth largest number in the array is: "
exit_msg: 
    .asciiz "\nExit"
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

first_inp:

  

   la $a0,number_prompt1           #  ask for the  input
   li $v0,4
   syscall

   li		$v0, 4		        # $v0 = 4
   la		$a0, newline	    # load address of newline string
   syscall

   la $s0,array
   li $t0,0                     #loop variable

loop: 
   
   li		$v0, 5
   syscall                      # syscall for taking integer input
   sw   $v0,0($s0)              # taking array input
   addi $s0,$s0,4
   addi $t0,$t0,1
   blt  $t0,10,loop


find_k_largest:

   li		$v0, 4
   la		$a0, newline	    # load address of newline string
   syscall                      # syscall for printing string

   la $a0,number_prompt2           #  ask for the input k
   li $v0,4
   syscall

   li		$v0, 5
   syscall                      # inputting k

   blt $v0,1,Error_Exit       #sanity checks
   bgt $v0,10,Error_Exit

   move $s0,$v0
   li   $t0,10
   sub  $s0,$t0,$s0            # k = 10 - k (for getting k-th from right end)

   la $a0,array                 #address in first argument
   li $a1,10                  #length of array in second argument
   jal sort_array

   li		$v0, 4
   la		$a0, print_msg	    # load address of message string
   syscall

   la $t1,array
   li $t0,0                     #loop variable

loop2:

   lw $a0,0($t1)
   li		$v0, 1		        
   syscall

   li		$v0, 4   
   la		$a0, space	    # load address of newline string
   syscall

   addi $t1,$t1,4        # updating array pointer
   addi $t0,$t0,1        # updating loop variable
   blt  $t0,10,loop2     # checking if more can be printed

print_kth:
   
   addi $t0,$s0,0       # t0 = k
   sll  $t0,$t0,2       # t0 = 4*k
   la   $t1,array       # t1 = array
   add  $t0,$t1,$t0     # t0 = array + 4*k
   lw   $t0,0($t0)      # t0 = array[k]

    la      $a0, out_msg          # load address of print message in $a0
    li		$v0, 4  	        	   
    syscall                       # print message

    move    $a0,$t0                 
    li      $v0, 1
    syscall                         # syscall to print integer

   j Exit

sort_array:
    # $a0 = base address of array
    # $a1 = length of array
    addi $sp,$sp,-8
    sw   $s0,4($sp)
    sw   $ra,0($sp)
    li $s0,2        # j<--2
  
outer_for:

  
    addi $t0,$s0,-1    # t0 = j-1
    sll  $t0,$t0,2     # t0 = 4*(j-1)
    add $t1,$a0,$t0    # t1 = array +4(j-1)

    lw  $s2,0($t1)      # s2 = array[j-1] (temp)
    addi $s1,$s0,-1      # i = j-1

inner_for:
    ble $s1,$zero,outer_for_cont
    addi $t0,$s1,-1       # t0 = i-1
    sll  $t0,$t0,2      # t0 = 4*(i-1)
    move $t1,$a0        # t1 = array
    add $t1,$t1,$t0    # t1 = array +4(i-1)
    lw  $t0,0($t1)      # t0 = array[i-1]
    ble $t0,$s2,outer_for_cont

    addi $t2,$s1,0        # t2 = i
    sll  $t2,$t2,2        # t2 = 4*(i)
    add $t2,$t2,$a0      # t2 = array+4*(i)
    sw   $t0,0($t2)       # array[i] = array[i-1]
    addi $s1,$s1,-1        # i= i-1
    j inner_for

outer_for_cont:
    addi $t2,$s1,0       # t2 = i
    sll  $t2,$t2,2        # t2 = 4*(i)
    add  $t2,$t2,$a0      # t2 = array+4*(i)

    sw   $s2,0($t2)       # array[i] = temp
    addi $s0,$s0,1
    ble  $s0,$a1,outer_for 
    lw   $ra,0($sp)
    lw   $s0,4($sp)
    addi $sp,$sp,8
    jr $ra

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