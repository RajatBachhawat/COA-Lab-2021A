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
#   m:   $s0
#   n:   $s1
#   a:   $s2
#   r:   $s3
#   A:   $s4
#   B:   $s5

main:
    jal initStack

    la      $a0, inp_prompt     # load address of prompt in $a0
    li      $v0, 4
    syscall                     # syscall to print prompt

    li      $v0, 5              
    syscall                     # syscall to take integer input m
    move    $s0, $v0            # $s0 = m
    li      $v0, 5
    syscall                     # syscall to take integer input n
    move    $s1, $v0            # $s1 = n
    li      $v0, 5
    syscall                     # syscall to take integer input a
    move    $s2, $v0            # $s2 = a
    li      $v0, 5
    syscall                     # syscall to take integer input r
    move    $s3, $v0            # $s3 = r       

    mul     $t3, $s0, $s1       # $t0 = m * n = n * m [$t0 stores size of matrix] 

    move    $a0, $t3
    jal     mallocInStack
    move    $s4, $v0            # $s4 = first address of A

    # $a0 still stores m*n
    jal     mallocInStack
    move    $s5, $v0            # $s5 = first address of B
    
    # $a0 still stores m*n
    move    $a1, $s4
    jal     populateMatrix

    la      $a0, matrixA_msg
    li      $v0, 4
    syscall
    
    move    $a0, $s0
    move    $a1, $s1
    move    $a2, $s4
    jal     printMatrix

    move    $a0, $s0
    move    $a1, $s1
    move    $a2, $s4
    move    $a3, $s5
    jal     transposeMatrix

    la      $a0, matrixB_msg
    li      $v0, 4
    syscall
    
    move    $a0, $s1
    move    $a1, $s0
    move    $a2, $s5
    jal     printMatrix
    j       Exit

populateMatrix:
    add    $t0, $zero, $zero   # initialise loop variable i = 0
loop:
    sll     $t1, $t0, 2
    add		$t2, $a1, $t1
    sw		$s2, 0($t2)
    mul     $s2, $s2, $s3
    addi    $t0, $t0, 1
    bge		$t0, $a0, return
    j		loop				# jump to loop
    
initStack:
    addi    $sp, $sp, -4
    sw		$fp, 0($sp)
    move 	$fp, $sp		    # $fp = $sp
    j       return

pushToStack:
    addi    $sp, $sp, -4
    sw		$a0, 0($sp) 
    j       return

mallocInStack:
    sll     $t0, $a0, 2         # $t1 = 4 * $a0 [multiplying by 4 as size of int = 4]
    sub		$sp, $sp, $t0		# $sp = $sp - $t0 [allocate space in the stack = 4*m*n bytes]
    move    $v0, $sp
    j       return

printMatrix:
    addi    $sp, $sp, -8
    sw		$ra, 4($sp) 
    sw		$a0, 0($sp)
    # $a0 = no. of rows (m)
    # $a1 = no. of cols (n)
    # $a2 = address of 2D matrix (A)
    add     $t0, $zero, $zero
    add     $t1, $zero, $zero
    mul     $t4, $a0, $a1
innerLoop:
    sll     $t2, $t0, 2
    add		$t2, $a2, $t2

    lw		$t3, 0($t2)
    
    move 	$a0, $t3
    li      $v0, 1
    syscall

    la      $a0, space
    li      $v0, 4
    syscall

    addi    $t0, $t0, 1
    addi    $t1, $t1, 1
    
    blt     $t1, $a1, innerLoop
outerLoop:
    add     $t1, $zero, $zero
    la      $a0, newline
    li      $v0, 4
    syscall
    bge     $t0, $t4, endLoop
    j		innerLoop				# jump to innerLoop
endLoop:
    lw		$ra, 4($sp)		        # 
    lw		$a0, 0($sp)		        # 
    addi    $sp, $sp, 8
    j		return				    # jump to return
     
transposeMatrix:
    # $a0 = no. of rows (m)
    # $a1 = no. of cols (n)
    # $a2 = address of 2D matrix (A)
    # $a3 = address of 2D matrix (B)
    add     $t0, $zero, $zero       # $t0 = i-th row
    add     $t1, $zero, $zero       # $t1 = j-th col
innerLoop1:
    mul     $t2, $t0, $a1
    add		$t2, $t1, $t2
    sll     $t2, $t2, 2
    add		$t2, $a2, $t2
    lw		$t3, 0($t2)

    mul     $t2, $t1, $a0
    add		$t2, $t0, $t2
    sll     $t2, $t2, 2
    add     $t2, $a3, $t2
    sw		$t3, 0($t2)

    addi    $t1, $t1, 1
    blt     $t1, $a1, innerLoop1
outerLoop1:
    addi    $t0, $t0, 1
    add     $t1, $zero, $zero
    blt     $t0, $a0, innerLoop1

return:
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
    j Exit                          # Exit from program