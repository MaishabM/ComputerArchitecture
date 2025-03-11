.data
        ms1:.asciiz "Enter your number: "
        ms2:.asciiz  "Your Number: "
        
.text
main:
        
        #printing ms1
        li $v0,4
        la $a0,ms1
        syscall
        
        #taking the input
        li $v0,5
        syscall
        move $s0,$v0
        
        #printing ms2
        li $v0,4
        la $a0,ms2
        syscall
        
        #printing the number
        li $v0,1
        move $a0,$s0
        syscall
        
        #exiting
        li $v0,10
        syscall
        