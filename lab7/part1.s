# Program that counts consecutive 1’s.
.global _start
.text

_start:
	la a1, LIST
	addi s0, zero, -1
	addi s10, zero, 0 # Register to hold result
	# jal ONES
	
LOOP:
	lw a0, 0(a1)
	beq a0, s0, END     # loop until end of list
	jal ONES
	bge a0, s10, UPDATE
	j AFTER_UPDATE
	
UPDATE: mv s10, a0

AFTER_UPDATE:
	addi a1, a1, 4       # move to next word (add 4 to address a1)
	j LOOP 

# subroutine
# a0 = output (number of 1s in longest)
# a0 = input (word to count 1s)
# a1 = address of input
ONES:
	#addi sp, sp, -4
	addi t0, zero, 0 # Register to hold temporary result of each iteration
LOOP_iter:
	beqz a0, END_iter
	srli a2, a0, 1
	and a0, a0, a2
	addi t0, t0, 1 # Increase temporary result
	j LOOP_iter
END_iter: 
	mv a0, t0
	jr ra
	
END: j END
	

.global LIST
.data
LIST:
.word 0x1fffffff, 0x12345678, -1, 0x7fffffff