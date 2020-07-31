///change onwards for out module





`timescale 1ps / 1ps



//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2019 20:59:32
// Design Name: 
// Module Name: float_add_subs
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

//The module uses serial adder for addition or substraction
//when opp=0-->>> add, when opp=1-->>> subs
module float_add_subs(largereg,smallreg,out,diff,check_out);

//...inputs
input[7:0] diff;
input[32:0] largereg,smallreg;
output reg[31:0] out;
output reg check_out=1'b0;
//....

//defining wires ,reg and module for serial adder
reg [5:0] ex_shift=0;
reg [32:0] A,B;

reg [22:0] mantA,mantB;
reg [23:0] mant_out;
wire [23:0] mantout;

clamant c1(mantA,mantB,mantout);
//...

always@(*)  
begin
	if(!largereg[32]&&!smallreg[32])	//smallreg is positive then largereg is positive as well
		begin
		  if(diff)
		  begin
			A=largereg;B=smallreg;
			mantA=A[22:0];mantB=B[22:0];
			if(!mantout[23])
			begin
			A[31:24]=A[31:24]+mantout[23];
			out={1'b0,A[31:24],mantout[22:0]};
			end
			else
			begin
			A[31:24]=A[31:24]+mantout[23];
			out={1'b0,A[31:24],1'b0,mantout[22:1]};
			end			
		  end
		  else
		  begin
			A=largereg;B=smallreg;
          mantA=A[22:0];mantB=B[22:0];
          A[31:24]=A[31:24]+1;
          if(mantout[23])
          out={1'b0,A[31:24], mantout[23:1]};
          else
          out={1'b0,A[31:24],1'b0,mantout[22:1]};
          end		  
		end
	else if(largereg[32]&&smallreg[32])	//largereg is negative than smallreg is negative  as well
		begin
		  if(diff)
        begin
          A=largereg;B=smallreg;
          mantA=A[22:0];mantB=B[22:0];
          if(!mantout[23])
          begin
          A[31:24]=A[31:24]+mantout[23];
          out={1'b1,A[31:24],mantout[22:0]};
          end
          else
          begin
          A[31:24]=A[31:24]+mantout[23];
          out={1'b1,A[31:24],1'b0,mantout[22:1]};
          end            
        end
        else
        begin
          A=largereg;B=smallreg;
        mantA=A[22:0];mantB=B[22:0];
        A[31:24]=A[31:24]+1;
        if(mantout[23])
        out={1'b1,A[31:24], mantout[23:1]};
        else
        out={1'b1,A[31:24],1'b0,mantout[22:1]};
        end          
		end
	else if(smallreg[32]&&!(largereg[32]))	//largereg is positive while smallreg is negative
		begin
		 
			A=largereg;B=smallreg;
			mantA=A[22:0];mantB=-B[22:0];
			if(mantout[23])
			ex_shift=0;
			else if(mantout[22])
			ex_shift=1;
			else if(mantout[21])
			ex_shift=2;
			else if(mantout[20])
            ex_shift=3;
            else if(mantout[19])
            ex_shift=4;
			else if(mantout[18])
            ex_shift=5;
            else if(mantout[17])
            ex_shift=6;
            else if(mantout[15])
            ex_shift=7;
            else if(mantout[14])
            ex_shift=8;
            else if(mantout[13])
            ex_shift=9;
            else if(mantout[12])
            ex_shift=10;
            else if(mantout[11])
            ex_shift=11;
            else if(mantout[10])
            ex_shift=12;
            else if(mantout[9])
            ex_shift=13;                
            else if(mantout[8])
            ex_shift=14;
            else if(mantout[7])
            ex_shift=15;
            else if(mantout[6])
            ex_shift=16;
            else if(mantout[5])
            ex_shift=17;
            else if(mantout[4])
            ex_shift=18;
            else if(mantout[3])
            ex_shift=19;
            else if(mantout[2])
            ex_shift=20;
            else if(mantout[1])
            ex_shift=21;     
            else if(mantout[0])
            ex_shift=22;
            else 
            ex_shift=23;
             if(ex_shift!=23) 
            begin
               check_out=1'b1;                  
               out={1'b0,(A[31:24]-ex_shift),(mantout[22:0]<<ex_shift)};
            end
            else
            begin
               check_out=1'b0;
               out={1'b0,(A[31:24]-ex_shift),(mantout[22:0]<<ex_shift)}; 
            end
		
        end
      else 	//largereg is negetive while smallreg is positive
            begin
		  if((A[22:0]==B[22:0])&(diff==0))
            begin
              check_out=1'b1;
              out={1'b0,A[31:24],23'h000000};
            end
            else
            begin        
                A=largereg;B=smallreg;
                mantA=-A[22:0];mantB=B[22:0];
                if(mantout[22])
                ex_shift=1;
                else if(mantout[21])
                ex_shift=2;
                else if(mantout[20])
                ex_shift=3;
                else if(mantout[19])
                ex_shift=4;
                else if(mantout[18])
                ex_shift=5;
                else if(mantout[17])
                ex_shift=6;
                else if(mantout[15])
                ex_shift=7;
                else if(mantout[14])
                ex_shift=8;
                else if(mantout[13])
                ex_shift=9;
                else if(mantout[12])
                ex_shift=10;
                else if(mantout[11])
                ex_shift=11;
                else if(mantout[10])
                ex_shift=12;
                else if(mantout[9])
                ex_shift=13;                
                else if(mantout[8])
                ex_shift=14;
                else if(mantout[7])
                ex_shift=15;
                else if(mantout[6])
                ex_shift=16;
                else if(mantout[5])
                ex_shift=17;
                else if(mantout[4])
                ex_shift=18;
                else if(mantout[3])
                ex_shift=19;
                else if(mantout[2])
                ex_shift=20;
                else if(mantout[1])
                ex_shift=21;     
                else if(mantout[0])
                ex_shift=22;
                else 
                ex_shift=23;
             if(ex_shift!=23) 
             begin
                check_out=1'b1;                  
                out={1'b1,(A[31:24]-ex_shift),((mantout[22:0])<<ex_shift)};
             end
             else
             begin
                check_out=1'b0;
                out={1'b1,(A[31:24]-ex_shift),((mantout[22:0])<<ex_shift)}; 
             end
             end
       
         end
         
 end
endmodule

/*
module float_add_subs_testbench;

reg opp;
reg [31:0] largereg,smallreg;
wire[31:0] out;

float_add_subs S1(opp,largereg,smallreg,out);

initial
begin
opp=0;largereg=32'b01000001011000001101000000000110;smallreg=32'b01000001011000000000110000000010;
#100 opp=1;
#100 opp=0; largereg=32'b01100001011000000000110000000010;smallreg=32'b11100001011000001101000000000110;
end
endmodule
*/
