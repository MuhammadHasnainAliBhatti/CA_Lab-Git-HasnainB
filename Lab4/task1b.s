main:
    li x10, 5 # n = x10 x12
    li x11, 1 # acc = x11 x13
    li x12, 12
    li x13, 13
    li sp, 0x100
    sw x10, -4(sp)
    sw x11, -8(sp)
    addi sp, sp, -8   
    jal x1, fact_itr
    li x10, 1
    mv x11, x13
    ecall
    j exit
fact_itr:
    lw x13, 0(sp)
    lw x12, 4(sp)
    addi sp, sp, 8
    li x31, 1
    while:
        mul x13, x13, x12
        addi x12, x12, -1
        blt x12, x31, while_exit
        beq x0, x0, while
    while_exit:
        jalr x0, 0(x1)
exit:
    add x31, x31, x0
    add x31, x31, x0


