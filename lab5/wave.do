vlib work 
vlog part1.sv
vsim part1

log {/*}
add wave {/*}

#clock signal
force Clock 0, 1 1ns -r 2ns
force Reset 1
run 2ns
force Reset 0
force w 1
run 16ns
force w 0
run 10 ns