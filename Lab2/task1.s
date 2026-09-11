bne x22, x23, Else
add x19, x20, x21
beq x0, x0, Exit
Else: sub x19, x20, x21
Exit: li x1, 1

#li x22, 0
#li x24, 2
#li x25, 16
#li x2, 2
#li x3, 2
#li x4, 4
#li x5, 2
#sw x2, 0(x25)
#sw x3, 4(x25)
#sw x4, 8(x25)
#sw x5, 12(x25)

Loop: slli x10, x22, 2
add x10, x10, x25
lw x9, 0(x10)
bne x9, x24, Exitt
addi x22, x22, 1
beq x0, x0, Loop
Exitt: li x1, 10
