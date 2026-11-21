# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in part2.sv to working dir
# could also have multiple verilog files
vlog part3.sv

#load simulation using part2 as the top level simulation module
vsim mux7to1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

#default set all to 0
force {MuxSelect} 000
force {MuxIn} 0000001
run 10ns

# first test case
force {MuxSelect} 001
force {MuxIn} 0000010
run 10ns

# second test case
force {MuxSelect} 010
force {MuxIn} 0000100
run 10ns

# third test case
force {MuxSelect} 011
force {MuxIn} 0001000
run 10ns

# fourth test case
force {MuxSelect} 100
force {MuxIn} 0010000
run 10ns

# fifth test case
force {MuxSelect} 101
force {MuxIn} 0100000
run 10ns

# sixth test case
force {MuxSelect} 110
force {MuxIn} 1000000
run 10ns

# seventh test case
force {MuxSelect} 111
force {MuxIn} 1111111
run 10ns