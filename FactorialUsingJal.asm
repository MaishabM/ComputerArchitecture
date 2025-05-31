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
   move $t0,$v0   #n
   
   li $v0,4
   la $a0,out
   syscall
   
   jal factorial
   
   li $v0,1
   move $a0,$t1   #result=$t1
   syscall
   
   li $v0,10
   syscall
   
factorial:
   li $t2,1
   ble $t0,$t2,BaseCase
   
   addi $sp,$sp,-8
   sw $ra,0($sp)
   sw $t0,4($sp)
   
   #recursive call
   addi $t0,$t0,-1  #index = n-1
   jal factorial
   
   lw $t0,4($sp)
   lw $ra,0($sp)
   addi $sp,$sp,8
   
   mul $t1,$t0,$t1
   jr $ra
   
BaseCase:
   li $t1,1  # multiplication $t1=1
   jr $ra