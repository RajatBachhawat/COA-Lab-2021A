# Assignment #2
# Problem #3 [PERFECT NUMBER TEST]
# Semester: Autumn 2021
# Group: 46
# Member1: Neha Dalmia - 19CS30055
# Member2: Rajat Bachhawat - 19CS10073
    
    .globl  main

    .data

# program output text constants
prompt:
    .asciiz "Enter a positive integer: "
err:
    .asciiz "Integer should be positive (>0) \n"
print_msg_no:
    .asciiz "Entered number is not a perfect number."
print_msg_yes:
    .asciiz "Entered number is  a perfect number."
exit_msg: 
    .asciiz "\nExit"
newline:
    .asciiz "\n"

    .text

# program variables
#   n:   $s0
#   sum : $s1
#   i :  $s2
main:
    li      $v0, 4                      # issue prompt
    la      $a0, prompt
    syscall

    li      $v0, 5                      # get n from user
    syscall
    move    $s0, $v0                    # $s0 = n

    slti    $t0, $s0, 1                 # if n < 1 then $t0 = 1, else $t0 = 0
    bne		$t0, $zero, check_failed	# if $t0 != 0 then jump to check_failed

    li      $s2,0                       #  loop variable i = 0
    li      $s1,0                       #  sum = 0;

loop:
    addi    $s2,$s2,1                   # increment i
    sge     $t1,$s2,$s0                 # t = 1 if i >= n
    bne     $t1,$zero,check             # if i>=n, go to check

    divu	$s0, $s2			        # n/i 
    mfhi	$t0					        # t0 = n%i
    bne	    $t0, $zero,loop 	        # if n%i!=0, try for next i
    add     $s1,$s1,$s2                 # sum  = sum + i
    j loop

check: 

    beq     $s1,$s0,perfect             # if sum == n, go to perfect
    j imperfect

perfect:    
    move 	$s0, $a0        		    # $s0 = $a0

    la $a0, print_msg_yes               # load address of prime message string
    li		$v0, 4          		    # $v0 = 4
    syscall                             # syscall to print 
    j exit

imperfect:    

    move 	$s0, $a0		            # $s0 = $a0
    la      $a0, print_msg_no           # load address of composite message string
    li		$v0, 4          		    # $v0 = 4
    syscall                             # syscall to print string
    j exit

check_failed:
    li		$v0, 4                      # issue err
    la      $a0, err                    
    syscall

    j		main				        # jump to main, take input again
exit:
    la      $a0, exit_msg          # load address of err message in $a0
    li		$v0, 4	        	   
    syscall                         # print exit message
    li		$v0, 10		            
    syscall                         # syscall to exit from the program