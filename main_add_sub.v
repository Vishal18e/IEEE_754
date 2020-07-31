`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2019 20:54:11
// Design Name: 
// Module Name: main
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

module main_add_sub(opp,int_in_A,posA,int_in_B,posB,int_out,posout);

input opp;
input posA,posB;
input[127:0] int_in_A,int_in_B;

output [127:0] int_out;
output posout;

wire [31:0] flt_in_A,flt_in_B,flt_in_changed_B,largereg,smallreg,flt_out;
wire flag1,flag2,check_out;
wire[7:0] diff;
reg [31:0] true_flt_out;
wire [32:0] out1,out2;

entry flt_A(.flt_value(flt_in_A),.int_val(int_in_A),.pos(posA),.flag(flag1));
entry flt_B(.flt_value(flt_in_B),.int_val(int_in_B),.pos(posB),.flag(flag2));
addorsub signchange(.opp(opp),.flt_B(flt_in_B),.flt_outB(flt_in_changed_B));
comparefloat comp(.A(flt_in_A),.B(flt_in_changed_B),.largereg(largereg),.smallreg(smallreg));
shift shifter(.largereg(largereg), .smallreg(smallreg), .out1(out1), .out2(out2), .diff(diff));
float_add_subs calc(.largereg(out1),.smallreg(out2),.out(flt_out),.diff(diff),.check_out(check_out));
out_module flt(true_flt_out,int_out,posout,check_out,diff);

always @(flag1)
begin
if(flag1)
true_flt_out<=flt_out;
else
true_flt_out<=0;
end
 endmodule
