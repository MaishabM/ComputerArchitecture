.data
    inp: .asciiz "Enter the number: "
    rev: .asciiz "The reversed number: " 
    pal: .asciiz "\nThe numbers are palindrome"
    notpal: .asciiz "\nThe numbers are not palindrome"
.text
main:
    li $v0,4
    la $a0,inp
    syscall
    
    li $v0,5
    syscall
    move $s0,$v0   #number = $s0
    move $s1,$s0   #copy of number
    
    li $t0,0       # reverse number
    li $t1,10      #divisor
Loop:
    beqz $s1,Check
    
    div $s1,$t1
    mfhi $t2
    mflo $s1
    
    mul $t0,$t1,$t0
    add $t0,$t0,$t2
    j Loop
Check:
    li $v0,4
    la $a0,rev
    syscall
    
    li $v0,1
    move $a0,$t0
    syscall
    
    beq $s0,$t0,Palindrome
NotPalindrome:
    li $v0,4
    la $a0,notpal
    syscall
    j Exit
Palindrome:
    li $v0,4
    la $a0,pal
    syscall
Exit:
    li $v0,10
    syscall