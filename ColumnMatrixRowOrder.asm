.data
    matrix: .space 400       # Allocate space for matrix (max 10x10)
    prompt: .asciiz "Enter matrix size (n x n): "
    promptElement: .asciiz "Enter element: "
    newline: .asciiz "\n"
    space: .asciiz " "

.text
.globl main

main:
    # Prompt and read matrix size (n)
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0          # Store n in $t0
    move $s0,$t0           #Copy n to $s0

    # Read matrix in column-major order
    li $t1, 0              # Index in 1D array
    mul $s0,$s0,$s0        #Number of inputs will be n*n

read_matrix:
    li $v0, 4
    la $a0, promptElement
    syscall

    li $v0, 5
    syscall

    la $t2, matrix         # Base address
    mul $t3, $t1, 4        # Compute offset (index * 4)
    add $t2, $t2, $t3      # Increment 4 byte to base address $t2
    sw $v0, 0($t2)         # Store element

    addi $t1, $t1, 1       # Move to next index
    blt $t1, $s0, read_matrix  # Repeat until all elements are read

    # Print matrix in row-major order
    li $t1, 0              # Reset index

print_matrix:
    la $t2, matrix         #Base address of matrix
    mul $t3, $t1, 4        #Compute offset (index*4)
    add $t2, $t2, $t3      #Increment address of base address of matrix
    lw $a0, 0($t2)

    li $v0, 1
    syscall

    # Print space or newline
    addi $t4, $t1, 1    #Increment the index by for 1 based index
    rem $t4, $t4, $t0   # Check the reminder
    beqz $t4, print_newline  #If 0, then go to newLine

    li $v0, 4
    la $a0, space
    syscall
    j continue_print

print_newline:
    li $v0, 4
    la $a0, newline
    syscall

continue_print:
    addi $t1, $t1, 1
    blt $t1, $s0, print_matrix  # Loop until all elements are printed

    # Exit program
    li $v0, 10
    syscall
