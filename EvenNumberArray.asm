#Print even numbers of the array
.data
    msg: .asciiz "Enter 10 elements of array\n"
    array: .space 40
    comma: .asciiz ", "
    EvenMsg: .asciiz "Even numbers are: "
.text
main:
    #initialization
    li $s2, 2 #set $s2 = 2.

    #print entry message
    li $v0, 4
    la $a0, msg
    syscall

    addi $s0, $zero, 0  #set index to 0
    
loop1:
    beq $s0, 40, print  #if 10 integers are read, go to print
    
    li $v0, 5  #take array elements from user
    syscall
    move $t1, $v0
    
    sw $t1, array($s0) #store word from $t1 in array index $s0
    addi $s0, $s0, 4   #increment $s0 by 1 index (4 byte)
    
    j loop1
    
print:
    #print even message
    li $v0, 4
    la $a0, EvenMsg
    syscall

    addi $s0, $zero, 0  #reset $s0 index to 0
    
loop2:
    beq $s0, 40, exit
    
    lw $s3, array($s0)  #load word in $s3 from array index $s0
    addi $s0, $s0, 4
    
    div $s3, $s2
    mfhi $s4 
    beqz $s4, even
    j loop2

even:
    li $v0, 1 #print integer
    move $a0, $s3
    syscall

    beq $s0, 40, exit
    
    li $v0, 4  #print comma
    la $a0, comma
    syscall
    j loop2

exit:
    li $v0, 10
    syscall
