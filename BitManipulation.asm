.data
      Newline: .asciiz "\n"
      inp: .asciiz "Enter a number: "
.text
main:
      li $v0,4
      la $a0,inp
      syscall
      
      li $v0,5
      syscall
      move $a1,$v0
      
      jal PrintNumber
      
      jal BitShift
      
      move $a1,$t1
      jal PrintNumber
      
      li $v0,10
      syscall
      
PrintNumber:      
      li $v0,1
      move $a0,$a1
      syscall
      
      li $v0,4
      la $a0,Newline
      syscall
      
      jr $ra

BitShift:
      #mask is in $s0
      addi $sp,$sp,-4
      sw $s0,0($sp)
      
      #Making the mask
      li $s0,-2
      sll $s0,$s0,1
      and $t1,$a1,$s0
      
      lw $s0,0($sp)
      addi $sp,$sp,4

      jr $ra