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

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {a[0]} 0
force {a[1]} 0
force {a[2]} 0
force {a[3]} 0
force {b} 0000
force {c_in} 0
#run simulation for a few ns
run 10ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {a} 0001
force {b} 0000
force {c_in} 0
#run simulation for a few ns
run 10ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {a} 0010
force {b} 0000
force {c_in} 0
#run simulation for a few ns
run 10ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {a} 0010
force {b} 0001
force {c_in} 0
#run simulation for a few ns
run 10ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {a} 0010
force {b} 0010
force {c_in} 0
#run simulation for a few ns
run 10ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {a} 0010
force {b} 0011
force {c_in} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {a} 0010
force {b} 0100
force {c_in} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {a} 0101
force {b} 0010
force {c_in} 0
#run simulation for a few ns
run 10ns

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {a} 0101
force {b} 0011
force {c_in} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {a} 1000
force {b} 0001
force {c_in} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {a} 0111
force {b} 0011
force {c_in} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {a} 0101
force {b} 0110
force {c_in} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {a} 0011
force {b} 1001
force {c_in} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {a} 1100
force {b} 0001
force {c_in} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {a} 0011
force {b} 1011
force {c_in} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {a} 0100
force {b} 1011
force {c_in} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {a} 0101
force {b} 1011
force {c_in} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {a} 0110
force {b} 1011
force {c_in} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {a} 0110
force {b} 1100
force {c_in} 0
#run simulation for a few ns
run 10ns

#set input values using the force command, signal names need to be in {} brackets
force {a} 1111
force {b} 1111
force {c_in} 0
#run simulation for a few ns
run 10ns