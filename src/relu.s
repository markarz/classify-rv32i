.globl relu

.text
# ==============================================================================
# FUNCTION: Array ReLU Activation
#
# Applies ReLU (Rectified Linear Unit) operation in-place:
# For each element x in array: x = max(0, x)
#
# Arguments:
#   a0: Pointer to integer array to be modified
#   a1: Number of elements in array
#
# Returns:
#   None - Original array is modified directly
#
# Validation:
#   Requires non-empty array (length ≥ 1)
#   Terminates (code 36) if validation fails
#
# Example:
#   Input:  [-2, 0, 3, -1, 5]
#   Result: [ 0, 0, 3,  0, 5]
# ==============================================================================
relu:
    li t0, 1              # t0 = 1
    blt a1, t0, error     # If a1 <= 0 (invalid size), jump to error

    li t1, 0              # t1 = 0 (loop index)
    addi t4, a0, 0        # t4 = base address of nums (copy a0)

loop_start:
    beq t1, a1, loop_end  # If t1 == a1, exit the loop (i >= size)

    slli t2, t1, 2        # t2 = t1 * 4 (calculate byte offset)
    add t3, t4, t2        # t3 = base address + offset (address of nums[i])
    lw t5, 0(t3)          # t5 = nums[i]

    blt zero, t5, skip    # If nums[i] < 0, skip (no modification)
    sw zero, 0(t3)        # Set nums[i] = 0
    addi t1, t1, 1        # Increment index (t1++)
    j loop_start  

skip:
    addi t1, t1, 1        # Increment index (t1++)
    j loop_start          # Jump to next iteration

loop_end:
    ret                   # Return to caller

error:
    li a0, 36             # Set error code 36
    j exit                # Jump to exit




    
