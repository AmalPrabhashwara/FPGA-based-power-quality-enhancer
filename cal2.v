`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2019 03:12:47 PM
// Design Name: 
// Module Name: CAL2
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2019 06:31:09 PM
// Design Name: 
// Module Name: CAL2
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


module CAL2(
input clk,en,input [23:0]frequency_bins_real,delta,twid_imag,frequency_bins_imag,twid_real,output reg [23:0]out,output done
    );

//wire start;
reg [23:0]answerA,answerB;
//assign start=(STATE==8) ? 1'b1:1'b0;
assign done=(state==STATEFINISH)? 1'b1:1'b0;
localparam STATEWAIT=0;
localparam ADD_FREQBINREAL_AND_DELTA=1;
localparam MUL_ANSWERA_AND_TWIDIMAG=2;
localparam MUL_FREQBINIMAG_AND_TWIDREAL=3;
localparam ADD_ANSWERA_B=4;
localparam STATEFINISH=5;

reg [3:0]state=STATEWAIT;
reg start_add_0,start_mul_0,start_mul_1,start_add_1;
wire done1,done2,done3,done4;
wire [23:0]answer1,answer2,answer3,answer4;
always @(posedge clk)
begin
 case(state)
  STATEWAIT:begin
   if(en)begin
    state<=ADD_FREQBINREAL_AND_DELTA;
    start_add_0<=1'b1;
    end
   end
  ADD_FREQBINREAL_AND_DELTA:begin
    start_add_0<=1'b0;
    if(done1==1)begin
    answerA<=answer1;
    state<=MUL_ANSWERA_AND_TWIDIMAG;
    start_mul_0<=1'b1;
    end
  end
  MUL_ANSWERA_AND_TWIDIMAG:begin
    start_mul_0<=1'b0;
     if(done2==1)begin
    state<=MUL_FREQBINIMAG_AND_TWIDREAL;
    start_mul_1<=1'b1;
    answerA<=answer2;
    end
  end
  MUL_FREQBINIMAG_AND_TWIDREAL:begin
   start_mul_1<=1'b0;
    if(done3==1)begin
    state<=ADD_ANSWERA_B;
    start_add_1<=1'b1;
    answerB<=answer3;
    end
  end
  ADD_ANSWERA_B:begin
   start_add_1<=1'b0;
    if(done4==1)begin
    out<=answer4;
    state<=STATEFINISH;
    end
  end
  STATEFINISH:begin
   state<=STATEWAIT;
  end
 endcase
end

add add_0(clk,frequency_bins_real,delta,start_add_0,answer1,done1);
mul mul_0(clk,answerA,twid_imag,start_mul_0,answer2,done2);
mul mul_1(clk,frequency_bins_imag,twid_real,start_mul_1,answer3,done3);
add add_1(clk,answerA,answerB,start_add_1,answer4,done4);
endmodule

