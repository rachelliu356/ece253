# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog part1.sv

#load simulation using mux as the top level simulation module
vsim part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force -deposit {clock} 0 0ns, 1 {5ns} -repeat 10ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force reset {1}
run 10ns
force reset {0}
force Data_IN {1001}
force ParallelLoadn {0}
run 5ns
force ParallelLoadn {1}
force RotateRight {1}
force ASRight {0}
run 10ns
force ASRight {1}
run 10ns
force ASRight {0}
run 20ns
force RotateRight {0}
run 20ns