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


module floatmult(flt_A,flt_B,flt_out);

input [31:0] flt_A,flt_B;
output [31:0] flt_out;

reg clk,res;

mult M(clk,res,flt_A,flt_B,flt_out);

initial
clk=0;

always @*
#1 clk<=~clk;
// 46 ps for 1ps/1ps

always @(flt_A or flt_B)
begin
res=1;
#3 res=0;
end

endmodule
/*

module floatmult_testbench();

reg [31:0] flt_A,flt_B;
wire [31:0] flt_out;

floatmult MM(flt_A,flt_B,flt_out);

initial
begin
flt_A= 32'h43918000;
flt_B= 32'h428ca000;
#200 flt_B=32'hc3910000;
end
endmodule
*/