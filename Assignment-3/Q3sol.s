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
    jal     initStack           # initialise stack pointer and frame pointer

    la      $a0, inp_prompt     # load address of input prompt in $a0
    li      $v0, 4
    syscall                     # syscall to print input prompt

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
    jal     mallocInStack       # allocate memory in the stack for A
    move    $s4, $v0            # $s4 = first address of A

    # $a0 still stores m*n
    jal     mallocInStack       # allocate memory in the stack for B
    move    $s5, $v0            # $s5 = first address of B
    
    # $a0 still stores m*n
    move    $a1, $s4
    move    $a2, $s2
    move 	$a3, $s3
    jal     populateMatrix      # populate matrix A

    la      $a0, matrixA_msg    # load address of matrixA_msg in $a0
    li      $v0, 4
    syscall                     # syscall to print matrix A print message
    
    move    $a0, $s0
    move    $a1, $s1
    move    $a2, $s4
    jal     printMatrix         # print matrix A

    move    $a0, $s0
    move    $a1, $s1
    move    $a2, $s4
    move    $a3, $s5
    jal     transposeMatrix     # transpose matrix A and store in matrix B

    la      $a0, matrixB_msg    # load address of matrixB_msg in $a0
    li      $v0, 4
    syscall                     # syscall to print matrix A print message
    
    move    $a0, $s1
    move    $a1, $s0
    move    $a2, $s5
    jal     printMatrix         # print matrix B

    j		Exit				# jump to Exit
    
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

mallocInStack:                  # procedure for allocating required memory in the stack
    # $a0 = size of memory to be allocated
    sll     $t0, $a0, 2         # $t0 = 4 * $a0 [multiplying by 4 as size of int = 4]
    sub		$sp, $sp, $t0		# $sp = $sp - $t0 [allocate space in the stack = 4*m*n bytes by decreasing sp]
    move    $v0, $sp            # return base address of allocated space
    j		$ra

populateMatrix:                 # procedure for populating the matrix A with GP series of a,r
    # $a0 = total size of matrix (m*n)
    # $a1 = address of 2D matrix (A)
    # $a2 = a (starting term of GP)
    # $a3 = r (common ratio)
    add    $t0, $zero, $zero    # i = 0, initialise loop variable 
loop:
    sll     $t1, $t0, 2
    add		$t2, $a1, $t1
    sw		$a2, 0($t2)         # M[A + 4*i] = (a)r^i, populate matrix element
    mul     $a2, $a2, $a3       # a = a * r
    addi    $t0, $t0, 1         # i += 1, loop variable increment
    bge		$t0, $a0, return    # if i < m*n : re-enter loop
    j		loop				# else : return from function

printMatrix:                    # procedure for printing a matrix
    # $a0 = no. of rows (m)
    # $a1 = no. of cols (n)
    # $a2 = address of 2D matrix (A)
    add     $t0, $zero, $zero   # i = 0, initialise loop variable (represents row*col)
    add     $t1, $zero, $zero   # j = 0, initialise loop variable (represents col)
    mul     $t4, $a0, $a1       # $t4 = m*n
innerLoop:
    sll     $t2, $t0, 2
    add		$t2, $a2, $t2       # $t2 = (A + 4*i)

    lw		$t3, 0($t2)         # $t3 = M[A + 4*i]
    
    move 	$a0, $t3
    li      $v0, 1
    syscall                     # syscall to print A[i/m][i%m]-th element

    la      $a0, space
    li      $v0, 4
    syscall                     # syscall to print space

    addi    $t0, $t0, 1         # i += 1, go to next element
    addi    $t1, $t1, 1         # j += 1
    
    blt     $t1, $a1, innerLoop # if j >= n (i.e. reached last col), then exit innerLoop
outerLoop:
    add     $t1, $zero, $zero   # re-initialise j = 0
    la      $a0, newline
    li      $v0, 4
    syscall                     # syscall to print newline to indicate one row finished
    bge     $t0, $t4, return    # if i >= m*n (i.e. all elements printed), then return from function
    j		innerLoop			# else re-enter innerLoop

transposeMatrix:                    # procedure for storing transpose of A in B
    # $a0 = no. of rows (m)
    # $a1 = no. of cols (n)
    # $a2 = address of 2D matrix (A)
    # $a3 = address of 2D matrix (B)
    add     $t0, $zero, $zero       # i = 0, initialise loop variable (represents row)
    add     $t1, $zero, $zero       # j = 0, initialise loop variable (represents col)
innerLoop1:
    mul     $t2, $t0, $a1
    add		$t2, $t1, $t2
    sll     $t2, $t2, 2
    add		$t2, $a2, $t2           # $t2 = (A+4*(n*i+j))
    lw		$t3, 0($t2)             # $t3 = A[i][j]

    mul     $t2, $t1, $a0
    add		$t2, $t0, $t2
    sll     $t2, $t2, 2
    add     $t2, $a3, $t2           # $t2 = (B+4*(m*j+i))
    sw		$t3, 0($t2)             # B[j][i] = $t3 = A[i][j]

    addi    $t1, $t1, 1             # j +=  1 (go to next element)
    blt     $t1, $a1, innerLoop1    # if j >= n (i.e. reached last col), then exit innerLoop1
outerLoop1:
    addi    $t0, $t0, 1             # i += 1, signifying entry to next row
    add     $t1, $zero, $zero       # re-initialise j = 0
    blt     $t0, $a0, innerLoop1    # if i < m (i.e. some rows left), then re-enter innerLoop1 

return:
    jr      $ra

Exit:
    la      $a0, exit_msg           # load address of err message in $a0
    li		$v0, 4	        	   
    syscall                         # print exit message
    li		$v0, 10		            
    syscall                         # syscall to exit from the program