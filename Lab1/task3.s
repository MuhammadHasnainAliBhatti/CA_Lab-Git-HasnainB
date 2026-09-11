.text
.globl main
# a = x1
# b = x2
# c = x3
# d = x4
# e = x5
main:
    addi x1, x0, 5 # a = 5
    add x2, x0, x0 # b = 0
    addi x1, x2, 32 # a = b + 32
    add x4, x1, x2 # d = a + b
    addi x4, x4, -5 # d = (a + b) - 5
    sub x5, x1, x4 # e = a - d
    sub x6, x2, x1 # x6 = b - a
    add x5, x5, x6 # e = ((a - d) + (b - a)) 
    add x5, x5, x4 # e = ((a - d) + (b - a)) + d
    add x5, x5, x1  # e = e + a
    add x5, x5, x2 # e = e + a + b
    add x5, x5, x4 # e = a + b + d + e

end:
    j end  # Infinite loop to halt program