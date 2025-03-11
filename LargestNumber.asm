.data
     message:.asciiz "Enter 3 integers: \n"
     result:.asciiz "The result is: "
.text     
main:
     #print entry message
     li $v0,4
     la $a0,message
     syscall
     
     #initialize 
     li $t0,3   #maximum array length
     li $t1,0   #set index i=0
     li $t2,0   #store the largest number in t2
     
     #enter 3 numbers
     
inside_loop:
     #take an input
     li $v0,5
     syscall
     move $t3,$v0
     
     #compare with the maximum value in $t2
     bge $t3,$t2,update
     j next
     
update:
     move $t2,$t3
     j next
     
next:
     addi $t1,$t1,1
     bne $t1,$t0,inside_loop
     
     #print the largest number
     li $v0,4
     la $a0,result
     syscall
     
     li $v0,1
     move $a0,$t2
     syscall
     
     #exit
     li $v0,10
     syscall
     