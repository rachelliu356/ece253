# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part3.sv

#load simulation using mux as the top level simulation module
vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force -deposit {Clock} 0 0ns, 1 {5ns} -repeat 10ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {Data} 0010
force {Reset_b} 1
force {Function} 000
run 10ns
force {Reset_b} 0
run 10ns
force {Function} 001
run 10ns
force {Function} 010
run 10ns
force {Function} 001
run 10ns
force {Reset_b} 1
run 10ns