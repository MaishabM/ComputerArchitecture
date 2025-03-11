.data
     array: .space 400
     inp: .asciiz "Enter number of elements: "
     element: .asciiz "The array elements: \n"
     out: .asciiz "The even elements are: "
     space: .asciiz " "
.text
main:
     li $v0,4
     la $a0,inp
     syscall
     
     li $v0,5
     syscall
     move $t0,$v0    # $t0 = n
     
     li $t1,2        #set $t1 to 2
     
     li $v0,4
     la $a0,element
     syscall
     
     la $t2,array   #Load base address of array
     li $t3,0       # i = 0
     
Loop:
     beq $t3,$t0,findEven
     
     li $v0,5
     syscall
     move $t4,$v0
     
     sw $t4,0($t2)
     
     addi $t3,$t3,1
     addi $t2,$t2,4
     j Loop
     
findEven:
     li $t3,0       #Reset index to 0
     la $t2,array
     
     li $v0,4
     la $a0,out
     syscall
     
Loop2:
     beq $t3,$t0,exit
     
     lw $t4,0($t2)
     
     div $t4,$t1
     mfhi $t5
     
     beqz $t5, print
     
     addi $t3,$t3,1
     addi $t2,$t2,4
     j Loop2
     
print:
     li $v0,1
     move $a0,$t4
     syscall
     
     li $v0,4
     la $a0,space
     syscall
     
     addi $t3,$t3,1
     addi $t2,$t2,4
     j Loop2
     
exit:
     li $v0,10
     syscall