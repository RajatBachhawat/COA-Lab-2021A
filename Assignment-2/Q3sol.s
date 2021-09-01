# Assignment #2
# Problem #3 [PRIMALITY TEST]
# Semester: Autumn 2021
# Group: 46
# Member1: Neha Dalmia - 19CS30055
# Member2: Rajat Bachhawat - 19CS10073
    
    .globl  main

    .data

# program output text constants
prompt:
    .asciiz "Enter a positive integer greater than equals to 10: "
err:
    .asciiz "Integer should be greater than or equal to 10\n"
prime_msg:
    .asciiz "The integer is prime"
newline:
    .asciiz "\n"

    .text

# program variables
#   n:   $s0
#
main:
    li      $v0, 4                      # issue prompt
    la      $a0, prompt
    syscall

    li      $v0, 5                      # get n from user
    syscall
    move    $s0, $v0                    # $s0 = n

    slti    $t0, $s0, 10                # if n < 10 then $t0 = 1, else $t0 = 0
    bne		$t0, $zero, check_failed	# if $t0 != 0 then jump to check_failed

    li      $s0, 2
loop:
    
    
prime:    
    move 	$s0, $a0        		    # $s0 = $a0

    la $a0, prime_msg                   # load address of prime message string
    li		$v0, 4          		    # $v0 = 4
    syscall                             # syscall to print 

composite:    
    move 	$s0, $a0		            # $s0 = $a0

    la      $a0, composite_msg          # load address of composite message string
    li		$v0, 4          		    # $v0 = 4
    syscall                             # syscall to print string

exit:
    li		$v0, 10
    syscall                             # syscall to exit from the program

check_failed:
    li		$v0, 4                      # issue err
    la      $a0, err                    
    syscall

    j		main				        # jump to main, take input again
