# g = x10
# h = x11
# i = x12
# j = x13
# f = x20
# temp = x18
# tem = x19
# x30 = g + h
# x31 = i + j

li x10, 0
li x11, 1
li x12, 2
li x13, 3

li x1, 0x100
sw x10, -4(x1)
sw x11, -8(x1)
sw x12, -12(x1)
sw x13, -16(x1)
addi x1, x1, -16 # *

jal x2, leaf_example

addi x11, x20, 0 

li x10, 1

ecall 
j exit

leaf_example:
    lw x18, 0(x1)
    lw x19, 4(x1)
    add x31, x18, x19 
    lw x18, 8(x1)
    lw x19, 12(x1) #12
    add x30, x18, x19
    sub x20, x30, x31
    jalr x0, 0(x2)
exit:
    li x21, 21
    li x21, 22