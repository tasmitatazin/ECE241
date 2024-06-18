vlog part2.v
vsim part2

log {/*}

add wave {/*}



force {iClock} 0 0ps, 1 5ps -r 10ps 
force iResetn 0 0, 1'b1 10ps, 0 530ps , 1 550ps
force iLoadX 0 0, 1'b1 10ps, 0 30ps, 1'b1 40ps, 0 50ps, 1 370ps, 0 390ps 
force iXY_Coord 0 0, 4'd3 10ps, 4'd5 20ps, 4'd6 40ps, 4'd7 350ps, 4'd2 400ps
force iColour 0 0, 3'b010 15ps, 3'b100 400ps 
force iPlotBox 0 0, 1'b1 40ps, 0 50ps, 1 410ps, 0 430ps 
force iBlack 0 0, 1'b1 150ps , 0 200ps, 1 700ps, 0 720ps




run 1200ps

