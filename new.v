`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2019 10:40:22 PM
// Design Name: 
// Module Name: new
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


module new(
input clk,input [23:0]samples,sample,output reg[23:0]pi
    );
wire [23:0]x;
wire y;
assign y=(samples[23]==0)?1:0;
//assign x=samples;
assign x={y,samples[22:0]};

always@(*)begin
  if(sample[23]==x[23])begin
     pi<={x[23],sample[22:0]+x[22:0]};
//                // state <= STATE_CALC;
                 end
  else if(sample[22:0]>x[22:0])begin
    pi<={sample[23],sample[22:0]-x[22:0]};
//                // state <= STATE_CALC;
                end
  else if(sample[22:0]<x[22:0])
    pi<={x[23],x[22:0]-sample[22:0]};
  else
   pi<=24'h000000;
//                // state <= STATE_CALC;
//                 end
//                // store new sample
//                samples[sample_index] <= sample;
//                tw_addr <= 0;

               
              // state <= STATE_CALC;
end
 
endmodule
