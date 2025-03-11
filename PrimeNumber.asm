.data
     inp: .asciiz "Enter a number: "
     ifPrime: .asciiz "The number is prime"
     ifNotPrime: .asciiz "The number is not prime"
.text
main:
     li $v0,4
     la $a0,inp
     syscall
     
     li $v0,5
     syscall
     move $t0,$v0
     
     li $t1,2      #index i = 2
Check:
     beq $t1,$t0,Prime
     
     div $t0,$t1
     mfhi $t2
     
     beqz $t2,notPrime
     
     addi $t1,$t1,1
     j Check
     
Prime:
     li $v0,4
     la $a0,ifPrime
     syscall
     j exit
    
notPrime:
     li $v0,4
     la $a0,ifNotPrime
     syscall
     
exit:
     li $v0,10
     syscall