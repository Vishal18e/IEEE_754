`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2019 17:08:29
// Design Name: 
// Module Name: always_use
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


module always_use(out,exp,ex,int_val,flag);
input flag;
input [127:0] int_val;
input[7:0] out;
wire[7:0] exp1;
output reg [7:0] exp,ex;


always @(out)
  begin
    if(!int_val)
   
    begin
        exp=-12;
        ex=0;
    end
   
    else if (int_val[out]&& (~flag))
      begin
      exp = out-12;
      ex=out;
      end
    else if(~int_val[out])
    begin
    exp=exp;
    ex=ex;
    end
    else
    begin
    exp=exp;
    ex=ex;
    end
   
  end
assign exp1=exp+127;

endmodule
