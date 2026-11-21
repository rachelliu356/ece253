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

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {A} 0001
force {B} 0001
force {Function} 00
#run simulation for a few ns
run 10ns

# second test case
#set input values using the force command, signal names need to be in {} brackets
force {A} 0001
force {B} 0001
force {Function} 01
#run simulation for a few ns
run 10ns

# third test case
#set input values using the force command, signal names need to be in {} brackets
force {A} 0001
force {B} 0001
force {Function} 10
#run simulation for a few ns
run 10ns

# fourth test case
#set input values using the force command, signal names need to be in {} brackets
force {A} 0001
force {B} 0001
force {Function} 11
#run simulation for a few ns
run 10ns