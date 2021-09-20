# Assignment #4
# Problem #1
# Semester: Autumn 2021
# Group: 46
# Member1: Neha Dalmia - 19CS30055
# Member2: Rajat Bachhawat - 19CS10073

.data
# program output text constants
inp_prompt:
    .asciiz "Enter four positive integers n, a, r and m:\n"
matrixA_msg:
    .asciiz "\nMatrix A:\n"
determinant_msg:
    .asciiz "\nFinal determinant of the matrix A is: "
exit_msg: 
    .asciiz "\nExitted."
error_msg:
    .asciiz "Input integers must all be positive. Try again.\n"
space:
    .asciiz " "
newline:
    .asciiz "\n"
answer:
    .space   4
#####Code Segment###########
    .text
    .globl main
# main program
# program variables

main:
    jal     initStack           # initialise stack pointer and frame pointer

    la      $a0, inp_prompt     # load address of input prompt in $a0
    li      $v0, 4
    syscall                     # syscall to print input prompt

    li      $v0, 5
    syscall                     # syscall to take integer input n
    slti    $t0, $v0, 1         # sanity check for > 0
    bne     $t0, $zero, Error_Exit
    move    $s0, $v0            # $s0 = n
    li      $v0, 5
    syscall                     # syscall to take integer input a
    slti    $t0, $v0, 1         # sanity check for > 0
    bne     $t0, $zero, Error_Exit
    move    $s1, $v0            # $s1 = a
    li      $v0, 5
    syscall                     # syscall to take integer input r
    slti    $t0, $v0, 1         # sanity check for > 0
    bne     $t0, $zero, Error_Exit
    move    $s2, $v0            # $s2 = r 
    li      $v0, 5
    syscall                     # syscall to take integer input m
    slti    $t0, $v0, 1         # sanity check for > 0
    bne     $t0, $zero, Error_Exit
    move    $s4, $v0            # $s4 = m     

    mul     $t3, $s0, $s0       # $t0 = n * n = n * n [$t0 stores size of matrix] 

    move    $a0, $t3
    jal     mallocInStack       # allocate memory in the stack for A
    move    $s3, $v0            # $s3 = first address of A
    
    # $a0 still stores n*n
    move    $a1, $s3
    move    $a2, $s1
    move 	$a3, $s2
    move    $t0, $a0
    move    $a0, $s4
    jal     pushToStack         # 5th argument m has to be pushed to stack
    move    $a0, $t0
    jal     populateMatrix      # populate matrix A
    jal     popFromStack        # popping the 5th argument from stack

    la      $a0, matrixA_msg    # load address of matrixA_msg in $a0
    li      $v0, 4
    syscall                     # syscall to print matrix A print message
    
    move    $a0, $s0
    move    $a1, $s3
    jal     printMatrix         # print matrix A

    move    $a0, $s0
    move    $a1, $s3
    jal     recursive_Det       # call recursive_Det(n, A)
    move    $t0, $v0            # store the answer in $t0 temporarily

    la      $a0, determinant_msg 
    li      $v0, 4
    syscall                     # syscall to print determinant output message

    move    $a0, $t0            
    li      $v0, 1
    syscall                     # syscall to print the answer, i.e., determinant of input matrix

    mul     $t0, $s0, $s0
    add     $sp, $sp, $t0       # de-allocate the matrix A from stack
    jal     popFromStack        # restore the old frame pointer
    move    $fp, $v0

    j		Exit				# jump to Exit
    
initStack:                      # procedure for initialising the stack pointer & frame pointer
    move    $t0, $ra            # save return address
    move 	$a0, $fp
    jal     pushToStack         # pushing the old frame pointer into the stack to save it
    move 	$ra, $t0            # restore return address

    move 	$fp, $sp            # current frame pointer = current stack pointer
    j       $ra

pushToStack:                    # procedure for pushing to stack
    # $a0 = data to be pushed to stack
    addi    $sp, $sp, -4        # create 4-byte space in stack
    sw		$a0, 0($sp)         # store the argument in stack
    jr		$ra

popFromStack:                   # procedure for popping from stack
    # $v0 = the topmost value in stack
    lw      $v0, 0($sp)
    addi    $sp, $sp, 4
    jr	    $ra

