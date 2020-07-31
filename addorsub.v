`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.12.2019 20:52:13
// Design Name: 
// Module Name: addorsub
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


module addorsub(opp, flt_B,flt_outB);

input opp;
input [31:0] flt_B;
output reg [31:0] flt_outB;

always @(*)
begin
if(opp)
flt_outB={(~flt_B[31]),flt_B[30:0]};
else
flt_outB=flt_B;
end
endmodule
