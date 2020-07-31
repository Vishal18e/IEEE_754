`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2019 21:03:54
// Design Name: 
// Module Name: shift_mantissa
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

//shifting the mantissa of the no. with smaller exponent based om various conditions
module shift(largereg, smallreg, out1, out2,diff);

//input shft;   //shft will determine whether always block will activate or not
input [31:0] largereg, smallreg;//input as large and small no.
output reg [32:0]out1, out2;//outputs after shifting mantissa
output[7:0] diff;
reg [7:0] diff,expa,expb;//storing diff of exponents and exponent part of both numbers
reg [23:0] manta, mantb;//for storing mantissa part of two numbers along with the digit preceding decimal point


always @ (*)
begin
 expa = largereg[30:23];
 expb = smallreg[30:23];
 manta = {1'b1,largereg[22:0]};
 mantb = {1'b1,smallreg[22:0]};
 diff = expa - expb;
	if(diff)
	begin
	mantb = mantb>>diff;//shifting mantissa of smaller number
	out1 = {largereg[31],expa,manta};
    out2 = {smallreg[31],expa,mantb};
	end
	else
	begin
	out1 = {largereg[31],expa,manta};
	out2 = {smallreg[31],expa,mantb};
	end

end

endmodule

/*
module shift_testbench();
reg [31:0] largereg, smallreg;
wire [31:0] out1, out2;

shift s(largereg,smallreg,out1,out2);

initial begin
largereg = 32'b01000001110100000000000000000000;
smallreg = 32'b11000000110100000000000000000000;
#10 $finish;
end
endmodule
*/




 





