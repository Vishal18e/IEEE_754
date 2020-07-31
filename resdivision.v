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

module resdivision(clk,res,divisor,dividen,quotient);

parameter size=24;

input clk,res;
input [size-1:0] divisor,dividen;
output [size-1:0] quotient;

wire [8:0]T;// represents the controller states .
wire [5:0]count;// 
wire [size-1:0] Qout,Aout;
wire [size+1:0] Bin,Bout;
reg  [size-1:0] dum=0;

controller C1(.clk(clk),.res(res),.count(count),.ch(Bout[size+1]),.out(T));
// ch is the sign bit for the remainder((dividend/B) i.e B_out left most bit i.eBout[size+1])  that is formed from substraction of A from B.
// this is used to determine , which state to go(T4 or T5) after T3 .

simpcounter CO1(.clk(clk)//clk to synchronize the circuit.
,.res(T[0])//reset is done at the T0 state. 
,.enb(T[7])//if enable is 1 i.e if the controller is in state T7 then only enabl becomes 1.
,.count(count)// gives the value of count.
);

// register Q helps to deteermine the value of the quotient.
// input to the reg Q is set to zero.
// if load/ld ==1 i.e T0 state so Q=0;i.e Q=in=0;
// serial load is done whenever T4|T5 is 1 ,
// if T4 =1 => sld =1; else 0. 
registerQ Q(.clk(clk),.ld(T[0]),.in(dum),.sld((T[4]|T[5])),.sin(T[4]),.out(Qout));

// dividend or remainder module.
// this register gets updated only in state T1 or in state T5.
//input to this should be the previous remainder or the dividend value.
// output to this has to be the dividend output.
// also the dividend module is padded with zeros at the T6 state. 
// inlid stands for initial loading , inlid is 25 bit bus hence 0 is left most concatenated.
// Whenever the controlleris in T0 state dividen is pushed and hence sin is 1 in that case.
registerB B(.clk(clk),.ld(T[1]|T[5]),.in(Bin),.inild({2'b0,dividen}),.sld(T[6]),.sin(T[0]),.out(Bout));

//divisor , simply upload the divisor.
registerA A(.clk(clk),.ld(T[0]),.in(divisor),.out(Aout));

addcumsub addsub(.opp(T[1]),.A(Bout),.B({2'b0,Aout}),.out(Bin));
print P1(.in(Qout),.sw(T[8]),.out(quotient));

endmodule
/*
module resdivision_testbench;

parameter size=24;

reg clk,res;
reg [size-1:0] divisor,dividen;
wire [size-1:0] quotient;

resdivision R1(clk,res,divisor,dividen,quotient);

initial
begin
clk=0;

forever
#10 clk=~clk;
end

initial
begin
#5 divisor=24'h918000; dividen=24'h8ca000;
#4000 res=1;divisor=910000;
#20 res=0;
end
endmodule
*/