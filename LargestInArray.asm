.data
     array: .space 400
     inp: .asciiz "Enter the number of elements: "
     element: .asciiz "Enter the elements: \n"
     out: .asciiz "The array elements: "
     space: .asciiz " " 
     max: .asciiz "\nThe largest value is: "
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
     
     li $t1,0         # Array index i = 0
     li $t2,0         # Maximum $t2 = 0
     la $t3,array     # Base address of array-$t3
     
ArrayLoop:
     beq $t1,$t0,printArray
     
     li $v0,5
     syscall
     
     sw $v0,0($t3)
     
     addi $t1,$t1,1
     addi $t3,$t3,4
    
     bgt $v0,$t2,update
     j ArrayLoop
     
printArray:
     li $t1,0
     la $t3,array
     
     li $v0,4
     la $a0,out
     syscall
     
printLoop:
     beq $t1,$t0,print
     
     lw $t4,0($t3)
     
     li $v0,1
     move $a0,$t4
     syscall
     
     li $v0,4
     la $a0,space
     syscall
     
     addi $t1,$t1,1
     addi $t3,$t3,4
     j printLoop
     
print:
     li $v0,4
     la $a0,max
     syscall
     
     li $v0,1
     move $a0,$t2
     syscall
     
     li $v0,10
     syscall
     
update:
     move $t2,$v0
     j ArrayLoop