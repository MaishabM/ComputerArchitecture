.data
    array: .space 400
    inp: .asciiz "Enter number of elements: "
    elmnt: .asciiz "Enter the element: "
    out: .asciiz "Element Frequency\n"
    space: .asciiz "        "
    newline: .asciiz "\n"
.text
main:
    li $v0,4
    la $a0,inp
    syscall
    
    li $v0,5
    syscall
    move $s0,$v0   #n
    
    li $t0,0       # index i
    la $t1,array   #base pointer of array
InpLoop:
    li $v0,4
    la $a0,elmnt
    syscall
    
    li $v0,5
    syscall
    sw $v0,0($t1)
    
    addi $t0,$t0,1
    addi $t1,$t1,4
    blt $t0,$s0,InpLoop

    li $v0,4
    la $a0,out    #Output print
    syscall
    
    li $t0,0      #reset index i=0
    la $t1,array  #reset array base pointer $t1 
    
CountLoop:
    beq $s0,$t0,Exit
    
    lw $t2,0($t1) #$t2 = current element array[i]
    li $t3,1      #frequency counter $t3
    
    blt $t2,0,Skip
    addi $t4,$t0,1    #j = i+1

InnerLoop:
    beq $t4,$s0,Print
    
    mul $t5,$t4,4     #$t5 = j*4
    la $t6,array      #base of array[j]
    add $t6,$t6,$t5   #$t6 = base + offset (base+j*4)
    
    lw $t7,0($t6)     #array[j]
    beq $t7,$t2,Mark  #if array[i]=array[j],mark
    
Next:
    addi $t4,$t4,1   #increment j
    j InnerLoop
    
Mark:
    li $s1,-1
    sw $s1,0($t6)    #store -1 in array[j] if array[j]=array[i]
    addi $t3,$t3,1   #counter $t3++
    j Next
    
Print:
    li $v0,1
    move $a0,$t2
    syscall
    
    li $v0,4
    la $a0,space
    syscall
    
    li $v0,1
    move $a0,$t3
    syscall
    
    li $v0,4
    la $a0,newline
    syscall
    
Skip:
    addi $t0,$t0,1
    addi $t1,$t1,4
    j CountLoop
Exit:
    li $v0,10
    syscall