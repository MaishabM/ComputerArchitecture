.data
prompt: .asciiz "Enter 3 integers, one at a time:\n"
result_prompt: .asciiz "The largest number is: "
.text
main:
    # Display prompt for user input
    li      $v0, 4               # System call code for print_str
    la      $a0, prompt          # Load the address of the prompt string
    syscall

    # Initialize variables
    li      $t0, 3              # Number of integers to input
    li      $t1, 0               # Loop counter
    li      $t2, 0               # Variable to store the largest number

input_loop:
    # Ask the user to input an integer
    li      $v0, 5               # System call code for read_int
    syscall
    move    $t3, $v0             # Store the entered integer in $t3

# Compare the entered integer with the current maximu    

bge     $t3, $t2, update_max # If $t3 >= $t2, update the maximum

# If $t3 < $t2, continue to the next iteration
    j       next_iteration

update_max:
    # Update the maximum with the entered integer
    move    $t2, $t3

next_iteration:
    addi    $t1, $t1, 1           # Increment the loop counter
    bne     $t1, $t0, input_loop  # If loop counter is not equal to 10, repeat the loop

    # Display the result
    li      $v0, 4                 # System call code for print_str
    la      $a0, result_prompt     # Load the address of the result_prompt string
    syscall

    li      $v0, 1                 # System call code for print_int
    move    $a0, $t2               # Load the value to print into $a0
    syscall

    # Exit the program
    li      $v0, 10                # System call code for program exit
    syscall