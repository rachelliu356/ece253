# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in part2.sv to working dir
# could also have multiple verilog files
vlog part2.sv

#load simulation using part2 as the top level simulation module
vsim mux2to1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

#default set all to 0
force {s} 0
force {x} 0
force {y} 0
run 10ns

# first test case
force {s} 0
force {x} 0
force {y} 1
run 10ns

# second test case
force {s} 0
force {x} 1
force {y} 0
run 10ns

# third test case
force {s} 0
force {x} 1
force {y} 1
run 10ns

# fourth test case
force {s} 1
force {x} 0
force {y} 0
run 10ns

# fifth test case
force {s} 1
force {x} 0
force {y} 1
run 10ns

# sixth test case
force {s} 1
force {x} 1
force {y} 0
run 10ns

# seventh test case
force {s} 1
force {x} 1
force {y} 1
run 10ns

