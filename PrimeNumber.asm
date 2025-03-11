.data
    message:.asciiz "Enter a value: "
    If_prime:.asciiz "The number is prime"
    If_not_prime:.asciiz "The number is not prime"
.text
main:
    #print message
    li $v0,4
    la $a0,message
    syscall
    
    #enter a number
    li $v0,5
    syscall
    move $t0,$v0
    
    #If number is less than equal 0, then not prime
    blez $t0,not_prime
    
    #If number is equal to 1, then not prime
    li $t1,1
    beq $t0,$t1,not_prime
    
    #If number is equal to 2, then prime
    li $t1,2
    beq $t0,$t1,prime
    
    #now check in loop from index 2 to sqrt(number)
    li $t2,2   #initialize index $t2 to 2
    
loop:
    div $t0,$t2
    mfhi $t3    #store remainder in $t3
    
    #if $t3 = 0 then not prime
    beqz $t3,not_prime
    
    addi $t2,$t2,1  #increment
    
    mul $t4,$t2,$t2  #If i^2>number, then number is prime
    bgt $t4,$t0,prime
    #^^^ exit loop
    
    j loop
    
prime:
    li $v0,4
    la $a0,If_prime
    syscall
    j exit
    
not_prime:
    li $v0,4
    la,$a0,If_not_prime
    syscall
    
exit:
    li $v0,10
    syscall
    