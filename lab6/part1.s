.global _start
.text
_start:
	la s2, LIST
	addi s10, zero, 0 # s10 = sum
	addi s11, zero, 0 # s11 = count
	addi t0, zero, -1
	
LOOP:
	lw t1, 0(s2)
	beq t1, t0, END     # loop until end of list
	add s10, s10, t1     # add to sum
	addi s11, s11, 1     # increase count
	addi s2, s2, 4       # move to next word (add 4 to address s2)
	j LOOP 
END: j END
.global LIST
.data
LIST:
.word 1, 2, 3, 5, 0xA, -1