mallocInStack:                  # procedure for allocating required memory in the stack
    # $a0 = size of memory to be allocated
    sll     $t0, $a0, 2         # $t0 = 4 * $a0 [multiplying by 4 as size of int = 4]
    sub		$sp, $sp, $t0		# $sp = $sp - $t0 [allocate space in the stack = 4*n*n bytes by decreasing sp]
    move    $v0, $sp            # return base address of allocated space
    j		$ra

populateMatrix:                 # procedure for populating the matrix A with GP series of a,r
    # $a0 = total size of matrix (n*n)
    # $a1 = address of 2D matrix (A)
    # $a2 = a (starting term of GP)
    # $a3 = r (common ratio)
    add     $t0, $zero, $zero   # i = 0, initialise loop variable
    lw      $t2, 0($sp)         # $t2 = m (modulo value)
    move    $t3, $a2            # $t3 = a
loop:
    sll     $t1, $t0, 2
    add		$t1, $a1, $t1

    div		$t3, $t2
    mfhi	$t3					# $t3 = a mod m
    sw		$t3, 0($t1)         # M[A + 4*i] = (a)r^i, populate matrix element
    mul     $t3, $t3, $a3       # a = a * r

    addi    $t0, $t0, 1         # i += 1, loop variable increment
    bge		$t0, $a0, return    # if i < n*n : re-enter loop
    j		loop				# else : return from function

printMatrix:                    # procedure for printing a matrix
    # $a0 = no. of rows/cols (n)
    # $a1 = address of 2D matrix (A)
    add     $t0, $zero, $zero   # i = 0, initialise loop variable (represents row*col)
    add     $t1, $zero, $zero   # j = 0, initialise loop variable (represents col)
    mul     $t4, $a0, $a0       # $t4 = n*n
    move    $t5, $a0
innerLoop:
    sll     $t2, $t0, 2
    add		$t2, $a1, $t2       # $t2 = (A + 4*i)

    lw		$t3, 0($t2)         # $t3 = M[A + 4*i]
    
    move 	$a0, $t3
    li      $v0, 1
    syscall                     # syscall to print A[i/n][i%n]-th element

    la      $a0, space
    li      $v0, 4
    syscall                     # syscall to print space

    addi    $t0, $t0, 1         # i += 1, go to next element
    addi    $t1, $t1, 1         # j += 1
    
    blt     $t1, $t5, innerLoop # if j >= n (i.e. reached last col), then exit innerLoop
outerLoop:
    add     $t1, $zero, $zero   # re-initialise j = 0
    la      $a0, newline
    li      $v0, 4
    syscall                     # syscall to print newline to indicate one row finished
    bge     $t0, $t4, return    # if i >= n*n (i.e. all elements printed), then return from function
    j		innerLoop			# else re-enter innerLoop

recursive_Det:                  # procedure for calculating the determinant of the matrix passed
    # $a0 = n (n*n is the dimension of the matrix)
    # $a1 = A (base address of the matrix)
    # $s0 = M (base address of the smaller (n-1)*(n-1) matrix)
    # $s1 = k (loop variable)
    # $s2 = 4*(n-1)*(n-1) (size of the matrix M)

    move    $t1, $ra            # temporarily store the return address in $t1
    move    $t2, $a0            # temporarily store the 1st argument in $t2

    jal     initStack           # initialise fp and sp
    move    $ra, $t1            # restore $ra

    move    $a0, $ra
    jal     pushToStack         # save the $ra onto the stack
    move    $a0, $s0
    jal     pushToStack         # save $s0 (M)  onto the stack 
    move    $a0, $s1
    jal     pushToStack         # save $s1 (loop variable k) onto the stack
    move    $a0, $s2
    jal     pushToStack         # save $s2 (size in bytes of M) onto the stack
    move    $a0, $s3
    jal     pushToStack         # save $s3 (ans) onto the stack
    move    $a0, $t2            # restore $a0

    addi    $t0, $a0, -1
    mul     $s2, $t0, $t0
    sll     $s2, $s2, 2         # $s2 = 4*(n-1)*(n-1) [size of the allocated space for M]
    sub     $sp, $sp, $s2       # allocating space for the submatrix M of dimensions (n-1)*(n-1)

    slti    $t0, $a0, 2         # if n == 1, go to base_case
    bne		$t0, $zero, base_case

    move    $s0, $sp            # $s0 = base address of M
    add     $s3, $zero, $zero   # $s3 = ans = 0, stores the answer for this step of recursion
    add     $s1, $zero, $zero   # $s1 = k = 0, outermost loop variable
    
