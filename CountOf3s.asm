.data
    inp: .asciiz "Enter the number: "
    out: .asciiz "The number of 3s: "
.text
main:
    li $v0,4
    la $a0,inp
    syscall
    
    li $v0,5
    syscall
    move $s0,$v0   #n
    move $s1,$s0   #copy of n
    
    li $t0,10     #divisor
    li $t1,0      #count of 3
    li $t2,3      #number 3
    
    jal Count
    
    li $v0,1
    move $a0,$t1
    syscall
   
    li $v0,10
    syscall

Count:
    li $v0,4
    la $a0,out
    syscall
    
Loop:
    beqz $s1,Back
    
    div $s1,$t0
    mfhi $t3
    mflo $s1
    
    bne $t3,$t2,Next
    
    addi $t1,$t1,1
Next:
    j Loop
    
Back:
    jr $ra