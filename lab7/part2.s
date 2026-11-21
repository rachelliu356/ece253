.global _start
.text
_start:
	la s0, LIST
	lw s1, 0(s0) # store length of LIST
	addi s1, s1, -1 # range is n-1 (for n = 5, list to sort is length 5 and don't include last item)
	addi t3, zero, 0 # store swapped
WHILE: 
	beqz s1, END_iter
	addi s0, s0, 4 # move to next word in LIST
	addi a0, s0, 0
	jal SWAP
	bnez a0, UPDATE_SWAPPED
	j AFTER

UPDATE_SWAPPED:
	mv t3, a0
	j AFTER
	
AFTER: 
	addi s1, s1, -1
	j WHILE
	
END_iter:
	beqz t3, END
	la s0, LIST # restore first address of LIST into a0
	lw s1, 0(s0) # restore length of LIST
	addi s1, s1, -1 # range is n-1 
	addi t3, zero, 0 # restore swapped
	j WHILE
	
# subroutine SWAP
# a0 = address of a list element
# a0 return 1 if swapped, 0 if not swapped

SWAP:
	lw t0, 0(a0)
	lw t1, 4(a0)
	bge t0, t1, UPDATE
	j NO_UPDATE

UPDATE: 
	sw t1, 0(a0)
	sw t0, 4(a0)
	addi a0, zero, 1
	jr ra
	
NO_UPDATE:
	addi a0, zero, 0
	jr ra
	
END: j END
	
.global LIST
.data
LIST:
.word 5, 5, 3, 4, 2, 1
	
	