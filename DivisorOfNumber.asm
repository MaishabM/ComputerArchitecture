.data
    inp: .asciiz "Enter the number : "
    div: .asciiz "The divisors: "
    space: .asciiz " "
.text
main:
    li $v0,4
    la $a0,inp
    syscall
    
    li $v0,5
    syscall
    move $s0,$v0 #n
    move $s1,$s0 #copy of n
    
    li $t1,1
    
    li $v0,4
    la $a0,div
    syscall
    
Loop:
    beq $s0,$t1,Exit
    
    div $s1,$t1
    mfhi $t2
    
    bnez $t2,Next
    
    li $v0,1
    move $a0,$t1
    syscall
    
    li $v0,4
    la $a0,space
    syscall
    
Next:
    addi $t1,$t1,1
    j Loop
    
Exit:
    li $v0,10
    syscall