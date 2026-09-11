addi x10, x0, 12
addi x11, x0, 12
jal x1, summ # calls the function named sum
addi x11, x10, 0
li x10, 1
ecall
j exit
summ:
    add x10, x11, x10
    jalr x0, 0(x1)
exit:
    li x2, 2

