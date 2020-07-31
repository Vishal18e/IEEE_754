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

//26 bit register for Dividend
//25th bit is for sign, 24th contains 0 initially,23rd bit contains normalized bit. 22:0 contains mantissa
//inputs are clock(clk) , load (ld), loadinput(in), serialload(sld), initialload(inild), serialinput(sin) while output is out

module registerB(clk,ld,in,inild,sld,sin,out);

parameter size=26;

input clk,ld,sld,sin;
input [size-1:0] in,inild;	//inild is initial value to be stored.
output reg [size-1:0] out;

always @ (posedge clk)
begin
if(ld)	//if ld is high, loads the register
out<=in;
//...
else if(sld)	//if sld is high, shifts the contents left and inserts the serial input
out<={out[size-3:0],sin};
//...
end

always@(inild)
out<=inild;

endmodule
/*
module registerB_testbench;

parameter size=26;

reg clk,ld,sld,sin;
reg [size-1:0] in,inild;
wire [size-1:0] out;

registerQ R1(clk,ld,in,inild,sld,sin,out);

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