.data
     inp: .asciiz "Enter the number of elements: "
     out: .asciiz "The fibonacci numbers are: "
     space: .asciiz " "
.text
main:
     li $v0,4
     la $a0,inp
     syscall
     
     li $v0,5
     syscall
     move $t0,$v0  #Store n
     
     li $t1,0   #First number is 0
     li $t2,1   #Second number is 1
     li $t3,1   # Index set to 1
     
     li $v0,4
     la $a0,out
     syscall
     
loop:
     beq $t3,$t0,Exit
     
     #First number print
     li $v0,1
     move $a0,$t1
     syscall
     
     li $v0,4
     la $a0,space
     syscall
     
     add $t5,$t1,$t2  #$t5 is the temp register where we save addition result
     move $t1,$t2
     move $t2,$t5
     
     addi $t3,$t3,1   #Increment index
     j loop

Exit:
     li $v0,1
     move $a0,$t1
     syscall
    
     li $v0,10
     syscall