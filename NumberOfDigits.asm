.data
    inp: .asciiz "Enter a number: "
    out: .asciiz "The number of digits: "
.text
main:
    li $v0,4
    la $a0,inp
    syscall
    
    li $v0,5
    syscall
    move $s0,$v0 #n
    move $s1,$s0 #copy of n
    
    li $t0,10    #divisor=10
    li $t1,0     #count of digit
    
    jal Length
        
    li $v0,10
    syscall

Length:
    li $v0,4
    la $a0,out
    syscall
Loop:
    beqz $s1,Print
    
    div $s1,$t0
    mflo $s1
    addi $t1,$t1,1  #increment count
    j Loop
Print:
    li $v0,1
    move $a0,$t1
    syscall
    
    jr $ra