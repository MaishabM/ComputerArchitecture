.data
     array: .space 400
     inp: .asciiz "Enter the number of elements: "
     element: .asciiz "The array elements: "
     diff: .asciiz "The difference between Odd and Even numbers: "
.text
main:
     li $v0,4
     la $a0,inp
     syscall
     
     li $v0,5
     syscall
     move $t0,$v0    # $t0 = n
     
     li $s0,2        # set $s2 = 2
     la $t1,array    # Array base address $t1
     li $t2,0        # array index i=0
     li $t3,0        # sum of odd number = 0
     li $t4,0        # sum of even number = 0
     
ArrayInput:
     beq $t2,$t0,ArrayType
     
     li $v0,4
     la $a0,element
     syscall
     
     li $v0,5
     syscall
     move $t5,$v0
     
     sw $t5,0($t1)
     
     addi $t2,$t2,1
     addi $t1,$t1,4
     j ArrayInput
     
ArrayType:
     li $t2,0
     la $t1,array
     
LoopCheck:
     beq $t2,$t0,print
     
     lw $t5,0($t1)
     div $t5,$s0
     mfhi $t6          #Remainder of array[i]/2
     
     beqz $t6,even
     j odd
     
    # addi $t1,$t1,4
    # addi $t2,$t2,1
    # j LoopCheck
     
even:
     add $t4,$t4,$t5    #$t4 is the sum of even number
     
     addi $t1,$t1,4
     addi $t2,$t2,1
     j LoopCheck
     
odd:
     add $t3,$t3,$t5    #$t3 is the sum of odd number
     
     addi $t1,$t1,4
     addi $t2,$t2,1
     j LoopCheck
     
print:
     bgt $t3,$t4,OddGreater
     sub $t6,$t4,$t3
     
     li $v0,4
     la $a0,diff
     syscall
     
     li $v0,1
     move $a0,$t6
     syscall
     
     j exit
     
OddGreater:
     sub $t6,$t3,$t4
     
     li $v0,4
     la $a0,diff
     syscall
     
     li $v0,1
     move $a0,$t6
     syscall
     
     j exit
     
exit:
     li $v0,10
     syscall