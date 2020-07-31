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
// the division module is based on controller and datapath.
// hence this module is basically the controller.
//Controller for restoring devision technique
//inputs are clock,counter value, ch and output is 6bit out
module controller(clk,res,count,ch,out);

input [5:0] count;
input ch,clk,res;	//Res is reset for controller
// ch is the sign bit for the remainder(dividend/B) that is formed from substraction of A from B.
// this is used to determine , which state to go(T4 or T5) after T3 .
output reg [8:0] out;

parameter T0=0;// defines the initial state, initiallizes the variables.A<- divisor, B<- dividend.
//count =0, Q=0;

parameter T1=1;// we will subtract divisor from the dividend, and then store is back onto
// the dividend as remainder.
// note dividend is what that transform to remainder.
 
parameter T2=2;// This is the waiting state.

parameter T3=3;// This can also be regareded as waiting state, which is being followed by a 
// conditional block.
// the desription of the conditional block is being given by this state.

parameter T4=4;// finally after sustraction of dividend(B) by divisor(A) the value is stored back in B
// which acts like remainder and the dividend for nxt stage.
//Note, from T1 state we see that if we subtract divisor from dividend
// two cases can arrive.
// either remainder left is positive or negetive.

// Analyze it like decimal division.
//i.e 10.3%5 => B=10.3 A=5;
//B =10.3-5 = 5.3 , A=5;
//B=5.3-5 =0.3 , A=5;
//B=0.3-5 ,A=5; now B has turned negetive  so Q=2;
//this implies that we have add divisor again to the remainder so that it turns positive.
// and  put a decinal point and shift the remainder by one decimal place.
//B= 3 and quotient =2.
//B=3-5 <0 => Q=quotient = 2.0 and now B=30;
//B= 30-5; B=25-5;B=20-5;..... => Q=2.06.
// Note there is one difference,that the number of recurrences that we need within 
//the same cycle is not needed when we perform binary point division.
//since either they would be only having values of 0 or 1 .
//Hence no recurrences required.
//i.e if dividend(B) after substraction is positive conactenate 1 else if
// it bacomes negative coma back to the initial stage and cocatenate 0 to it .
// which would imply the reduction in the exponent value. 

// this means that we can just left shift the quotient by1 bit and concatenate it by 1 to the right 
// most bit.. i.e: if Q_initial =10101 and if B>0  then Q_final = 101011, else Q_final would be 101010.

parameter T5=5;// i.e after substraction dibidend B becomes negetive.
// so we need to add divisor A angain to it and then left shift the initial quotient and concatenate it to 1.       

parameter T6=6;// in this state remainder is redefined i.e left shift the
// initial remainder and then concatenate it to 0.
// As we used to do it in case of decimal point.
// Since dividend and al, that are havin constant number of bits  and hence we need  to pad zeros to
// fill those places after every shifting
// shown in the report of the ASM chart.
 
parameter T7=7;// this sate is used to increment the counter upto 23.
// if count == 23 , then it will move onto sttae T8 elce again to state T1.

parameter T8=8;// keeping accountof the final value.

reg [3:0] cs,ns;

always@(posedge clk)
begin
if(res)
cs=T0;
else
cs=ns;
end

always@(posedge clk)
begin
case(cs)
T0: begin
	ns=T1;
	out=9'b000000001;
    end
T1: begin
	ns=T2;
	out=9'b000000010;
    end
T2: begin	//waiting state
	ns=T3;
	out=9'b000000100;
    end
T3: begin	
	case(ch)
	0: ns=T4;	//if ch=0 ==>> B>0 
	1: ns=T5;	//if ch=1 ==>> B<0
	default: ns=T3;
	endcase
	out=9'b000001000;
    end
T4: begin
	ns=T6;
	out=9'b000010000;
    end
T5: begin	
	ns=T6;
	out=9'b000100000;
    end
T6: begin
	ns=T7;
	out=9'b001000000;
    end
T7: begin
	if(count==23)
	ns=T8;
	else
	ns=T1;
	out=9'b010000000;
    end
T8: out=9'b100000000;
default : begin
		ns=T0;
		out=0;
	  end
endcase
end
endmodule