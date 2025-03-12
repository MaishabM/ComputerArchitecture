.data
      array: .space 400
      inp: .asciiz "Enter the number of elements: "
      element: .asciiz "Enter the elements: "
      num: .asciiz "Enter the number to be searched: "
      ifFound: .asciiz "The number is in position: "
      ifNotFound: .asciiz "The number is not in the array."
.text
main:
      li $v0,4
      la $a0,inp
      syscall
      
      li $v0,5
      syscall
      move $t0,$v0
      
      li $v0,4
      la $a0,element
      syscall
      
      li $t1,0     # i = 0
      la $t2,array # Base address of array
      
ArrayInput: 
      beq $t1,$t0,Search
      
      li $v0,5
      syscall
      move $t3,$v0
      
      sw $t3,0($t2)
      
      addi $t1,$t1,1
      addi $t2,$t2,4
      j ArrayInput
      
Search:
      li $v0,4
      la $a0,num
      syscall
      
      li $v0,5
      syscall
      move $a1,$v0     #The searched num is in $a1
      
      li $t1,0
      la $t2,array
      
      jal NumSearch
      
      li $v0,10
      syscall
      
NumSearch:
      beq $t1,$t0,NotFound
      
      lw $t3,0($t2)
      
      beq $t3,$a1,found
      
      addi $t1,$t1,1
      addi $t2,$t2,4
      
      j NumSearch
      
found:
      li $v0,4
      la $a0,ifFound
      syscall
      
      addi $t1,$t1,1
      li $v0,1
      move $a0,$t1
      syscall
      
      jr $ra
      
NotFound:
      li $v0,4
      la $a0,ifNotFound
      syscall
      
      jr $ra
