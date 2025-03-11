.data
     inp: .asciiz "Input a 4 digit number: "
     pal: .asciiz "The number is a palindrome"
     notPal: .asciiz "The number is not a palindrome"
     out: .asciiz "\nThe reversed number is: "
.text
main:
     li $v0,4
     la $a0,inp
     syscall
     
     li $v0,5
     syscall
     move $t0,$v0
     move $t4,$t0  #Copy of the input
     
     li $t1,0    #Reverse number set to 0
loop:
     beqz $t4, Check
     
     divu $t4,$t4,10
     mfhi $t3
     
     mul $t1,$t1,10   #$t1 value is shifted to the left
     add $t1,$t1,$t3  #Append the digit in $t3 to $t1
     j loop
     
Check:
     beq $t0,$t1,PrintYes
     j PrintNo

PrintYes:
     li $v0,4
     la $a0,pal
     syscall
     
     j Exit
    
PrintNo:
     li $v0,4
     la $a0,notPal
     syscall
     
Exit:
     li $v0,4
     la $a0,out
     syscall
     
     li $v0,1
     move $a0,$t1
     syscall
     
     li $v0,10
     syscall
     