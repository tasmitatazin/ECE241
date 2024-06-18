vlib work 

vlog part2.v 

vsim control

log -r{/*} 

add wave {/*}

force {clk} 0 0ns, 1 {5ns} -r 10ns 

force reset 1
run 10ns 

force reset 0 
run 1000ns 

force go 1
run 1000ns 
force go 0
run 1000ns 

force go 1
run 1000ns 
force go 0
run 1000ns 


force go 1
run 1000ns 
force go 0
run 1000ns 


force go 1
run 1000ns 
force go 0
run 1000ns 



