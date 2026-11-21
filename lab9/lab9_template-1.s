.global _start
_start:

	.equ LEDs,  	  0xFF200000
	.equ TIMER, 	  0xFF202000
	.equ PUSH_BUTTON, 0xFF200050
	.equ TOP_COUNT, 25000000

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
	
	la s0, LEDs
	la s1, COUNT
	LOOP:
		lw     s2, 0(s1)          # Get current count
		sw     s2, 0(s0)          # Store count in LEDs
	j      LOOP



interrupt_handler:
	# code not shown
mret

CONFIG_TIMER: 
	# code not shown
jr ra

CONFIG_KEYS: 
	#code not shown
jr ra

.data
/* Global variables */
.global  COUNT
COUNT:  .word    0x0            # used by timer
.global  RUN                    # used by pushbutton KEYs
RUN:    .word    0x1            # initial value to increment COUNT
.end
