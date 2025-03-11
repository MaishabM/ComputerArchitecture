.data
       array: .space 400
       inp: .asciiz "Enter the number of elements: "
       element: .asciiz "Enter the elements: \n"
       ifPrime: .asciiz "The prime numbers: "
       space: .asciiz " "
.text
main:
       li $v0,4
       la $a0,inp
       syscall
       
       li $v0,5
       syscall
       move $t0,$v0     # $t0 = n
       
       li $v0,4
       la $a0,element
       syscall
       
       la $t1,array     # array base address $t1
       li $t2,0         # i = 0
       
arrayInput:
       beq $t2,$t0,Check
       
       li $v0,5
       syscall
       move $t3,$v0
       
       sw $t3,0($t1)
       
       addi $t1,$t1,4
       addi $t2,$t2,1
       j arrayInput

Check:
       la $t1,array     # reset array base address $t1
       li $t2,0         # reset i = 0
       
       li $v0,4
       la $a0,ifPrime
       syscall
       
primeCheck:
       beq $t2,$t0,Exit
       
       lw $t3,0($t1)
       move $a1,$t3
       
       jal LoopCheck
       
       addi $t2,$t2,1
       addi $t1,$t1,4
       j primeCheck
       
Exit:
       li $v0,10
       syscall
       
LoopCheck:
       li $t4,2         # initialize to 2 for prime check      
loop:
       beq $t4,$a1,Prime
       
       div $a1,$t4
       mfhi $t6
       
       beqz $t6,NotPrime
       
       addi $t4,$t4,1
       j loop
    
Prime:      
       li $v0,1
       move $a0,$a1
       syscall
       
       li $v0,4
       la $a0,space
       syscall
       
       jr $ra
       
NotPrime:
       jr $ra
