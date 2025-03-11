.data
      array: .space 20
      inp: .asciiz "Enter the number to be searched: "
      prompt: .asciiz "Enter 5 array elements: \n"
      out: .asciiz "The number is in index: "
      NotExist: .asciiz "The number does not exist in array"
.text
main:      
      li $v0,4
      la $a0,prompt
      syscall
      
      li $t1,0      #Index i=0
ArrayLoop:
      li $v0,5
      syscall
      
      la $t2,array
      mul $t3,$t1,4    #Increment address by 4 byte
      add $t2,$t2,$t3
      sw $v0,0($t2)
      
      addi $t1,$t1,1    #index i++
      blt $t1,5, ArrayLoop
      
      #Enter the number to be searched
      li $v0,4
      la $a0,inp
      syscall
      
      li $v0,5
      syscall
      move $t0,$v0
      
      li $t1,1       #Reset array index to 0
      la $t2,array    #reset array address at 0th
Find:
      beq $t1,5,not_found
      
      lw $t3,0($t2)
      beq $t3,$t0,found
      
      addi $t1,$t1,1
      addi $t2,$t2,4
      j Find
found:
      li $v0,4
      la $a0,out
      syscall
      
      li $v0,1
      move $a0,$t1
      syscall
      j exit
not_found:
      li $v0,4
      la $a0,NotExist
      syscall
      
exit:
      li $v0,10
      syscall
      