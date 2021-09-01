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
error_message:
    .asciiz "Integer should be greater than or equal to 10\n"
prime_message:
    .asciiz "The integer is prime\n"
composite_message:
    .asciiz "The integer is composite\n"
exit_message:
    .asciiz "Exitted."

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

    li      $s1, 2                      # loop variable i = 2
    
loop:
    mult    $s1, $s1                    # result of multiplication stored in HI and LO registers
    mflo	$t0					        # $t0 = LO

    sltu    $t0, $s0, $t0               # if n < i*i [left 32 bits] then n is prime -> exit loop             
    bne	    $t0, $zero, prime

    mfhi	$t0					        # copy HI to $t0
    bgt	    $t0, $zero, prime	        # if i*i [right 32-bits] > 0 then n is prime -> exit loop
    
    divu	$s0, $s1			        # divide n by i, remainder stored in HI, quotient stored in LO
    mfhi	$t0					        # $t0 = HI 
    beq		$t0, $zero, composite	    # if n mod i == 0 then composite
    addi	$s1, $s1, 1			        # i = i + 1 (increment loop variable)
    j		loop				        # jump to loop
    
prime:    
    la      $a0, prime_message          # issue prime_message
    li		$v0, 4
    syscall
    j		exit				        # jump to exit
    

composite:
    la      $a0, composite_message      # issue composite_message
    li		$v0, 4
    syscall

exit:
    la      $a0, exit_message           # issue exit_message
    li		$v0, 4
    syscall

    li		$v0, 10
    syscall                             # syscall to exit from the program

check_failed:
    li		$v0, 4                      # issue error_message
    la      $a0, error_message                    
    syscall

    j		main				        # jump to main, take input again
