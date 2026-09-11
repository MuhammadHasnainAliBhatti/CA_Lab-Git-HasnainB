# x = x20
# a = x21
# b = x22
# c = x23
li x20, 5
li x22, 5
li x23, 10
li x1, 1
li x2, 2
li x3, 3
li x4, 4
bne x20, x1, c1
    add x21, x22, x23
    beq x0, x0, exit
c1: bne x20, x2, c2
    sub x21, x22, x23
    beq x0, x0, exit
c2: bne x20, x3, c3
    slli x21, x22, 1
    beq x0, x0, exit
c3: bne x20, x4 c4
    srai x21, x22, 1
    beq x0, x0, exit
c4: li x21, 0
exit: # code after exit