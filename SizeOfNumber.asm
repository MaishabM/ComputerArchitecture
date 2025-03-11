.data
     inp: .asciiz "Enter the number: "
     out: .asciiz "The number of digits is: "
.text
main:
     li $v0,4
     la $a0,inp
     syscall
     
     li $v0,5
     syscall
     move $t0,$v0
     
     li $t1,0       # Digit number is 0
Loop:
     beq $t0,$zero,Exit
     
     div $t0,$t0,10
     addi $t1,$t1,1
     j Loop
     
Exit:
     li $v0,4
     la $a0,out
     syscall
     
     li $v0,1
     move $a0,$t1
     syscall
     
     li $v0,10
     syscall