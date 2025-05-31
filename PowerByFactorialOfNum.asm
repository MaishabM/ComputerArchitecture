.data
    sum: .float 0.0
    inp: .asciiz "Enter the number: "
    out: .asciiz "The result: "
.text
main:
    li $v0, 4
    la $a0, inp
    syscall

    li $v0, 5
    syscall
    move $s0, $v0     # s0 = n

    li $t0, 1        #index i=1
    l.s $f12, sum    # $f12 to initialize sum of division

Loop:
    bgt $t0, $s0, Exit

    move $t1, $t0      # base = i
    move $t2, $t0      # exponent = i
    li $t3, 1          # result = 1

PowerLoop:
    #2*3 = 2*2*2 (exponent times base*base)
    beqz $t2, PowerDone
    mul $t3, $t3, $t1  # result = result*base
    subi $t2, $t2, 1   # decrement exp--
    j PowerLoop

PowerDone:
    move $t4, $t3      # t4 = i^i

    move $t5, $t0      # index to i
    li $t6, 1          # fact i!

FactLoop:
    beqz $t5, FactDone
    mul $t6, $t6, $t5
    subi $t5, $t5, 1
    j FactLoop

FactDone:
    move $t7, $t6      # t7 = i!

    mtc1 $t4, $f0      # move i^i to float
    mtc1 $t7, $f1      # move i! to float
    cvt.s.w $f0, $f0   #convert from word to float
    cvt.s.w $f1, $f1   #convert from word to float

    #Float division:i^i / i!
    div.s $f2, $f0, $f1
    add.s $f12, $f12, $f2  #add to sum the division

    addi $t0, $t0, 1  #increment i++
    j Loop

Exit:
    li $v0, 4
    la $a0, out
    syscall

    li $v0, 2  #by default prints result in $f12 register which has sum
    syscall

    li $v0, 10
    syscall