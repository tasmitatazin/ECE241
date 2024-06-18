vlog part2.v
vsim part2

log {/*}

add wave {/*}

force Clock 0 0, 1 10ms -r 20ms 
force Go 0 0, 1 50ms -r 100ms 
force Reset 1 0, 0 15ms, 1 1200ms, 0 1250 ms
force DataIn 4'd5 50ms, 4'd2 100ms,  4'd10 150ms,  4'd1 200 ms, 4'd3 550ms , 4'd2 590ms, 4'd4 720ms , 4'd1 800 ms

run 4000 ms

