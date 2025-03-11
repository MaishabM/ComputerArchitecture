.data
     array: .space 400  # Space for 100 floats (4 bytes each)
     sum: .float 0.0
     inp: .asciiz "Enter the number of elements: "
     element: .asciiz "Enter the elements: \n"
     summsg: .asciiz "Sum of the numbers is: "
     avg: .asciiz "\nAverage of the numbers is: "

.text
main:
     # Print: "Enter the number of elements: "
     li $v0, 4
     la $a0, inp
     syscall
     
     # Read n
     li $v0, 5
     syscall
     move $t0, $v0    # Store n in $t0
     
     li $v0, 4
     la $a0, element
     syscall
     
     # Load sum = 0.0 from memory
     la $t3, sum
     l.s $f4, 0($t3)  # Load sum into $f4 register

     la $t1, array    # Base address of array
     li $t2, 0        # i = 0

Loop: 
     beq $t2, $t0, Print     # if i == n,Print
     
     li $v0, 6
     syscall
     s.s $f0, 0($t1)      # Store float in array

     add.s $f4, $f4, $f0  # sum += array[i]

     # Increment index
     addi $t2, $t2, 1
     addi $t1, $t1, 4
     j Loop

Print: 
      mtc1 $t0, $f6     # Move $t0 to coprocessor 1 in float register
      cvt.s.w $f6, $f6  # Convert integer(word) to float

      li $v0, 4
      la $a0, summsg
      syscall

      li $v0, 2
      mov.s $f12, $f4  # Move sum to default print argument $f12
      syscall

      div.s $f12, $f4, $f6   # Avg= sum/n

      li $v0, 4
      la $a0, avg
      syscall

      li $v0, 2
      syscall  

      li $v0, 10
      syscall
