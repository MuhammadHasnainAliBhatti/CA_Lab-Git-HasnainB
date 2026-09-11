# v[] = x10
# k = x11
li x10, 0x100
li x11, 4
li x27, 27
li x28, 28
sw x27, 4(x10) # v[k] = 27
sw x28, 8(x10) # v[k+1] = 28
li x1, 0x200 # sp = 0x200, stack for arguments
sw x10, -4(x1)
# memory little endian format
sw x11, -8(x1)
addi x1, x1, -8
jal x2, swap
addi x1, x1, 8
j exit 

swap:
# another stack recommended for registers used within func
    lw x20, 0(x1) # x20 = k
    lw x21, 4(x1) # x21 = v[]
    add x20, x20, x21 # x20 = v[k]
    lw x22, 0(x20) # (x22) temp = v[k]
    lw x19, 4(x20) # x19 = v[k+1]
    sw x19, 0(x20) # v[k] = v[k+1]
    sw x22, 4(x20) # v[k+1] = temp
    jalr x0, 0(x2)
exit:
    li x31, 31
    li x31, 31

    


