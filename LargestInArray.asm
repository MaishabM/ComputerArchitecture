.data
    array:       .space 400  # Space for 100 integers (4 bytes each)
    input_msg:   .asciiz "Enter the number of elements: "
    num_msg:     .asciiz "Enter numbers:\n"
    largest_msg: .asciiz "The largest number is: "
    newline:     .asciiz "\n"

.text
main:
    # Prompt for N
    li $v0, 4
    la $a0, input_msg
    syscall

    # Read N (integer)
    li $v0, 5
    syscall
    move $s0, $v0  # Store N in $s0

    # Initialize loop counter and base address for array
    li $t0, 0       # Loop counter
    la $t1, array   # Base address of array

    # Prompt user for numbers
    li $v0, 4
    la $a0, num_msg
    syscall

input_loop:
    beq $t0, $s0, find_largest  # If counter == N, stop input

    # Read integer input
    li $v0, 5
    syscall

    # Store the input integer in the array
    sw $v0, 0($t1)  # Store at array[t0]

    # Move to next element
    addi $t1, $t1, 4  # Move to the next integer
    addi $t0, $t0, 1  # Increment counter
    j input_loop

# Find the largest integer in the array
find_largest:
    li $t0, 0        # Reset loop counter
    la $t1, array    # Reset base address

    lw $t2, 0($t1)   # Assume the first element is the largest
    addi $t1, $t1, 4  # Move to the second element
    addi $t0, $t0, 1  # Increment counter

find_loop:
    beq $t0, $s0, print_largest  # If counter == N, stop searching

    lw $t3, 0($t1)  # Load array[t0] into $t3

    # Compare and update largest value if necessary
    ble $t3, $t2, skip_update  # If $t3 <= $t2, skip update

    move $t2, $t3  # Update largest number

skip_update:
    addi $t1, $t1, 4  # Move to next element
    addi $t0, $t0, 1  # Increment counter
    j find_loop

# Print the largest integer
print_largest:
    li $v0, 4
    la $a0, largest_msg
    syscall

    # Print the largest integer
    li $v0, 1
    move $a0, $t2  # Move largest value into $a0 for printing
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit program
    li $v0, 10
    syscall