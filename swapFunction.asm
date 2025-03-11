.data
     inp1: .asciiz "Enter 1st number: "
     inp2: .asciiz "Enter 2nd number: "
     sw1: .asciiz "After swapping 1st number: "
     sw2: .asciiz "\nAfter swapping 2nd number: "
     
.text
main:
     li $v0,4
     la $a0,inp1
     syscall
     
     li $v0,5
     syscall
     move $s0,$v0
     
     li $v0,4
     la $a0,inp2
     syscall
     
     li $v0,5
     syscall
     move $s1,$v0
     
     jal Swap
     
     li $v0,10
     syscall
    
Swap:
     move $t1,$s0
     move $s0,$s1
     move $s1,$t1
     
     li $v0,4
     la $a0,sw1
     syscall
     
     li $v0,1
     move $a0,$s0
     syscall
     
     li $v0,4
     la $a0,sw2
     syscall
     
     li $v0,1
     move $a0,$s1
     syscall
     jr $ra