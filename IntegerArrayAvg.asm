.data
      array: .space 80    #max 20 elements
      inp: .asciiz "Enter number of input: "
      sum: .asciiz "Sum of the numbers: "
      avg: .asciiz "Average of the numbers: "
      element: .asciiz "Enter the array elements: \n"
      newline: .asciiz "\n"
.text
main: 
      li $v0,4
      la $a0,inp
      syscall
      
      li $v0,5
      syscall
      move $t0,$v0      # $t0 = n
      
      li $v0,4
      la $a0,element
      syscall
      
      la $t1,array      # load base address of array
      li $t2,0          # i=0
      li $t4,0          #sum = 0 initialization
      
   Loop:
         beq $t2,$t0,Print  #If i==n, print
         
         li $v0,5
         syscall
         move $t3,$v0   # $t3 takes array input array[i]
         
         sw $t3,0($t1)
         add $t4,$t3,$t4  # sum = sum + array[i]
         
         addi $t1,$t1,4 #Updating array address
         addi $t2,$t2,1
         j Loop
         
     Print:
         li $v0,4
         la $a0,sum
         syscall
         
         li $v0,1
         move $a0,$t4   #Print the sum
         syscall
         
         li $v0,4
         la $a0,newline
         syscall
         
         li $v0,4
         la $a0,avg
         syscall
         
         div $t5,$t4,$t0
         
         li $v0,1
         move $a0,$t5
         syscall
         
         li $v0,10
         syscall