`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/16/2019 05:15:08 PM
// Design Name: 
// Module Name: 
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


module sub(
input clk,input [23:0]a,b,input en,output reg[23:0]out,output done
    );
 
localparam S_IDLE=1;
localparam S_MID=2;
localparam FINISH=3;
reg [2:0]state=S_IDLE;
//reg [23:0]x;
assign done=(state==FINISH)?1:0;
always@(posedge clk)begin
 case(state)
  S_IDLE:begin
   if(en==1)
    state<=S_MID;
  end
  S_MID:begin
    if(a[23]!=b[23])
        out={a[23],a[22:0]+b[22:0]};
       else if(a[22:0]>b[22:0])
        out={a[23],a[22:0]-b[22:0]};
       else if(a[22:0]<b[22:0])
        out={!b[23],b[22:0]-a[22:0]};
       else
        out=24'h000000;
        state<=FINISH;
      end
   FINISH:begin
   //    done<=1'b1;
       state<=S_IDLE;
    end
 endcase
 end

//if(en==4)
// begin
//  x=b;
//  x[23]=x[23]+1'b1;
//  if(a[23]==x[23])
//  out<={a[23],a[22:0]+x[22:0]};
//  else if(a[22:0]>x[22:0])
//  out<={a[23],a[22:0]-x[22:0]};
//  else
//  out<={x[23],x[22:0]-a[22:0]}; 
//  state=5;
// end
// end

        
endmodule

           
