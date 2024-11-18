.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

    li t0, 0            
    li t1, 0  
    li t3, 0 
    li t4, 0 

loop_start:#t0:ans,t1:index,t2:memory_index,t3:first_array_offset,t4:second_array_offset,t5:first_num:t6:second_num
    bge t1, a2, loop_end
    slli t2, t3, 2      
    add t2, a0, t2
    lw t5, 0(t2)
    slli t2, t4, 2
    add t2,a1,t2       
    lw t6,0(t2)
    mul t2,t5,t6
    add t0,t0,t2  
    addi t1,t1,1
    add t3,t3,a3
    add t4,t4,a4
    j loop_start       

loop_end:
    mv a0, t0
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit
