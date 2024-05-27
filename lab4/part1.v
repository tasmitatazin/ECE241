module part1(Clock,Enable,Reset,CounterValue);
input Clock,Enable,Reset;
output [7:0] CounterValue;
wire [6:0] g1;



Tflipflop f0(.Ts(Enable),.clocks(Clock),.resetns(Reset),.q(g1[0]),.cvalue(CounterValue[0]));
Tflipflop f1(.Ts(g1[0]),.clocks(Clock),.resetns(Reset),.q(g1[1]),.cvalue(CounterValue[1]));
Tflipflop f2(.Ts(g1[1]),.clocks(Clock),.resetns(Reset),.q(g1[2]),.cvalue(CounterValue[2]));
Tflipflop f3(.Ts(g1[2]),.clocks(Clock),.resetns(Reset),.q(g1[3]),.cvalue(CounterValue[3]));
Tflipflop f4(.Ts(g1[3]),.clocks(Clock),.resetns(Reset),.q(g1[4]),.cvalue(CounterValue[4]));
Tflipflop f5(.Ts(g1[4]),.clocks(Clock),.resetns(Reset),.q(g1[5]),.cvalue(CounterValue[5]));
Tflipflop f6(.Ts(g1[5]),.clocks(Clock),.resetns(Reset),.q(g1[6]),.cvalue(CounterValue[6]));
Tflipflop f7(.Ts(g1[6]),.clocks(Clock),.resetns(Reset),.cvalue(CounterValue[7]));

endmodule 



module Tflipflop(Ts,clocks,resetns,q,cvalue);
input Ts,clocks,resetns;
output q,cvalue;
wire r1;

wire p1;
assign p1=Ts^r1;

D_flipflop b1(.clock(clocks),.resetn(resetns),.Q(r1),.D(p1));


assign q= (Ts&r1);
assign cvalue=r1;

endmodule


module D_flipflop(clock,resetn,Q,D);
input clock,D,resetn;
output reg Q;


always @ (posedge clock) 
if (resetn==1)
Q<=0;
else 
Q<=D;


endmodule 


