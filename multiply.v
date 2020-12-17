`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2020 04:58:52 AM
// Design Name: 
// Module Name: multiply
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


module multiply(input clk,input [15:0]a,input en,output reg[23:0]out,output done);


reg sign;
reg [31:0]x;
wire [15:0]b=16'h08b4;
localparam S_IDLE=1;
localparam S_MID=2;
localparam S_MID2=3;
localparam FINISH=4;
reg [2:0]state=S_IDLE;
assign done=(state==FINISH)?1:0;
always@(posedge clk)begin
case(state)
  S_IDLE:begin
    if(en==1)
     state<=S_MID;
  end
  S_MID:begin
//  if(a[23]==b[23])
//   sign=1'b0;
//  else
//   sign=1'b1;
   sign<=a[15];
   x=(a[14:0]*b[15:0])>>4;
  // out<={sign,x[22:0]};
   //state<=FINISH;
   state<=S_MID2;
  end
  
  S_MID2:begin
    out<={sign,x[22:0]};
    state<=FINISH;
  end
 
  FINISH:begin
    //   done<=1'b1;
       state<=S_IDLE;
    end
 
 
  
// x=x>>12;
//  out[22:0]=x[22:0];
//  out[23]=sign;

 endcase
// if(en==2)
//  state=3;
// else
//  state=4;
end


endmodule
