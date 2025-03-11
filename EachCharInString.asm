.data
     string: .space 40
     inp: .asciiz "Enter a string (of 40 characters max): "
     out: .asciiz "The characters are: \n"
     sp: .asciiz " "
.text
main:
     li $v0,4
     la $a0,inp
     syscall
     
     li $v0,8
     la $a0,string
     li $a1,40        #Maximum length of string (Mandatory)
     syscall
     
     li $v0,4
     la $a0,out
     syscall
     
     la $t0,string
Loop:
     lb $t1,0($t0)
     beqz $t1,Exit
     
     li $v0,11
     move $a0,$t1
     syscall
     
     li $v0,4
     la $a0,sp
     syscall
     
     addi $t0,$t0,1
     j Loop
     
Exit:
     li $v0,10
     syscall
     