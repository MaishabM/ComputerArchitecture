.data
     inp: .asciiz "Enter the number: "
     into: .asciiz " x "
     eql: .asciiz " = "
     newline: .asciiz "\n"
.text
main:
     li $v0,4
     la $a0,inp
     syscall
     
     li $v0,5
     syscall
     move $t0,$v0   # $t0=n
     
     li $t1,1       # multiplier = $t1 = 1
Loop:
     bgt $t1,10,Exit
     
     mul $t3,$t0,$t1  # multiplication of t0 and t1
     li $v0,1
     move $a0,$t0
     syscall
     
     li $v0,4
     la $a0,into
     syscall
     
     li $v0,1
     move $a0,$t1
     syscall
     
     li $v0,4
     la $a0,eql
     syscall
     
     li $v0,1
     move $a0,$t3
     syscall
     
     li $v0,4
     la $a0,newline
     syscall
     
     addi $t1,$t1,1
     j Loop
     
Exit:
     li $v0,10
     syscall