.data
      inp1: .asciiz "Enter 1st number: "
      inp2: .asciiz "Enter 2nd number: "
      out1: .asciiz "After swap, 1st number: "
      out2: .asciiz "\nAfter swap, 2nd number: "
.text
main:
      li $v0,4
      la $a0,inp1
      syscall
      
      li $v0,5
      syscall
      move $t0,$v0
      
      li $v0,4
      la $a0,inp2
      syscall
      
      li $v0,5
      syscall
      move $t1,$v0
      
      jal Swap
      
      li $v0,10
      syscall
Swap:
      move $t2,$t0
      move $t0,$t1
      move $t1,$t2
      
      li $v0,4
      la $a0,out1
      syscall
      
      li $v0,1
      move $a0,$t0
      syscall
      
      li $v0,4
      la $a0,out2
      syscall
      
      li $v0,1
      move $a0,$t1
      syscall
      
      jr $ra