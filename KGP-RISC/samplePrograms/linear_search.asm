0. add $zero, $zero # dummy instruction
main:
1. addi $a0, 1      # put the base address of array in data memory (stored from 1 to 10)
2. lw $a1, 0($zero) # load the number to search for (stored at 0)
3. and $v0, $zero   # initialize return value to 0 (not found)
4. bl lin_search
5. b exit

lin_search:
6. add $s0,$a0     # s0 = base address (arr)
7. add $s1,$a1     # s1 = key (x)
8. comp $s1, $s1   # s1 = -x
9. and $t0, $zero  # loop variable i

check_i_less_than_10:
10. compi $t1, 10   # t1 = -10 (10 is size of array)
11. add $t1, $t0   # t1 = i - 10
12. bltz $t1, loop # if i < 10, enter loop
13. b return_not_found # else return_not_found

loop:
14. and $t1, $zero # t1 = 0 
15. add $t1, $t0 # t1 = i
16. add $t1, $s0 # t1 = a + i (address of the array element)
17. lw $t1, 0($t1) # t1 = a[i]
18. add $t1, $s1 # t1 = a[i] - x
19. bz $t1, return_found # if a[i] == x, return_found
20. addi $t0, 1 # else i = i + 1
21. b check_i_less_than_10 # recheck loop condition

return_not_found:
22. br $ra  # return

return_found:
23. addi $v0, 1 # set return value to 1
24. br $ra # return

exit:
25. sw $v0, 11($zero) # 0 if not found, 1 if found