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
     
     li $v0,4
     la $a0,out
     syscall
loop:
     beqz $t2,Exit
     
     div $t2,$t2,10
     mfhi $t3
    
     li $v0,1
     move $a0,$t3
     syscall
     
     j loop
     
Exit:  
     li $v0,10
     syscall
