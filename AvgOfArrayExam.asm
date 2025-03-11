.data
   # .align 2               # Align the data for proper memory access
    array:      .space 400  # Allocate space for 100 floats (4 bytes each)
    zero:       .float 0.0
    input_msg:  .asciiz "Enter the number of elements: "
    num_msg:    .asciiz "Enter numbers:\n"
    avg_msg:    .asciiz "The average is: "
    newline:    .asciiz "\n"

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
    beq $t0, $s0, sum_loop  # If counter == N, stop input

    # Read float input
    li $v0, 6
    syscall

    # Store the input float in the array
    s.s $f0, 0($t1)  # Store input at array[t0]

    # Move to next element
    addi $t1, $t1, 4  # Increment address by 4 bytes
    addi $t0, $t0, 1  # Increment counter
    j input_loop

# Sum the elements in the array
sum_loop:
    li $t0, 0        # Reset loop counter
    la $t1, array    # Reset base address
    l.s $f2, zero    # sum = 0.0

sum_elements:
    beq $t0, $s0, compute_avg  # If counter == N, stop summing

    l.s $f1, 0($t1)  # Load array[t1] into $f1
    add.s $f2, $f2, $f1  # sum += array[t0]

    addi $t1, $t1, 4  # Move to next element
    addi $t0, $t0, 1  # Increment counter
    j sum_elements

compute_avg:
    # Convert N to float
    mtc1 $s0, $f1       # Move N into floating-point register
    cvt.s.w $f1, $f1    # Convert integer N to float

    # Compute average: sum / N
    div.s $f12, $f2, $f1  # f12 = sum / N

    # Print result message
    li $v0, 4
    la $a0, avg_msg
    syscall

    # Print average (float)
    li $v0, 2
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit program
    li $v0, 10
    syscall
