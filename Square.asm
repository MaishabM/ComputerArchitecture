.data
     # A program that has 'jal' must have 'jr $ra'
     #(Jump And Link) and (Jump Register, Return Address)
     msg: .asciiz "Enter any number: "
     result: .asciiz "Square of any number is: "
.text
main:
     la $a0,msg
     li $v0,4
     syscall
     
     li $v0,5
     syscall
     move  $t0,$v0
     
     jal square   #Jump and link to square function
     
     li $v0,10
     syscall
     
square:
     mul $t1,$t0,$t0
     
     li $v0,4
     la $a0,result
     syscall
     
     li $v0,1
     move $a0,$t1
     syscall
     
     jr $ra  #Goes to the next line of function call