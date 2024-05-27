
module part3(A,B,Function,ALUout);

parameter N=10; 

input [N-1:0] A,B;
input [1:0] Function; //select signals 
output reg [(N*2)-1:0] ALUout; 

always@(*)
begin 
case(Function)
2'b00:ALUout=A+B; //full adder should be used here , used case0 function 
2'b01:ALUout=|{A,B}; //single reduction or operator 
2'b10:ALUout=&{A,B};
2'b11:ALUout={A,B};
default:ALUout='b0;
endcase
end


endmodule 




