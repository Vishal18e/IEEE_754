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

module addcumsub(opp,A,B,out);

parameter size=26;

input opp;		//opp states whether to add or substract. 0 for add and 1 for substract
input [size-1:0]A,B;	//23 bit inputs
output reg [size-1:0]out;	//23 bit output, carry out ignored

reg [size-1:0]in1,in2;	//23 bit inputs for cladiv module
wire [size:0] s;		//23 bit output of cladiv module
reg [size-1:0] Bbar;	//to store 2's complement of input B

cladiv C1(in1,in2,s);

always @*
begin
Bbar=-B;
if(!opp)
begin
in1=A;
in2=B;
out=s[size-1:0];
end
else
begin
in1=A;
in2=Bbar;
out=s[size-1:0];
end
end
endmodule

/*

module addcumsub_testbench;

parameter size=24;

reg opp;
reg [size:0]A,B;
wire [size:0]out;

addcumsub A1(opp,A,B,out);

initial 
begin
A=415;B=215;
#10 opp=1;
#20 opp=0;
#10 B=600;
#20 opp=1;
#20 opp=0;
end
endmodule
*/