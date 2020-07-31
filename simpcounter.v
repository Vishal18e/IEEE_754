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

/*5-bit counter*/
module simpcounter(input clk,res,enb,output reg[5:0] count);

always @(posedge clk)
count<=res? 5'b0 :( enb? count+1 : count);

endmodule

/*
module simpcounter_testbench();

reg clk,clr,enb;
wire[5:0] count;

simpcounter count1(clk,clr,enb,count);

initial begin
clk=0;

forever
#10 clk=~clk;
end

initial
begin
#5 clr=1;
#20 clr=0;enb=1;
end

endmodule 
*/