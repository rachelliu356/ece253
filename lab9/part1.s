.global _start
_start:

	.equ LEDs,  	  0xFF200000
	.equ TIMER, 	  0xFF202000
	.equ PUSH_BUTTON, 0xFF200050
	.equ TOP_COUNT, 25000000
	.equ MAX_COUNT, 255

	#Set up the stack pointer
	
	li sp, 0x20000
	
	jal    CONFIG_TIMER        # configure the Timer
    jal    CONFIG_KEYS         # configure the KEYs port
	
	/*Enable Interrupts in the NIOS V processor, and set up the address handling
	location to be the interrupt_handler subroutine*/
	
	# Your code goes below here:
	# Your code should:
	# Turn off interrupts in case an interrupt is called before correct set up
	# Activate interrupts from IRQ18 (Pushbuttons) and IRQ16 (Timer)
	# set IRQ on
	# set the mtvec register to be the interrupt_handler location
	# Turn the interrupts back on
	
	csrw mstatus, zero # turn off interrupts while setting up
	li t0, 0b1010000000000000000 # enable interrupts timer (IRQ16 and IRQ18)
	csrw mie, t0
	la t0, interrupt_handler
	csrw mtvec, t0 # set mtvec to address of interrupt handler
	li t0, 0b1000
	csrw mstatus, t0 # set mie bit in mstatus to 1 to enable interrupts
	
	la s0, LEDs
	la s1, COUNT
	LOOP:
		lw     s2, 0(s1)          # Get current count
		sw     s2, 0(s0)          # Store count in LEDs
	j      LOOP



interrupt_handler:
	# save s0 and s1 values to stack
	addi sp, sp, -12
	sw s0, 0(sp)
	sw s1, 4(sp)
	sw s2, 8(sp)
	
	# check if timer caused interrupt
	csrr s0, mcause
	li s1, 0x80000010
	bne s1, s0, KEY_PRESS # if timer did not cause interrupt, assume key press caused
	
	# check RUN
	la s0, RUN
	lw s1, 0(s0)
	li s2, 1
	bne s1, s2, return
	
	la s0, COUNT
	lw s1, 0(s0)
	li s2, MAX_COUNT
	beq s1, s2, RESET # check if reached 255
	addi s1, s1, 1 # increment counter
	sw s1, 0(s0) # store updated count to COUNT
	li s0, TIMER
	sw zero, 0(s0) # clear interrupt, write zero to status register of TIMER
	j return
	
RESET: la s0, COUNT
	li s1, 0
	sw s1, 0(s0)
	j return
	
KEY_PRESS: 
	#li s1, PUSH_BUTTON
	la s0, RUN
	lw s1, 0(s0)
	xori s1, s1, 1 # toggle RUN
	sw s1, 0(s0) # store updated run to RUN
	
	li s1, PUSH_BUTTON
	li s0, 0b1111
	sw s0, 12(s1) # clear edgecapture
	
return: 
	# restore s0 and s1 from stack
	lw s0, 0(sp)
	lw s1, 4(sp)
	lw s2, 8(sp)
	addi sp, sp, 12
	mret

CONFIG_TIMER: 
	li t1, TIMER
	la t4, PERIOD
	lw t0, 0(t4)
	li t2, 0x0000FFFF
	srli t3, t0, 16
	and t0, t0, t2
	sw t0, 8(t1)
	sw t3, 12(t1)
	li t0, 0b111 # start, cont, interrupts
	sw t0, 4(t1)
	jr ra

CONFIG_KEYS: 
	li t0, 0b1111
	li t1, PUSH_BUTTON
	sw t0, 8(t1)
	sw t0, 12(t1)
	jr ra

.data
/* Global variables */
.global  COUNT
COUNT:  .word    0x0            # used by timer
.global  RUN                    # used by pushbutton KEYs
RUN:    .word    0x1            # initial value to increment COUNT
.global PERIOD
PERIOD:	.word 25000000
.end
