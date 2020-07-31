`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.01.2020 17:30:34
// Design Name: 
// Module Name: print
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

module print(in,sw,out);

parameter size=24;

input [size-1:0] in;
input sw;	//when sw=1 print module prints the value
output [size-1:0] out;

assign out=sw?in:0;

endmodule