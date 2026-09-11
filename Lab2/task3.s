# i = x22
# sum = x23
#li x22, 0
#li x2, 0
#li x10, 10
#Loop: 
#   sw x22, 0x200(x2)
#   addi x22, x22, 1
#   slli x2, x22, 2
#   bne x22 x10 Loop
li x1, 5
sw x1, 0x200(x0)
sw x1, 0x204(x0)
sw x1, 0x208(x0)
sw x1, 0x20C(x0)
sw x1, 0x210(x0)
sw x1, 0x214(x0)
sw x1, 0x218(x0)
sw x1, 0x21C(x0)
sw x1, 0x220(x0)
sw x1, 0x224(x0)

li x22, 0
li x23, 0
li x2, 0
li x10, 10
Loop2: 
    slli x2, x22, 2
    lw x2, 0x200(x2)
    add x23, x23, x2
    addi x22, x22, 1
    bne x22 x10 Loop2