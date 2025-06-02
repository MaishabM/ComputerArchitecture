.data
    prompt:     .asciiz "Enter a number: "
    result_yes: .asciiz "It is an Armstrong number."
    result_no:  .asciiz "It is not an Armstrong number."
.text
main:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0      # $t0 = original number
    move $t1, $t0      # $t1 = copy for digit count

    # Count digits
    li $t2, 0          # $t2 = digit count

count_digits:
    beqz $t1, done_count
    
    li $t3, 10
    div $t1, $t3
    mflo $t1
    
    addi $t2, $t2, 1
    j count_digits

done_count:
    move $t1, $t0      # Reset $t1 to original number
    li $t4, 0          # $t4 = sum of powers

# Process each digit
process_digits:
    beqz $t1, check_result

    li $t5, 10
    div $t1, $t5
    mfhi $t6           # $t6 = digit
    mflo $t1           # reduce number

    # Compute digit^digit_count
    move $a0, $t6      # base = digit
    move $a1, $t2      # exponent = digit count
    jal power          # result in $v0

    add $t4, $t4, $v0  # add to sum
    j process_digits

# Compare sum with original
check_result:
    beq $t0, $t4, armstrong

    li $v0, 4
    la $a0, result_no
    syscall
    j exit

armstrong:
    li $v0, 4
    la $a0, result_yes
    syscall

exit:
    li $v0, 10
    syscall

power:
    li $v0, 1          # $v0 = result
    beqz $a1, power_ret  #base

power_loop:
    mul $v0, $v0, $a0
    addi $a1, $a1, -1
    bnez $a1, power_loop

power_ret:
    jr $ra