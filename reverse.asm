.data
     inp: .asciiz "Enter a number: "
     out: .asciiz "The reversed number is: "
.text
main:
     li $v0,4
     la $a0,inp
     syscall
     
     li $v0,5
     syscall
     move $t0,$v0
     move $t2,$t0 #Copy of original number
     
     li $t1,0  #Reversed number store
loop:
     beqz $t2,Print
     
     div $t2,$t2,10
     mfhi $t3
     mflo $t2
     
     mul $t1,$t1,10
     add $t1,$t1,$t3
     
     j loop
     
Print:
     li $v0,4
     la $a0,out
     syscall
     
     li $v0,1
     move $a0,$t1
     syscall
     
     li $v0,10
     syscall