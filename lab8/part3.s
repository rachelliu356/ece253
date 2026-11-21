.global _start
_start:
	li s0, 0xFF200050 # address of KEYs
	li s1, 0xFF200000 # address of LEDRs
	li s3, 0xFF20005C # edgecapture
	li s7, 25000000 # Period
	li s8, 0xFF202000 # TIMER
	li s5, 255
	
	li t1, 0x0000FFFF # split period into lower and upper 16 bits
	srli t2, s7, 16
	and s7, s7, t1
	
	sw s7, 8(s8) # store period to memory map
	sw t2, 12(s8)
	
	addi t3, zero, 6 # update timer control register
	sw t3, 4(s8)
	
POLL: lw s2, 0(s0)
	beqz s2, POLL
WAIT: lw s4, 0(s0)
	bnez s4, WAIT
	lw s2, 0(s3)
	sw s2, 0(s3)

	j UPDATE_COUNT
	
TIMER: lw s6, 0(s8)
	andi s6, s6, 1
	lw s2, 0(s3)
	bnez s2, STOP
	beqz s6, TIMER
	sw zero, 0(s8)
	j UPDATE_COUNT
	
UPDATE_COUNT: lw t0, 0(s1)
	beq t0, s5, RESET
	addi t0, t0, 1
	sw t0, 0(s1)
	j TIMER
RESET: sw zero, 0(s1)
	j TIMER
STOP: lw s4, 0(s0)
	bnez s4, STOP
	lw s2, 0(s3)
	sw s2, 0(s3)
	j POLL
	