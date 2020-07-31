`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2019 15:14:28
// Design Name: 
// Module Name: counter
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

module counter
    # (parameter N = 128,
     parameter WIDTH = 8)
 
  ( input clk,rstn,enable,output  reg[WIDTH-1:0] out,output reg flag);
     


 
  always @ (posedge clk) begin

    if (rstn) begin
      out <= 0;
      flag<=0;
    end else if(enable)
     begin
      if (out == N-1)
      begin
        out <= 0;
        flag<= 1;
      end
      else
        out <= out + 1;
    end
  end

endmodule
