`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module part2(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;

    mux2to1 u0(
        .x(SW[0]),
        .y(SW[1]),
        .s(SW[9]),
        .m(LEDR[0])
        );
endmodule

module mux2to1(x,y,s,m);
input x,y,s;
output m;
//declaring wires
wire k1,k2,k3,k4;
v7404 U2(.pin3(s),.pin4(k1));
v7408 U1(.pin4(s),.pin5(y),.pin6(k3),.pin13(k1),.pin12(x),.pin11(k2));
v7432 U3(.pin4(k2),.pin5(k3),.pin6(m));
endmodule 

module v7404 (pin8, pin10, pin12,pin1, pin3, pin5, pin9, pin11,
pin13, pin2, pin4, pin6,);
input pin1,pin3,pin5,pin9,pin11, pin13; 
output pin2,pin4,pin6,pin8,pin10,pin12;
assign pin8 = !(pin9);
assign pin10 = !(pin11);
assign pin12 = !(pin13);
assign pin2 = !(pin1);
assign pin4 = !(pin3);
assign pin6 = !(pin5);
endmodule 

module v7408 (pin5, pin9, pin1, pin3, pin11,
pin13, pin2, pin4, pin6, pin10, pin8, pin12);
input pin9,pin10,pin12,pin13,pin1,pin2,pin4,pin5;
output pin8,pin11,pin3,pin6;
assign pin11 = (pin13 & pin12);
assign pin8 = (pin10 & pin9);
assign pin3 = (pin1 & pin2);
assign pin6 = (pin4 & pin5);

endmodule

module v7432 ( input pin1,pin2,pin4,pin5,pin9,pin10,pin12,pin13, 
output pin3,pin6,pin11,pin8);

assign pin11 = (pin13 || pin12);
assign pin8 = (pin10 || pin9);
assign pin3 = (pin1 || pin2);
assign pin6 = (pin4 || pin5);

endmodule // v7432

