.data
       array: .space 400
       inp: .asciiz "Enter the number of elements: "
       element: .asciiz "Enter the elements: \n"
       out: .asciiz "The prime numbers: "
       space: .asciiz " "
.text
main:
       li $v0,4
       la $a0,inp
       syscall
       
       li $v0,5
       syscall
       move $s0,$v0     # $s0 = n
       
       li $v0,4
       la $a0,element
       syscall
       
       la $t1,array     # array base address $t1
       li $t2,0         # i = 0
       
arrayInput:
       beq $t2,$s0,Check
       
       li $v0,5
       syscall
       move $t3,$v0
       
       sw $t3,0($t1)
       
       addi $t1,$t1,4
       addi $t2,$t2,1
       j arrayInput

Check:
       li $t1,0
       la $t2,array
       
       li $v0,4
       la $a0,out
       syscall
CheckLoop:
       beq $t1,$s0,Exit
       
       lw $t3,0($t2)
       jal PrimeCheck
       addi $t1,$t1,1
       addi $t2,$t2,4
       j CheckLoop

Exit:
       li $v0,10
       syscall

PrimeCheck:
       li $t4,2     #divisor
PrimeLoop:
       mul $t6,$t4,$t4
       bgt $t6,$t3,Prime
       
       div $t3,$t4
       mfhi $t5
       beqz $t5,NotPrime
       
       addi $t4,$t4,1
       j PrimeLoop

Prime:
       li $v0,1
       move $a0,$t3
       syscall
       
       li $v0,4
       la $a0,space
       syscall
       jr $ra
NotPrime:
       jr $ra