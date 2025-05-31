.data
    array: .space 400
    inp: .asciiz "Enter n (n x n): "
    column: .asciiz "Enter data of column: "
    out: .asciiz "The matrix:\n"
    space: .asciiz " "
    newline: .asciiz "\n"
.text
main:
    li $v0,4
    la $a0,inp
    syscall
    
    li $v0,5
    syscall
    move $s0,$v0    	# n
    
    li $t0,0        	# column = j = $t0
    
ColumnInput:
    beq $t0,$s0,Print
    
    li $v0,4
    la $a0,column
    syscall
    
    addi $s1,$t0,1
    li $v0,1
    move $a0,$s1
    syscall
    
    li $v0,4
    la $a0,newline
    syscall
    
    li $t1,0        	#row = i = $t1

RowInput:
    beq $t1,$s0,NextColumn
    
    li $v0,5
    syscall
    move $t2,$v0      	# the number in $t2
    
    #address = base + 4*(row*n + column)
    mul $t4,$t1,$s0
    add $t4,$t4,$t0
    mul $t4,$t4,4
    la $t5,array
    add $t5,$t5,$t4
    
    sw $t2,0($t5)
    
    addi $t1,$t1,1	#i++
    j RowInput
    
NextColumn:
    addi $t0,$t0,1   	#j++
    j ColumnInput

Print:
    li $v0,4
    la $a0,out
    syscall
    
    li $t1,0 		#i = 0
    
PrintRow:
    beq $t1,$s0,Exit
    
    li $t0,0 		#j=0

PrintColumn:
    beq $t0,$s0,NewLine
    
    #address = base + 4(row*n + column)
    mul $t4,$t1,$s0
    add $t5,$t0,$t4
    mul $t5,$t5,4
    la $t6,array
    add $t6,$t6,$t5
    
    lw $t7,0($t6)
    
    li $v0,1
    move $a0,$t7
    syscall
    
    li $v0,4
    la $a0,space
    syscall
    
    addi $t0,$t0,1	#j++/column++
    j PrintColumn
    
NewLine:
    li $v0,4
    la $a0,newline
    syscall
    
    addi $t1,$t1,1	#i++/row++
    j PrintRow

Exit:
    li $v0,10
    syscall
    

    