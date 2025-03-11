.data
     num1:.asciiz "Enter first number: "
     num2:.asciiz "Enter second number: "
     Equal:.asciiz "Numbers are equal."
     NotEqual:.asciiz "Numbers are not equal."
.text 
main:
     #printing message
     li $v0,4
     la $a0,num1
     syscall
     
     #taking first input
     li $v0,5
     syscall
     move $t1,$v0
     
     #printing message
     li $v0,4
     la $a0,num2
     syscall
     
     #taking second input
     li $v0,5
     syscall 
     move $t2,$v0
     
     #checking equality
     beq $t1, $t2, Eq    #beq= Branch If Equal, Eq= label Eq
     j NEq               #j=jump, NEq = label NEq
     
     #Label Eq
     Eq:
     li $v0,4
     la $a0, Equal
     syscall
     
     li $v0,10           #Exit
     syscall
     
     #Label NEq
     NEq:
     li $v0,4
     la $a0, NotEqual
     syscall
     
     li $v0,10           #Exit
     syscall
     
     #Exit commands can also be written as 
     # j Exit   (where Exit is label)
     # Exit:
     # li $v0,10
     # syscall