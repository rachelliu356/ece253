# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part2.sv

#load simulation using mux as the top level simulation module
vsim DisplayCounter

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force -deposit {Clock} 0 0ns, 1 {5ns} -repeat 10ns
force -deposit {EnableDC} 1 0ns, 0 {10ns} -repeat 20ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force Reset {1}
run 10ns
force Reset {0}
run 400ns
force Reset {1}
run 10ns
force Reset {0}
run 200ns
