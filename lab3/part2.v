module toplevel(SW,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,KEY);
input [7:0] SW;
input [2:0] KEY;
output [7:0] LEDR;
output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;

part2 k1(
.A(SW[7:4]),
.B(SW[3:0]),
.Function(KEY[1:0]),
.ALUout(LEDR[7:0])
);


display4bit n1(
.c(SW[7:4]),
.s(HEX2));

display4bit n2(
.c(SW[3:0]),
.s(HEX0));

display4bit n3(
.c(LEDR[3:0]),
.s(HEX4));

display4bit n4(
.c(LEDR[7:4]),
.s(HEX5));


endmodule 




module part2(A,B,Function,ALUout);

input [3:0] A,B;
input [2:0] Function; //select signals 
output reg [7:0] ALUout; 
wire [4:0] adderout;

part1 b1(.a(A[3:0]),.b(B[3:0]),.c_in(1'b0),.s(adderout[3:0]),.c_out(adderout[4]));


always@(*)
begin 
case(Function)
3'b00:ALUout=adderout; //full adder should be used here , used case0 function 
3'b01:ALUout=|{A,B}; //single reduction or operator 
3'b10:ALUout=&{A,B};
3'b11:ALUout={A,B};
default:ALUout=8'b0;
endcase
end


endmodule 



module part1(a,b,c_in,s,c_out);

input [3:0] a,b;
input c_in;
output [3:0] s;
output c_out;
wire c1,c2,c3;

fulladder u0(.x(a[0]),.y(b[0]),.z(c_in),.p(s[0]),.cout(c1));
fulladder u1(.x(a[1]),.y(b[1]),.z(c1),.p(s[1]),.cout(c2));
fulladder u2(.x(a[2]),.y(b[2]),.z(c2),.p(s[2]),.cout(c3));
fulladder u3(.x(a[3]),.y(b[3]),.z(c3),.p(s[3]),.cout(c_out));


endmodule

module fulladder (x,y,z,p,cout);
input x,y,z;
output p,cout;
assign p=z^x^y;
assign cout=(x&y)||(z&x)||(z&y);
endmodule

module display4bit(c,s);
input [3:0] c;
output reg [6:0] s;
always @ (*) begin
case(c)
4'b0000:s=7'b0111111;
4'b0001:s=7'b0000110;
4'b0010:s=7'b1011011;
4'b0011:s=7'b1001111;
4'b0100:s=7'b1100110;
4'b0101:s=7'b1101101;
4'b0110:s=7'b1111101;
4'b0111:s=7'b0000111;
4'b1000:s=7'b1111111;
4'b1001:s=7'b1101111;
4'b1010:s=7'b1110111;
4'b1011:s=7'b1111100;
4'b1100:s=7'b0111001;
4'b1101:s=7'b1011110;
4'b1110:s=7'b1111001;
4'b1111:s=7'b1110001;
default: s=7'b0000000;
endcase
end
endmodule


