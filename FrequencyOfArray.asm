.data
    prompt_size: .asciiz "Enter array size: "
    prompt_element: .asciiz "Enter element: "
    result_msg: .asciiz "Element-Frequency\n"
    space: .asciiz " "
    newline: .asciiz "\n"
    array: .space 400  # Space for array (max 100 elements)

.text
.globl main

main:
    # Prompt for array size
    li $v0, 4
    la $a0, prompt_size
    syscall

    # Read array size
    li $v0, 5
    syscall
    move $t0, $v0  # Store size in $t0

    # Read array elements
    li $t1, 0  # i = 0
read_array:
    # Prompt for element
    li $v0, 4
    la $a0, prompt_element
    syscall

    # Read element
    li $v0, 5
    syscall

    # Store in array
    la $t2, array         # Base address
    mul $t3, $t1, 4       # Offset = i * 4
    add $t2, $t2, $t3
    sw $v0, 0($t2)        # Store element

    addi $t1, $t1, 1      # i++
    blt $t1, $t0, read_array  # If i < n, repeat

    # Print header
    li $v0, 4
    la $a0, result_msg
    syscall

    # Count frequencies
    li $t1, 0  # i = 0 (outer loop)
count_freq:
    beq $t1, $t0, exit  # If i == size, exit

    # Load array[i]
    la $t2, array
    mul $t3, $t1, 4
    add $t2, $t2, $t3
    lw $t4, 0($t2)  # $t4 = array[i]

    li $t5, 1  # Frequency counter

    # Check if element is already counted (-1 means counted)
    blt $t4, 0, next_element

    # Inner loop to count occurrences of array[i]
    move $t6, $t1  # Copy i to j (inner loop index)
count_inner:
    addi $t6, $t6, 1
    beq $t6, $t0, print_result  # If j == size, print count

    la $t7, array
    mul $t8, $t6, 4
    add $t7, $t7, $t8
    lw $t9, 0($t7)  # Load array[j]

    bne $t9, $t4, count_inner  # If array[j] != array[i], continue

    addi $t5, $t5, 1  # Increase count

    li $s0, -1       # Store -1 in $s0 (fix for invalid operand issue)
    sw $s0, 0($t7)   # Mark counted element as -1

    j count_inner

print_result:
    # Print element
    li $v0, 1
    move $a0, $t4
    syscall

    # Print space
    li $v0, 4
    la $a0, space
    syscall

    # Print frequency
    li $v0, 1
    move $a0, $t5
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

next_element:
    addi $t1, $t1, 1
    j count_freq

exit:
    li $v0, 10
    syscall
