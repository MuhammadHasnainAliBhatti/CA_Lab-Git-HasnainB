# a0 = int c[] (a0 = x10) 
li s1, 10 # SIZEC = 10 (int 40 bytes, s1 = x9)
li a0, 0x100
li t6, 23 # (t6 = x31)
sw t6, 0(a0)
li t6, 12
sw t6, 4(a0)
li t6, 5
sw t6, 8(a0)
li t6, 44
sw t6, 12(a0)
li t6, 98
sw t6, 16(a0)
li t6, 53
sw t6, 20(a0)
li t6, 6
sw t6, 24(a0)
li t6, 89
sw t6, 28(a0)
li t6, 32
sw t6, 32(a0)
li t6, 65
sw t6, 36(a0)
li fp, 0x200 # (fp = x8) *memory location?
sw a0, -4(fp)
addi fp, fp, -4
jal ra, main # (ra = x1)
addi fp, fp, 4
j exit

main:
    li sp, 0x300 # (sp = x2)
    sw t6, 0(sp) # memory location?
    sw t5, -4(sp) # (t5 = x30)
    sw t4, -8(sp) # (t4 = x29)
    sw t0, -12(sp) # (t0 = x5)
    sw t1, -16(sp) # (t1 = x6)
    sw t2, -20(sp) # (t2 = x7)
    sw t3, -24(sp) # (t3 = x28)
    addi sp, sp, -24
    lw t4, 0(fp) # t4 = c[]
    do:
        li t6, 0 # swapped = false
        li t5, 1 # i = 1 (int 4 bytes)
        for:
            slli t0, t5, 2
            add t0, t0, t4 # t0 => c[i] 
            lw t1, 0(t0) # t1 = c[i]
            lw t2, -4(t0) # t2 = c[i-1]
            blt t2, t1, exit_if
                mv t3, t1 # int temp = c[i]
                sw t2, 0(t0)  # c[i] = c[i-1]
                sw t3, -4(t0) # c[i-1] = temp
                li t6, 1 # swapped = true
            exit_if:
                addi t5, t5, 1
                bne t5, s1, for
    bne t6, zero, do
    lw t3, 0(sp)
    lw t2, 4(sp)
    lw t1, 8(sp)
    lw t0, 12(sp)
    lw t4, 16(sp)
    lw t5, 20(sp)
    lw t6, 24(sp)
    addi sp, sp, 24
    jalr x0, 0(ra)
exit:
    li a7, 10 # (a7 = x17)
    ecall


    
        

        

        

