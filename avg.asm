.data
zero: .float 0.0
input_msg:    .asciiz "Enter the number of elements:\n"
num_msg:      .asciiz "Enter numbers:\n"
avg_msg:      .asciiz "The average is: "
newline:      .asciiz "\n"

.text
main:
    # Prompt for N
    li $v0, 4
    la $a0, input_msg
    syscall

    # Read N (integer)
    li $v0, 5
    syscall
    move $s0, $v0   # Store N in $s0

    # Initialize sum = 0.0 and loop counter 0
    li $t0, 0       # Loop counter
    l.s $f2, zero   # Set $f2 = 0.0 (sum)

    # Prompt user for a number
    li $v0, 4
    la $a0, num_msg
    syscall
    
input_loop:
    beq $t0, $s0, compute_avg  # If counter == N, stop input

    # Read float input
    li $v0, 6
    syscall
    add.s $f2, $f2, $f0  # sum += input (f0)

    addi $t0, $t0, 1  # Increment counter
    j input_loop

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
