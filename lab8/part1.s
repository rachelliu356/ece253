.global _start
_start:
	li s0, 0xFF200050 # address of KEYs
	li s1, 0xFF200000 # address of LEDRs
POLL: lw s2, 0(s0)
	beqz s2, POLL
WAIT: lw s3, 0(s0)
	bnez s3, WAIT
	li s3, 0b0001
	bne s2, s3, CHECK_1
	li s4, 1
	sw s4, 0(s1)
	j POLL
CHECK_1: li s3, 0b0010
	bne s2, s3, CHECK_2
	li s5, 15
	lw s4, 0(s1)
	beq s4, s5, POLL
	addi s4, s4, 1
	sw s4, 0(s1)
	j POLL
CHECK_2: li s3, 0b0100
	bne s2, s3, CHECK_3
	li s5, 1
	lw s4, 0(s1)
	beq s4, s5, POLL
	addi s4, s4, -1
	sw s4, 0(s1)
	j POLL
CHECK_3: sw zero, 0(s1)
	j RESET_1
RESET_1: lw s2, 0(s0)
	beqz s2, RESET_1
WAIT_2: lw s3, 0(s0)
	bnez s3, WAIT_2
	li s4, 1
	sw s4, 0(s1)
	j POLL
	