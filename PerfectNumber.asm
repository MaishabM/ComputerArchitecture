.data
    inp: .asciiz "Enter an integer: "
    div: .asciiz "The divisors: "
    sum: .asciiz "\nThe sum of the digits: "
    perf: .asciiz "\nThe number is perfect"
    notperf: .asciiz "\nThe number is not perfect"
    space: .asciiz " "
.text
main:
    li $v0,4
    la $a0,inp
    syscall
    
    li $v0,5
    syscall
    move $s0,$v0  #the number
    move $s1,$s0  #copy of original number
    
    li $t0,0     #sum=$t0=0
    li $t1,1     #divisor $t1
    li $t4,0     #sum $t4
    
    li $v0,4
    la $a0,div
    syscall
    
Loop:
    beq $t1,$s0,Print
    
    div $s1,$t1
    mfhi $t2      #remainder
    
    bnez $t2,Next
    
    #printing the divisors
    li $v0,1
    move $a0,$t1
    syscall
    
    li $v0,4
    la $a0,space
    syscall
    
    add $t4,$t4,$t1
    
Next:
    addi $t1,$t1,1
    j Loop
 
Print:
    li $v0,4
    la $a0,sum
    syscall
    
    li $v0,1
    move $a0,$t4
    syscall
    
    beq $t4,$s0,Perfect
    
NotPerfect:
    li $v0,4
    la $a0,notperf
    syscall
    j Exit
    
Perfect:
    li $v0,4
    la $a0,perf
    syscall
    
Exit:
    li $v0,10
    syscall