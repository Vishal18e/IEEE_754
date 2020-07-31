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

//24 bit register for Quotient and Dividend
//23th bit contains normalized bit. 22:0 contains mantissa
//inputs are clock(clk) , load (ld), loadinput(in), serialload(sld),  serialinput(sin) while output is out

module registerQ(clk,ld,in,sld,sin,out);

parameter size=24;

input clk,ld,sld,sin;
input [size-1:0] in;
output reg [size-1:0] out;

always @ (posedge clk)
begin
if(ld)	//if ld is high, loads the register
out<=in;
//...
else if(sld)	//if sld is high, shifts the contents left and inserts the serial input
out<={out[size-2:0],sin};
//...
end

endmodule
/*
module registerQ_testbench;

parameter size=24;

reg clk,ld,sld,sin;
reg [size-1:0] in;
wire [size-1:0] out;

registerQ R1(clk,ld,in,sld,sin,out);

initial
begin
clk=0;

forever
#5 clk=~clk;
end

initial
begin
#10 ld=1; in=4156;
#10 ld=0;sld=1;sin=0;
#50 sld=0;
end
endmodule
*/