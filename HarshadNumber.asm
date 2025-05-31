.data
    inp: .asciiz "Enter the number: "
    sum: .asciiz "The sum of the digits: "
    yes: .asciiz "\nThe number is a Harshad number"
    no: .asciiz "\nThe number is not a Harshad number"
.text
main:
    li $v0,4
    la $a0,inp
    syscall
    
    li $v0,5
    syscall
    move $s0,$v0   #input n
    move $s1,$s0   #copy of n
    
    li $t0,10      #divisor
    li $t1,0       #sum $t1=0
    
Loop:
    beqz $s1,Print
    
    div $s1,$t0
    mfhi $t2       #remainder
    mflo $s1
    
    add $t1,$t1,$t2  #sum+=remainder
    j Loop

Print:
    li $v0,4
    la $a0,sum
    syscall
    
    li $v0,1
    move $a0,$t1
    syscall
    
    div $s0,$t1
    mfhi $t3
    
    beqz $t3,Yes
    
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