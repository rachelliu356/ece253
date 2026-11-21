# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part2.sv

#load simulation using mux as the top level simulation module
vsim part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

#force -deposit {ClockIn} 0 0ns, 1 {5ns} -repeat 10ns
force -deposit {ClockIn} 0 0ns, 1 {50000000ns} -repeat 100000000ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force Speed {00}
force Reset {1}
run 100000000ns
force Reset {0}
run 19500000000ns
force Speed {01}
run 20000000000ns