loop1:
    bge     $s1, $a0, restore_Det    # if k >= n, exit loop, restore the stack and return from function

    add     $t0, $zero, 1       # $t0 = i = 1, iterates over rows of A
    add     $t2, $zero, $a0     # $t2 = i * n
    add     $t5, $zero, $zero   # $t5 = x-th (overall) element in the submatrix M
loop2:
    bge     $t0, $a0, loop_end_k
    add     $t1, $zero, $zero   # j = 0, iterates over cols of A
loop3:
    bge     $t1, $a0, loop_end_i    # if j >= n, go to next row
    beq     $t1, $s1, loop_end_j    # if j == k, ignore this column, go to next column
    add     $t3, $t2, $t1
    sll     $t4, $t3, 2
    add     $t4, $a1, $t4
    lw		$t3, 0($t4)             # $t3 = A[i][j]

    sll     $t4, $t5, 2
    add     $t4, $s0, $t4
    sw      $t3, 0($t4)             # M[x/4][x%4] = A[i][j]
    j       loop_end_j_x            # increment loop variables
loop_end_j:
    addi    $t1, $t1, 1             # j = j + 1
    j       loop3                   # re-enter innermost loop

loop_end_j_x:
    addi    $t1, $t1, 1             # j = j + 1
    addi    $t5, $t5, 1             # x = x + 1
    j       loop3                   # re-enter innermost loop

loop_end_i:
    addi    $t0, $t0, 1             # i = i + 1
    mul     $t2, $t0, $a0           # $t2 = i * n
    j       loop2                   # re-enter middle loop

loop_end_k:
    jal     pushToStack         # save $a0 (1st argument) onto the stack
    addi    $t0, $a0, -1        # $t0 = n-1
    move    $a0, $a1
    jal     pushToStack         # save $a1 (2nd argument) onto the stack

    move    $a0, $t0            # 1st argument: n-1
    move    $a1, $s0            # 2nd argument: M [(n-1)*(n-1) matrix]
    jal     recursive_Det       # recursive call to recursive_Det
    move    $t0, $v0            # $t0 = return value = Minor_0_k

    jal     popFromStack        # restore $a1 from stack
    move    $a1, $v0
    jal     popFromStack        # restore $a0 from stack
    move    $a0, $v0

    sll     $t7, $s1, 2
    add     $t7, $a1, $t7
    lw      $t7, 0($t7)         # $t7 = A[0][k]
    mul     $t7 ,$t0, $t7       # $t7 = A[0][k]*Minor_0,k

    andi    $t8, $s1, 1
    bne     $t8, $zero, subtract_from_ans   # if k is odd, subtract from ans, else add

    add     $s3, $s3, $t7       # ans = ans + A[0][k] * Minor_0,k

    addi    $s1, $s1, 1         # k = k + 1, increment
    j       loop1               # re-enter outermost loop

subtract_from_ans:
    sub     $s3, $s3, $t7       # ans = ans - A[0][k] * Minor_0,k

    addi    $s1, $s1, 1         # k = k + 1, increment
    j       loop1               # re-enter outermost loop

base_case:
    lw      $t0, 0($a1)
    add     $s3, $zero, $t0     # ans = A[0][0]

restore_Det:
    move    $t1, $s3            # save answer (return value) to $t1
    add     $sp, $sp, $s2       # de-allocate the matrix M [(n-1)*(n-1) matrix] from stack
    jal     popFromStack        # restore $s3
    move    $s3, $v0
    jal     popFromStack        # restore $s2
    move    $s2, $v0
    jal     popFromStack        # restore $s1
    move    $s1, $v0
    jal     popFromStack        # restore $s0
    move    $s0, $v0
    jal     popFromStack        # restore $ra
    move    $ra, $v0    
    move    $t0, $ra
    jal     popFromStack        # restore frame pointer
    move    $fp, $v0
    move    $ra, $t0
    move    $v0, $t1            # store return value in $v0

return:
    jr      $ra

Exit:
    la      $a0, exit_msg           # load address of err message in $a0
    li		$v0, 4	        	   
    syscall                         # print exit message
    li		$v0, 10		            
    syscall                         # syscall to exit from the program

Error_Exit:
    la      $a0, error_msg          # load address of err message in $a0
    li		$v0, 4	        	   
    syscall                         # print error message
    j       main                    # re-input