.data
    str: .space 50
    rev: .space 50
    inp: .asciiz "Enter a data: "
    revmsg: .asciiz "The reversed data: "
    pal: .asciiz "The number/word is a palindrome\n"
    notPal: .asciiz "The number/word is not a palindrome\n"
.text
main:
    li $v0,4
    la $a0,inp
    syscall
    
    li $v0,8
    la $a0,str
    li $a1,30
    syscall
    
    li $t0,0   #length of string
    la $t1,str  #base address of str
Length:
    lb $t2,0($t1)
    
    beq $t2,10,Compare
    addi $t0,$t0,1
    addi $t1,$t1,1
    j Length

Compare:
    addi $t3,$zero,0  #Left index $t3=0 
    subi $t4,$t0,1    #right index $t4=$t0-1

StringCheck:
    bgt $t3,$t4,Palindrome
    
    lb $t5, str($t3)
    lb $t6, str($t4)
    
    bne $t5,$t6,NotPalindrome
    
    addi $t3,$t3,1
    subi $t4,$t4,1
    j StringCheck

Palindrome:
    li $v0,4
    la $a0,pal
    syscall
    j Reverse
    
NotPalindrome:
    li $v0,4
    la $a0,notPal
    syscall

Reverse:
    li $v0,4
    la $a0,revmsg
    syscall
    
    li $t7,0        #rev index
    la $t8,rev      #base address of rev
    subi $t0,$t0,1  #last index of str
    
RevLoop:
    bltz $t0,Print
    
    lb $t9,str($t0)
    sb $t9,0($t8)
    
    subi $t0,$t0,1
    addi $t8,$t8,1
    j RevLoop
    
Print:
    li $v0,4
    la $a0,rev
    syscall
    
Exit:
    li $v0,10
    syscall
    
