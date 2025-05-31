.data
   inp: .asciiz "Enter number of elements: "
   out: .asciiz "The fibonacci numbers: "
   sp: .asciiz " "
.text
main:
   li $v0,4
   la $a0,inp
   syscall
   
   li $v0,5
   syscall
   move $t0,$v0  #n
   
   li $v0,4
   la $a0,out
   syscall
   
   jal Fibonacci
   
   li $v0,10
   syscall
   
Fibonacci:
   li $s0,0
   li $s1,1
   
   li $t1,0  #index i
Loop:
   beq $t1,$t0,Return
   
   li $v0,1
   move $a0,$s0
   syscall
   
   li $v0,4
   la $a0,sp
   syscall
   
   add $t2,$s0,$s1
   move $s0,$s1
   move $s1,$t2
   
   addi $t1,$t1,1
   j Loop
Return:
   jr $ra
