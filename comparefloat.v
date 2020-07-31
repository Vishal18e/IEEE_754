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
////////////////////////////////////////////////////////////





//This module compares between A and B and gives larger and smaller of the two as separate outputs
//This module uses exp bits for comparison
module comparefloat(A,B,largereg,smallreg);

//inputs,outputs
input [31:0] A,B;
output reg[31:0] largereg,smallreg;
//...


//defining exponents for comparison
reg [7:0] expA,expB;	//exponent part for both A and B
//...
reg [22:0] mantA,mantB;

always@(*)   
begin
//Assigning the values for respective comparisons
expA=A[30:23];expB=B[30:23];
mantA=A[22:0];
mantB=B[22:0];
//....		
		if(expA>expB)
		begin
		largereg=A;
		smallreg=B;
		end
		else if(expA<expB)
        begin
        largereg=B;
        smallreg=A;
        end
        else        //Even the exponents are same. ONLY COMPARISON IS MANTISSA PART
//.....For positive numbers of same exponent, number with higher exponent leads to being considered larger number
            begin
//..............................code for mantissa part..................................

            if(mantA>mantB)
            begin
            largereg=A;
            smallreg=B;
            end
            else if(mantA<mantB)
            begin
            largereg=B;
            smallreg=A;
            end
            else
            begin
            largereg=A;
            smallreg=B;
            end
            end
end
endmodule


//The testbench code here is used to check whether the module is working correctly.
//For proper IEEE standard, the module will work smoothly
//testbench code
/*
module comparefloat_testbench();

reg clk;
reg[31:0] A,B;
wire [31:0] largereg,smallreg;

comparefloat C(A,B,clk,largereg,smallreg);

initial
begin
$monitor($time,"clk=%b,A=%b,B=%b,largereg=%b,smallreg=%b", clk,A,B,largereg,smallreg,);
clk=0;

forever
#100 clk=~clk;
end

initial
begin
A=32'b01000001011000001101000000000110;B=32'b01000001011000000000110000000010;
#1000 A=32'b01100001011000000000110000000010;
#1000 A=32'b11000001011000001101000000000110;
#1000 B=32'b11000001011000000000110000000010;
end
endmodule
*/