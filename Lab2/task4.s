# a = x5
# b = x6
# i = x7
# j = x29
li x5, 3
li x6, 2
li x10, 8

li x3, 0 # x3 = i + j
li x2, 0 # x2 = 4 * j
li x7, 0
li, x29, 0 
mainLoop:
    li x29, 0
    inLoop:
        slli x2, x29, 2
        add x2, x2, x10
        add x3, x7, x29
        sw x3, 0(x2) 
        addi x29, x29, 1
        bne x29, x6, inLoop
    addi x7, x7, 1
    bne x7, x5, mainLoop



