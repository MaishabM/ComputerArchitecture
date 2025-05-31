.data
      array: .space 400
      inp: .asciiz "Enter how many elements: "
      arr: .asciiz "Enter the elements: "
      max: .asciiz "\nThe maximum is: "
      sp: .asciiz " "
.text
      li $v0,4
      la $a0,inp
      syscall
      
      li $v0,5
      syscall
      move $s0,$v0   # $s0=n
      
      li $t0,0       # $t0=i=0
      li $t2,0       # max=$t2=0
      la $t1,array   # base address of array=$t1
      
      li $v0,4
      la $a0,arr
      syscall
Loop:
      bge $t0,$s0,Print
      
      li $v0,5
      syscall
      sw $v0,0($t1)
      
      bgt $v0,$t2,Update
      addi $t1,$t1,4
      addi $t0,$t0,1
      j Loop

Update:
      move $t2,$v0
      addi $t1,$t1,4
      addi $t0,$t0,1
      j Loop

Print:
      li $t0,0
      la $t1,array
PLoop:      
      lw $t3,0($t1)
      
      li $v0,1
      move $a0,$t3
      syscall
      
      addi $t0,$t0,1
      addi $t1,$t1,4
      beq $t0,$s0,Maximum
      
      li $v0,4
      la $a0,sp
      syscall
      
      j PLoop
      
Maximum:
      li $v0,4
      la $a0,max
      syscall
      
      li $v0,1
      move $a0,$t2
      syscall
      
      li $v0,10
      syscall