vlog part2.v
vsim part2

log {/*}

add wave {/*}

force Clock 0 0, 1 10ms -r 20ms 
force Go 0 0, 1 50ms ,0 100ms , 1 150 ms, 0 200 ms, 1 250 ms, 0 300 ms, 1 350 ms, 0 400 ms, 1 450 ms, 0 500 ms, 1 550 ms, 0 600 ms, 1 1200 ms, 0 1250ms, 1 1300ms, 0 1350ms, 1 1400ms, 0 1450ms, 1 1500 ms, 0 1550ms, 1 1600ms, 0 1650ms, 1 1700ms, 0 1800ms,  1 1850ms, 0 1900ms, 1 2000ms, 0 2050ms, 1 2100ms, 0 2150ms, 1 2200ms
force Reset 1 0ms, 0 15ms, 1 1700ms, 0 1800 ms
force DataIn 4'd5 50ms, 4'd2 100ms,  4'd10 150ms,  4'd1 200 ms, 4'd3 550ms , 4'd2 590ms, 4'd4 720ms , 4'd1 800 ms, 4'd4 900ms, 4'd2 1100ms, 4'd1 1400ms,4'd5 1700ms, 4'd2 1800ms,  4'd10 1900ms,  4'd1 2000 ms

run 4000 ms

