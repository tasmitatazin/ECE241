


vlog newww.v
vsim part2

log {/*}

add wave {/*}



force {iClock} 0 0ps, 1 5ps -r 10ps 
force iResetn 0 0, 1'b1 10ps 
force iLoadX 0 0, 1'b1 10ps, 0 30ps , 1 263ps, 0 310ps 
force iXY_Coord 0 0, 4'd0 10ps, 4'd0 40ps , 4'd3 270ps, 4'd5 320ps
force iColour 0 0, 3'b001 15ps, 3'b010 320ps
force iPlotBox 0 0, 1'b1 40ps, 0  50ps, 1 315ps, 0 330ps 
force iBlack 0 0ps 



run 500ps






















