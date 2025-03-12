.data
      string: .space 100     #max 100 space for string
      inp: .asciiz "Enter the string: "
      pal: .asciiz "The word is a palindrome"
      notPal: .asciiz "The word is not a palindrome"
.text
main:
      li $v0,4
      la $a0,inp
      syscall
      
      li $v0,8
      la $a0,string
      li $a1,100
      syscall
      
      #check the length of string
      li $t0,0        # i=0
      la $t1,string   # Base address of string
      
findLength:      
      lb $t2,0($t1)      # Load the char in $t2
      
      beq $t2,10,Compare # If $t2 == \n, break (newline == ASCII 10)
      
      addi $t0,$t0,1     #Increment length
      addi $t1,$t1,1     # Increment address of string
      j findLength
      
Compare: 
      addi $t3,$zero,0   # Left index i=0
      addi $t4,$t0,-1    # Right index j=length-1 (excluding \n)
      
StringCheck:
      bge $t3,$t4, Palindrome  # If left Index == Right index, palindrome
      
      lb $t5,string($t3) # $t5 = string[i]
      lb $t6,string($t4) # $t6 = string[j]
      
      bne $t5,$t6, NotPalindrome   #If string[i] != string[j],NotPalindrome
      
      addi $t3,$t3,1
      addi $t4,$t4,-1
      
      j StringCheck
      
Palindrome: 
      li $v0,4
      la $a0,pal
      syscall
      
      j Exit
      
NotPalindrome:
      li $v0,4
      la $a0,notPal
      syscall
      
Exit:
      li $v0,10
      syscall