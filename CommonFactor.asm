.data
     inp1: .asciiz "Enter first number: "
     inp2: .asciiz "Enter second number: "
     factor: .asciiz "The common factors are: "
     comma: .asciiz ", "
.text
main:
     li $v0,4
     la $a0,inp1
     syscall
     
     li $v0,5
     syscall
     move $t0,$v0
     
     li $v0,4
     la $a0,inp2
     syscall
     
     li $v0,5
     syscall
     move $t1,$v0
     
     #find minimum of two numbers
     move $t2,$t0
     bge $t1,$t2,Outerloop
     move $t2,$t1
     
Outerloop:
     li $t3,1   #counter and the common factor
     
     li $v0,4
     la $a0,factor
     syscall
     
FindFact:
     beq $t3,$t2, Exit
     
     div $t0,$t3
     mfhi $t4
     bne $t4,$zero,next
     
     div $t1,$t3
     mfhi $t4
     bne $t4,$zero,next  
     
     li $v0,1
     move $a0,$t3
     syscall
     
     li $v0,4
     la $a0,comma
     syscall

next:
     addi $t3,$t3,1
     j FindFact
     
Exit:
     li $v0,10
     syscall  