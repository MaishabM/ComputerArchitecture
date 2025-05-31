.data
    array: .space 400
    zero: .float 0.0
    inp: .asciiz "Enter n: "
    elmnt: .asciiz "Enter elements: "
    sum: .asciiz "\nThe sum of elements: "
    avg: .asciiz "\nThe avg of elements: "

.text
main:
    li $v0, 4
    la $a0, inp
    syscall

    li $v0, 5         # n
    syscall
    move $s0, $v0     # $s0 = n

    li $v0, 4
    la $a0, elmnt
    syscall

    li $t0, 0         # i = 0
    la $t1, array     # base address
    l.s $f2, zero    # initialize sum = 0.0

Loop:
    beq $t0, $s0, Print

    li $v0, 6
    syscall
    s.s $f0, 0($t1)   # store from $f0 to array
    add.s $f2, $f2, $f0

    addi $t0, $t0, 1
    addi $t1, $t1, 4
    j Loop

Print:
    li $v0, 4
    la $a0, sum
    syscall

    li $v0, 2
    mov.s $f12, $f2
    syscall

    li $v0, 4
    la $a0, avg
    syscall

    mtc1 $s0, $f4
    cvt.s.w $f4, $f4     # convert int n to float
    div.s $f6, $f2, $f4  # f6 = sum / n

    li $v0, 2
    mov.s $f12, $f6
    syscall

    li $v0, 10
    syscall