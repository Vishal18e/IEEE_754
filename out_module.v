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

module out_module(flt_value,int_val,pos,check_out,diff);
    input check_out;
    input[7:0] diff;
    output pos;
    output reg [127:0] int_val;
    input [31:0] flt_value;
    assign pos=~flt_value[31];


    wire [7:0] exp1=flt_value[30:23];
    wire[22:0] mantissa=flt_value[22:0];
    wire [7:0] ex=flt_value[30:23]-115;
    reg [23:0] new_mantissa;
    always@(*)
    begin
    if(!check_out)
    new_mantissa={1'b1,flt_value[22:0]};
    else if(!diff)
    new_mantissa={1'b0,flt_value[22:0]};
    else
     new_mantissa={1'b1,flt_value[22:0]};
    end
    

    always @(*) 
    begin
             if(ex> 23)
                int_val = new_mantissa << (ex - 23);
            else if(ex < 23)
                int_val = new_mantissa >> (23 - ex);
            else
                int_val=new_mantissa;

    end

endmodule