`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.01.2020 17:04:55
// Design Name: 
// Module Name: mult
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

module mult(clk,res,flt_A,flt_B,flt_out);

input clk,res;
input [31:0] flt_A,flt_B;
output reg [31:0] flt_out;
//flt_out_exp : this variable is of 9 bit to keep an account of overflow also.
wire [8:0] flt_out_exp;//this is 9 bit.
reg [23:0] flt_A_mant=0,flt_dum_mant=0;	//24th bit contains leading 1
wire [24:0] flt_out_mant;		//24th bit contains leading value, 25th bit contains carryout
reg [4:0] count=0;
reg roundcheck;// this variable is created so that we don't actually lose any inforamation.
wire sign;
assign sign=flt_A[31]^flt_B[31];// if both pos then sign is pos=0 else both neg.
clamant_mult M(.in1(flt_A_mant),.in2(flt_dum_mant),.s(flt_out_mant));

assign flt_out_exp=flt_A[30:23]+flt_B[30:23]-8'h7F;// this is done to avoid 2 times the additionof the  bias number.

always@(posedge clk)
begin
if(flt_out_exp>=255)// overflow case.
flt_out={sign,31'h7fffffff};//maximum value that can be represented by floating point representaion.
else if(flt_out_exp<=0)// underflow case.
flt_out={sign,31'h3f800000};
else if(res)// for res ==1 , these values are initiallized to zero.
begin
count=0;//initiallized to zero.
roundcheck=0;//initiallized to zero.
flt_A_mant=0;//initiallized to zero.
flt_dum_mant=0;//initiallized to zero.
end
else if(count==24)
    begin
      if(flt_out_mant[24]==0)
    flt_out={sign,flt_out_exp[7:0],(flt_out_mant[22:0]+roundcheck)};
    else if (flt_out_mant[24]==1)
      begin
      roundcheck=flt_out_mant[0];
      flt_out={sign,(flt_out_exp[7:0]+8'h01),(flt_out_mant[23:1]+roundcheck)};
      end
      end
else if(count==23)// since count keeps on increasong and reaches to 23 first.
	begin
	roundcheck=flt_out_mant[0];//storing the value of output mantissa least significant bit, to avoid the loss of info. 
	flt_dum_mant=flt_out_mant[24:1];// shifted by 1 bit and then added to flt_A which is given below.
        flt_A_mant={1'b1,flt_A[22:0]};
	count=count+1;
        end
else
  begin
    case(flt_B[count])
      0: begin
            flt_dum_mant=flt_out_mant[24:1];//float_out_mant was shifted by 1 and then preserved in the variable 
            //flt_dum_mant which would be then added to flt_A_mant.
            flt_A_mant=0;// flt_B[i]=0 is multiplied with anything gives 0.
          end
      1: begin
            flt_dum_mant=flt_out_mant[24:1];//float_out_mant was shifted by 1 and then preserved in the variable 
            flt_A_mant={1'b1,flt_A[22:0]};// mantissa of A + 24th bit of A which used to be 1.
          end
          default: begin
                      flt_A_mant=0;// initial value.
                      flt_dum_mant=0;// initial value.
                    end
    endcase
      count=count+1;  
  end
end
endmodule

/*
module mult_testbench();

reg clk,res;
reg [31:0] flt_A,flt_B;
wire [31:0] flt_out;

mult M(clk,res,flt_A,flt_B,flt_out);
initial
clk=0;

always @*
#10 clk<=~clk;

initial
begin
  #30 flt_A= 32'b11000001011000000000110000000010;
      flt_B= 32'b01000001011000001101000000000110;
    end
  endmodule
  */