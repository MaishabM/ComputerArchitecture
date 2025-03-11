.data
     array: .space 16
     msg: .asciiz "Enter 4 elements of array: "
     output: .asciiz "The numbers are: "
     space: .asciiz "  "
.text
main:
     #Print msg
     li $v0,4
     la $a0,msg
     syscall
     
     addi $s0,$zero,0
arrayLoop:
     beq $s0,16,Print
     
     li $v0,5
     syscall
     move $t1,$v0
     
     sw $t1,array($s0) #store words of $t1 into array index $s0
     addi $s0,$s0,4
     
     j arrayLoop
     
Print:
     #output message
     li $v0,4
     la $a0,output
     syscall
     
     addi $s0,$zero,0
 outputLoop:
     beq $s0,16,Exit
     
     lw $t2,array($s0) #load word of array index $s0 in $t2
     li $v0,1
     move $a0,$t2
     syscall
     
     li $v0,4
     la $a0,space
     syscall
     
     addi $s0,$s0,4
     j outputLoop
     
Exit:
     li $v0,10
     syscall