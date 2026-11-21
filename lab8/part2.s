.global _start
_start:
	li s0, 0xFF200050 # address of KEYs
	li s1, 0xFF200000 # address of LEDRs
	li s3, 0xFF20005C # edgecapture
	li s5, 255
POLL: lw s2, 0(s0)
	beqz s2, POLL
WAIT: lw s4, 0(s0)
	bnez s4, WAIT
	lw s2, 0(s3)
	sw s2, 0(s3)

	j UPDATE_COUNT
	
DELAY: li s6, 500000
LOOP: addi s6, s6, -1
	lw s2, 0(s3)
	bnez s2, STOP
	bnez s6, LOOP
	j UPDATE_COUNT
	
UPDATE_COUNT: lw t0, 0(s1)
	beq t0, s5, RESET
	addi t0, t0, 1
	sw t0, 0(s1)
	j DELAY
RESET: sw zero, 0(s1)
	j DELAY
STOP: lw s4, 0(s0)
	bnez s4, STOP
	lw s2, 0(s3)
	sw s2, 0(s3)
	j POLL

	
