addi x1, x0, 6  # x1 = 6
sb x1, 0(x0)    # 0x000 -> 6
addi x1, x0, 7  # x1 = 7
sb x1, 1(x0)    # 0x001 -> 7
addi x1, x0, 4  # x1 = 4
sb x1, 2(x0)    # 0x002 -> 4
addi x1, x0, 5  # x1 = 5
sb x1, 3(x0)    # 0x003 -> 5
addi x1, x0, 2  # x1 = 2
sb x1, 4(x0)    # 0x004 -> 2
addi x1, x0, 9  # x1 = 9
sb x1, 5(x0)    # 0x005 -> 9
addi x1, x0, 11 # x1 = 11
sb x1, 6(x0)    # 0x006 -> 11
addi x1, x0, 3  # x1 = 3
sb x1, 7(x0)    # 0x007 -> 3
addi x1, x0, 12 # x1 = 12
sb x1, 8(x0)    # 0x008 -> 12
addi x1, x0, 10 # x1 = 10
sb x1, 9(x0)    # 0x009 -> 10
addi x1, x0, 1  # x1 = 1
sb x1, 10(x0)   # 0x010 -> 1
addi x1, x0, 8  # x1 = 8
sb x1, 11(x0)   # 0x011 -> 8

addi x22, x0, 0 # x22 = 0 (i)
addi x24, x0, 12# x24 = 12 (size of array)   
addi x26, x0, 0 # x26 = 0 (sum)

li x27, 27
li x28, 28

jal x1, sum_odd_indices

li x10, 1
mv x11, x26
ecall
j exit

sum_odd_indices:
    li sp, 0x100
    sb x27, -4(sp)
    sb x28, -8(sp)
    addi sp, sp, -8
    Start:
        andi x27, x22, 1 # x27 = 1 if x22 is odd
                        # x27 = 0 if x22 is even
        beq x27, x0, L1  # true if x27 is even
        lb x28, 0(x22)   # x28 -> 0 + x22
        add x26, x26, x28 # x26 = x26 + x28
    L1:
        addi x22, x22, 1 # x22 += 1
        beq x22, x24, Exit
        beq x0, x0, Start
    Exit:
        lb x28, 0(sp)
        lb x27, 4(sp)
        addi sp, sp, 8
        jalr x0, 0(x1)
exit:
    li x31, 31 
    li x31, 31

