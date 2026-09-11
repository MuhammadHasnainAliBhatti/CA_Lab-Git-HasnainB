# x10 = char x[]
# x11 = char y[]
# x19 = i
li x10, 0x100
li x11, 0x200
li x1, 48 # 'H' in hex (ascii 65)
li x2, 69 # 'i' in hex (ascii 105)
sb x1, 0(x11) # y[0] = 'H'
sb x2, 1(x11) # y[1] = 'i'
sb x0, 2(x11) # y[2] = '\0'
li x19, 10
li fp, 0x300 # x8 = fp
sw x10, -4(fp)
sw x11, -8(fp)
addi fp, fp, -8
jal ra, strcpy # x1 =ra
addi fp, fp, 8
j exit
exit:
    #li x31, 31
    #li x31, 31
    li a7, 10 # a7 = x17
    ecall
strcpy:
    addi sp, sp, -4 # x2 = sp (65 = 0x41)
    sw x19, 0(sp) # memory location?
    li x19, 0
    L:
        add x5, x19, x11 # * lw x11
        lb x6, 0(x5) # x6 = y[i]
        add x7, x19, x10
        sb x6, 0(x7) # x[i] = x6
        beq x6, x0, L_exit
        addi x19, x19, 1
        beq x0, x0, L
    L_exit:
        lw x19, 0(sp)
        addi sp, sp, 4
        jalr x0, 0(ra)






