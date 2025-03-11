.data
      inp: .asciiz "Enter a number: "
      out: .asciiz "The square of the number is: "
.text
main:
      li $v0,4
      la $a0,inp
      syscall
      
      li $v0,5
      syscall
      move $t0,$v0
      
      jal Square
      
      li $v0,10
      syscall
      
Square:
      mul $t0,$t0,$t0
      
      li $v0,4
      la $a0,out
      syscall
      
      li $v0,1
      move $a0,$t0
      syscall
      
      jr $ra 