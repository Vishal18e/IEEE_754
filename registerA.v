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

//will contain divisor of the division
module registerA(clk,ld,in,out);

parameter size=24;

input clk,ld;
input [size-1:0] in;
output reg [size-1:0] out;

always @ (posedge clk)
begin
if(ld)	//if ld is high, loads the register
out<=in;
//...
end

endmodule