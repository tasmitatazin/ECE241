vlog part2.v

vsim part2

log {/*}
add wave {/*}
force ClockIn 0 0, 1 {10ns} -r 20ns
force Reset 1 0ns, 0 20ns, -r 1000ns
force Speed 2'b00 0ns, 2'b01 100ns, 2'b10 320ns, 2b'11 510 ns-r 1000ns
run 1000ns 