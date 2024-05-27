module part2
#(parameter CLOCK_FREQUENCY=5)(

input Clockin,
input Reset, 
input [1:0] Speed,
output [3:0] CounterValue
);

wire connect;

RateDivider t1(.Speed(Speed),.ClockIn(Clockin),.Reset(Reset),.EnablePulses(connect));
DisplayCounter k1(.Enable(connect),.Q(CounterValue),.clock(Clockin));


endmodule

module DisplayCounter(Enable,Q,clock);

input Enable;
input clock;
output [3:0] Q;

always@(posedge clock)
begin 
if (Enable==1)
Q<=Q+1;
end 

endmodule


module RateDivider(Speed,ClockIn,Reset,EnablePulses);

input [1:0] Speed;
input ClockIn,Reset;
output [3:0] q;
output EnablePulses;
wire d;

LoadValues v1(.s1(Speed),.m(d));


always @(posedge ClockIn)
begin 
if (Reset==1) //active high
q<=0; //going at full speed
else if(q==0)
q<=d;
else 
q<=q-1;
end 

assign EnablePulses = (q == 0)?1:0;

endmodule 


module LoadValues
#(parameter CLOCK_FREQUENCY=5)(s1, m);

    input [1:0] s1; //select signal 1
    output [4:0] m; //output
  
    //assign m = s & y | ~s & x;
    // OR
    always@ (*)
	case(s1)
	2'b00: m= 0; //insert values here 
	2'b01: m= (CLOCK_FREQUENCY-1); //
	2'b10: m= (2*CLOCK_FREQUENCY-1);
	2'b11: m= (4*CLOCK_FREQUENCY-1);
endcase	

endmodule