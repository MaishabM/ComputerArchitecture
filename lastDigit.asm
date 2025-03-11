.data
     inp1: .asciiz "Enter first number: "
     inp2: .asciiz "Enter second number: "
     yesmsg: .asciiz "Last digits are the same"
     nomsg: .asciiz "Last digits are not the same"
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
     
     div $t0,$t0,10
     mfhi $t3
     
     div $t1,$t1,10
     mfhi $t4
     
     beq $t3,$t4, Same
     j NotSame
     
Same:
     li $v0,4
     la $a0,yesmsg
     syscall
     j Exit

NotSame:
     li $v0,4
     la $a0,nomsg
     syscall
      
Exit:
     li $v0,10
     syscall