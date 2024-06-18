vlog part2.v
vsim part2

log {/*}

add wave {/*}



force {iClock} 0 0ps, 1 5ps -r 10ps 
force iResetn 0 0, 1'b1 10ps 
force iLoadX 0 0, 1'b1 10ps, 0 30ps, 1'b1 40ps, 0 50ps
force iXY_Coord 0 0, 4'd3 10ps, 4'd5 20ps, 4'd6 40ps
force iColour 0 0, 3'b010 15ps
force iPlotBox 0 0, 1'b1 40ps, 0 50ps
force iBlack 0 0, 1'b1 150ps




run 400ps