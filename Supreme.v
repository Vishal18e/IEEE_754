`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.01.2020 16:32:20
// Design Name: 
// Module Name: Supreme
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


module Supreme(num_A,num_B,sign_A,sign_B,opperation,out_res,out_sign);
input[127:0] num_A,num_B;
input sign_A,sign_B;
input[1:0] opperation;
output[127:0] out_res;
reg[127:0] out_res;
output out_sign;
reg out_sign;
wire opp=opperation[0];
wire flag1,flag2;
wire[31:0] flt_in_A,flt_in_B;
wire[127:0] out1_res,out2_res,out3_res;
wire out1_sign,out2_sign,out3_sign;
wire[31:0] fltdiv_res,fltmulti_res;
reg [31:0] flt_in_A_opp,flt_in_B_opp;
reg check_out;//needed to define it when calling the div and multiplication cases.
reg[7:0] difference;//needed to define it when calling the div and multiplication cases.

 main_add_sub ADD(.opp(opp),.int_in_A(num_A),.posA(sign_A),.int_in_B(num_B),.posB(sign_B),.int_out(out1_res),.posout(out1_sign));
 entry flt_A(.flt_value(flt_in_A),.int_val(num_A),.pos(sign_A),.flag(flag1));
 entry flt_B(.flt_value(flt_in_B),.int_val(num_B),.pos(sign_B),.flag(flag2));
 floatdivision DIV(.A(flt_in_A_opp),.B(flt_in_B_opp),.Quo(fltdiv_res));
 out_module DIV_out(.flt_value(fltdiv_res),.int_val(out2_res),.pos(out2_sign),.check_out(check_out),.diff(difference));
 floatmult MULTI(.flt_A(flt_in_A_opp),.flt_B(flt_in_B_opp),.flt_out(fltmulti_res)); 
 out_module MULTI_out(.flt_value(fltmulti_res),.int_val(out3_res),.pos(out3_sign),.check_out(check_out),.diff(difference));
 
 always@(flag1 or flag2 or out1_res or out2_res or out3_res)
 begin
 case(opperation)
 
 2'b0 :
 begin
  out_res = out1_res;
  out_sign= out1_sign;
 end
  
 2'b1 :
 begin
  out_res = out1_res;
  out_sign= out1_sign;
 end
 
 2'b10://Multiplication
 begin
  flt_in_A_opp=flt_in_A;
  flt_in_B_opp=flt_in_B;
  if((num_A==0)||(num_B==0))
  begin
  out_res=0;
  out_sign=0;
  end
  else
  begin
  out_res = out3_res;
  out_sign= out3_sign;
  check_out=1'b0;
  difference=0;
  end
 end
 
  2'b11://Division
 begin
   flt_in_A_opp=flt_in_A;
   flt_in_B_opp=flt_in_B;
  if(num_A==0)
  begin
    out_res=0;
    out_sign=0;
   end
   else if(num_B==0)
   begin
    out_res=128'hffffffffffffffffffffffffffffffff;
    out_sign=sign_A;
    end
    else
    begin
  out_res = out2_res;
  out_sign= out2_sign;
  check_out=1'b0;
  difference=0;
    end
 end
 
 default:
  begin
  out_res = out1_res;
  out_sign= out1_sign;
 end
 
 endcase
 end 
endmodule
