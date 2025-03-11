.data
     num:.asciiz "Enter your number: "
     Pos:.asciiz "The number is positive."
     Neg:.asciiz "The number is negative."
     
.text 
main:
     #Printing message
     li $v0,4
     la $a0,num
     syscall
     
     #taking input
     li $v0,5
     syscall 
     move $s0,$v0
     
     #checking whether positive or negative
     addi  $t0, $t0, 0        #Adding 0 to $t0
     slt $t0, $s0, $t0        #if $s0 is less than $t0(0), then slt is 1 (negative)
                              #if $s0 is greater than $t0(0), then slt is 0 (positive)
     beq $t0, 0, Positive     #branch if equal $t0 is 0, then positive otherwise negative
     j Negative
     
     #If number is positive, Positive label
     Positive:
     li $v0, 4
     la $a0, Pos
     syscall 
     
     j Exit
     
     #If number is negative, Negative label
     Negative:
     li $v0, 4
     la $a0, Neg
     syscall 
     
     j Exit
     
     #Exit code
     Exit:
     li $v0, 10
     syscall 