vlog part1.v
vsim part1

log {/*}

add wave {/*}

force Clock 0 0, 1 50ms -r 100ms 
force Reset 1 0, 0 90ms, 1 1800ms, 0 1900ms 


force {w} 1'b0 75ms

force {w} 1'b1 120ms

force {w} 1'b0 660ms

force {w} 1'b0 800ms

force {w} 1'b1 900ms

force {w} 1'b1 1000ms

force {w} 1'b0 1100ms

force {w} 1'b1 1200ms

force {w} 1'b1 1300ms


run 4000 ms

