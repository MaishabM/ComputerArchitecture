.data
      inp1: .asciiz "Enter 1st float number: "
      inp2: .asciiz "Enter 2nd float number: "
      ad: .asciiz "The addition of two numbers: "
      mu: .asciiz "\nThe multiplication of two numbers: "
.text
main: 
      li $v0,4
      la $a0,inp1
      syscall
      
      li $v0,6
      syscall
      mov.s $f1,$f0     #Store input 1 in $f1 from $f0
      
      li $v0,4
      la $a0,inp2
      syscall
      
      li $v0,6
      syscall
      mov.s $f2,$f0      #Store input 2 in $f2 from $f0
      
      li $v0,4
      la $a0,ad
      syscall
      
      add.s $f12,$f1,$f2
      
      li $v0,2
      syscall            #Print addition result
      
      li $v0,4
      la $a0,mu
      syscall
      
      mul.s $f12,$f1,$f2
      
      li $v0,2
      syscall
      
      li $v0,10
      syscall