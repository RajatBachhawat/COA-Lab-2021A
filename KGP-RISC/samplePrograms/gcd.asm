0. add $zero, $zero # dummy instruction
main:
1. lw $a0, 0($zero) # load the first input (stored at 0)
2. lw $a1, 1($zero) # load the second input (stored at 1)
3. addi $v0, -1    # redundant
4. bl gcd
5. b exit

gcd:
6. add $s0,$a0     # s0 = a0
7. add $s1,$a1     # s1 = a1

check_b_zero:
8. bz $s1, return

check_a_less_equal_b:
9. and $t0, $zero  # t0 = 0
10. add $t0, $s1    # t0 = b
11. comp $t0, $t0   # t0 = -b
12. add $t0,$s0     # t0 = a - b
13. bltz $t0, a_less_equal_b    # a < b branch
14. bz $t0, a_less_equal_b      # a == b branch
15. and $t0, $zero  # t0 = 0
16. add $t0,$s1     # t0 = b
17. comp $t0, $t0   # t0 = -b
18. add $s0,$t0     # a = a-b
19. b check_b_zero

a_less_equal_b:
20. and $t0, $zero  # t0 = 0
21. add $t0,$s0     # t0 = a
22. comp $t0, $t0   # t0 = -a
23. add $s1,$t0     # b = b-a
24. b check_b_zero

return:
25. and $v0, $zero  # v0 = 0
26. add $v0, $s0    # v0 = s0
27. br $ra

exit:
28. sw $v0, 2($zero) # gcd = a