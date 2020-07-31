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

module entry(flt_value,int_val,pos,flag);
    
    input pos;
    input[127:0] int_val;
    output[31:0] flt_value;
    output flag; 
    
    wire [7:0] exp;
    wire [7:0] exp1,ex;

    reg clk,reset,enable;
    wire[7:0] out;
   
    counter ctr(clk,reset,enable,out,flag);

    initial
    begin
    reset=1;enable=1;
    #2 clk=0;
    #3 clk=1;
    #10 reset=0;
    end
    always
    begin
    #5 clk=~clk;
    end
    
always_use block1(out,exp,ex,int_val,flag);

    reg [22:0] mantissa;
    assign exp1=exp+127;
    assign flt_value = {~(pos), exp1, mantissa};
    assign flt_value[31]= ~(pos);
    

    always @(ex,exp1) 
    begin
             if(ex> 23)
                mantissa = int_val >> (ex - 23);
            else if(ex < 23)
                mantissa = int_val << (23 - ex);
            else
                mantissa = int_val;

    end

endmodule