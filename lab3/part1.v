module part1(a,b,c_in,s,c_out);

input [3:0] a,b;
input c_in;
output [3:0] s;
output [3:0] c_out;
wire c1,c2,c3,c4;

fulladder u0(.x(a[0]),.y(b[0]),.z(c_in),.p(s[0]),.cout(c1));
fulladder u1(.x(a[1]),.y(b[1]),.z(c1),.p(s[1]),.cout(c2));
fulladder u2(.x(a[2]),.y(b[2]),.z(c2),.p(s[2]),.cout(c3));
fulladder u3(.x(a[3]),.y(b[3]),.z(c3),.p(s[3]),.cout(c4));

assign c_out={c4,c3,c2,c1};

endmodule


module fulladder (x,y,z,p,cout);
input x,y,z;
output p,cout;
assign p=z^x^y;
assign cout=(x&y)||(z&x)||(z&y);
endmodule


/*module toplevelpart1(SW,LEDR);
input [8:0] SW; //declaring all switches or specified switches both works 
output [9:0] LEDR;
part2 p1(
       .a(SW[7:4]),
       .b(SW[3:0]),
       .c_in(SW[8]),
       .c_out(LEDR[9:6]),
       .s(LEDR[3:0]));
endmodule*/




