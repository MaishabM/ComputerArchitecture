.data
     inp: .asciiz "Enter the number: "
     out: .asciiz "The factorial is: "
.text
main:
     li $v0,4
     la $a0,inp
     syscall
     
     li $v0,5
     syscall
     move $t0,$v0
     
     li $t1,1       #Factorial result set to 1
     li $t2,1       #Index set to 1
fact:
     bgt $t2,$t0,Exit
     
     mul $t1,$t1,$t2
     addi $t2,$t2,1
     j fact
Exit:
     li $v0,1
     move $a0,$t1
     syscall
     
     li $v0,10
     syscall