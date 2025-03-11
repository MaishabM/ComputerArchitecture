.data
    str: .space 6
    msg: .asciiz "Enter a 5 length message: "

.text
main:
    # Printing a message
    li $v0, 4
    la $a0, msg
    syscall
    
    # Reading a string
    la $a0, str
    li $a1, 6
    li $v0, 8
    syscall
    
    # Printing a string
    li $v0, 4
    la $a0, str
    syscall
    
    # Exiting
    li $v0, 10
    syscall
