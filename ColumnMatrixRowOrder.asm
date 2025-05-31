.data
    array: .space 400
    inp: .asciiz "Enter n for (n x n): "
    column: .asciiz "Enter data of column: "
    out: .asciiz "The matrix: \n"
    space: .asciiz " "
    newline: .asciiz "\n"

.text
main:
    li $v0, 4
    la $a0, inp
    syscall

    li $v0, 5
    syscall
    move $s0, $v0         # s0 = n

    li $t0, 0             # column index j = 0

InputLoopCol:
    beq $t0, $s0, Print   # if j = n, print
    
    li $v0,4
    la $a0,column
    syscall
    
    addi $s1,$t0,1
    li $v0,1
    move $a0,$s1
    syscall
    
    li $v0,4
    la $a0,newline
    syscall

    li $t1, 0             # row index i = 0

InputLoopRow:
    beq $t1, $s0, NextCol

    li $v0, 5
    syscall
    move $t2, $v0

    # address = base + 4 * (row * n + column)
    mul $t3, $t1, $s0     # t3 = i * n
    add $t3, $t3, $t0     # t3 = i * n + j
    mul $t3, $t3, 4       # t3 * 4
    la $t4, array         # base pointer of array
    add $t4, $t4, $t3     # base + 4 * (i * n + j)

    sw $t2, 0($t4)

    addi $t1, $t1, 1      # i++ (Row++)
    j InputLoopRow

NextCol:
    addi $t0, $t0, 1      # j++ (Column++)
    j InputLoopCol

Print:
    li $v0, 4
    la $a0, out
    syscall

    li $t0, 0             # i = 0 (row index)
    
PrintRow:
    beq $t0, $s0, Exit
    
    li $t1, 0             # j = 0 (column index)
    
PrintCol:
    beq $t1, $s0, NewLine

    # Compute address = base + 4 * (row * n + column)
    mul $t2, $t0, $s0
    add $t2, $t2, $t1
    mul $t2, $t2, 4
    la $t3, array
    add $t3, $t3, $t2

    lw $t4, 0($t3)

    li $v0, 1
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, space
    syscall

    addi $t1, $t1, 1      # j++ (column++)
    j PrintCol

NewLine:
    li $v0, 4
    la $a0, newline
    syscall

    addi $t0, $t0, 1      # i++ (row++)
    j PrintRow

Exit:
    li $v0, 10
    syscall