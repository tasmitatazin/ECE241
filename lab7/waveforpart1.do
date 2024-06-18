vlog part1.v 
vsim -L altera_mf_ver part1

log {/*}

add wave {/*}

force clock 1 0, 0 10ms -r 20ms 
force address 0 0, 5'b0001 40ms, 5'b00010 80ms, 5'b00011 120ms, 5'b00000 200ms, 5'b00000 240ms, 5'b00001 280ms, 5'b00010 320ms, 5'b00011 360ms
force wren 1 0, 1 40ms, 1 80ms, 1 120ms, 0 200ms, 0 240ms, 0 280ms,0  320ms, 0 360ms
force data 0 0, 4'b0000 40ms, 4'b0100 80ms, 4'b1010 120ms, 4'b1100 200ms

run 500ms
