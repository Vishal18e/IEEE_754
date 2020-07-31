`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2019 15:12:17
// Design Name: 
// Module Name: entry
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module floatdivision(A,B,Quo);

input [31:0] A,B;	// A is dividend and B is divisor
output reg [31:0] Quo;	//Quo is Quotient 

reg clk,res;	//internal clock and reset
reg[23:0] mantA,mantB;	//mantA and mantB are mantissa of A and B respectively with leading 1
wire[23:0] result;		//result is result of division of mantA and mantB

resdivision R(.clk(clk),.res(res),.divisor(mantB),.dividen(mantA),.quotient(result));

initial
begin
clk=0;

forever
#1 clk=~clk;
end
// Takes approximately 300 ps for 1ps/1ps time

always @(*)
begin
mantA={1'b1,A[22:0]};
mantB={1'b1,B[22:0]};
end

always @(A or B)
begin
res=1;
#3 res=0;
end

always @(*)
begin
if(result[23])
Quo={A[31]^B[31],A[30:23]-B[30:23]+8'h7F,result[22:0]};
else
Quo={A[31]^B[31],A[30:23]-B[30:23]+8'h7E,result[21:0],1'b0};
end
endmodule
/*
module floatdivision_testbench;

reg [31:0] A,B;
wire [31:0] Quo;

floatdivision flt(A,B,Quo);

initial
begin

B=32'h43918000;
A=32'h428ca000;
#400 B=32'hc3910000;
end
endmodule
*/