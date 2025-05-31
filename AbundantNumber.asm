.data
    inp: .asciiz "Enter the number: "
    sum: .asciiz "\nThe sum of the divisors: "
    div: .asciiz "The divisors are: "
    space: .asciiz " "
    yes: .asciiz "\nThe number is an abundant number"
    no: .asciiz "\nThe number is not an abundant number"
.text
main:
    li $v0,4
    la $a0,inp
    syscall
    
    li $v0,5
    syscall
    move $s0,$v0  #n
    move $s1,$s0  #copy of n
    
    li $t0,1     #divisor
    li $t1,0     #sum of divisors
    
    li $v0,4
    la $a0,div
    syscall
    
Loop:
    beq $s1,$t0,Print
    
    div $s1,$t0
    mfhi $t2
    bnez $t2,Next
    
    add $t1,$t1,$t0
    
    li $v0,1
    move $a0,$t0
    syscall
    
    li $v0,4
    la $a0,space
    syscall

Next:
    addi $t0,$t0,1
    j Loop

Print:
    li $v0,4
    la $a0,sum
    syscall
    
    li $v0,1
    move $a0,$t1
    syscall
    
    bgt $t1,$s0,Yes
    
    li $v0,4
    la $a0,no
    syscall
    j Exit
    
Yes:
    li $v0,4
    la $a0,yes
    syscall
    
Exit:
    li $v0,10
    syscall