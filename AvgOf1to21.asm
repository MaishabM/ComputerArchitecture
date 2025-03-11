.data
     message:.asciiz "The sum of the series is: "
     avg:.asciiz "\nThe average of the series is: "
.text
main:
     #initialiazation
     li $t0,1  #the series is initialized to 1
     li $t1,0  #sum is initialized to 0
     li $t2,0  #index initialized to 0. total index 11
     
loop:
     add $t1,$t1,$t0 #increment sum
     addi $t0,$t0,2  #increment series number 
     addi $t2,$t2,1  #increment index
     
     beq $t2,11,print_sum
     j loop
     
print_sum:
     #print sum message
     li $v0,4
     la $a0,message
     syscall
     
     #calculate average
     li $t3,11
     div $t1,$t3
     mflo $t4
     
     #output the sum
     li $v0,1
     move $a0,$t1
     syscall
     
     #printing average message
     li $v0,4
     la $a0,avg
     syscall
     
     #output the average
     li $v0,1
     move $a0,$t4
     syscall
     
     #exit
     li $v0,10
     syscall
