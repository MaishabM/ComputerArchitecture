.data
myarray: .space 400  # Reserve space for 100 integers
space: .asciiz " "
input: .asciiz "Enter the size of the array:\n"
element_input: .asciiz "Enter array elements:\n"
prime_message: .asciiz "Prime numbers from the given array are:\n"

.text
main:
    # Prompt for array size
    li $v0, 4
    la $a0, input
    syscall
    
    # Read array size
    li $v0, 5
    syscall
    move $s0, $v0  # Store array size in $s0

    # Prompt for array elements
    li $v0, 4
    la $a0, element_input
    syscall

    # Read and store array elements
    li $t0, 0  # Loop index
input_loop:
    beq $t0, $s0, end_input  # If index == size, stop input
    li $v0, 5
    syscall
    sw $v0, myarray($t0)  # Store value in array
    addi $t0, $t0, 1
    j input_loop

end_input:
    # Print message for primes
    li $v0, 4
    la $a0, prime_message
    syscall

    # Check and print prime numbers
    li $t0, 0  # Reset index
check_prime_loop:
    beq $t0, $s0, end_check_prime
    lw $a0, myarray($t0)  # Load array element into $a0
    move $a1, $a0  # Store original value in $a1
    jal prime  # Call prime function
    addi $t0, $t0, 1
    j check_prime_loop

end_check_prime:
    # Exit program
    li $v0, 10
    syscall

# Prime checking function
prime:
    blt $a0, 2, not_prime  # If number < 2, not prime
    li $t1, 2  # Start divisor from 2

prime_loop:
    beq $t1, $a0, is_prime  # If divisor == number, it's prime
    div $a0, $t1
    mfhi $t2  # Get remainder
    beqz $t2, not_prime  # If remainder == 0, not prime
    addi $t1, $t1, 1  # Increment divisor
    j prime_loop

is_prime:
    # Print prime number
    li $v0, 1
    move $a0, $a1  # Print the original number
    syscall
    
    # Print a space
    li $v0, 4
    la $a0, space
    syscall
    jr $ra  # Return

not_prime:
    jr $ra  # Return without printing
