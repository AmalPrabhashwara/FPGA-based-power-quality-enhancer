`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2020 01:25:56 AM
// Design Name: 
// Module Name: Do_transmition
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


module Do_transmition(
input clk,input start,input transmit,input [15:0]val,output TxD,done
    );

localparam S1=1;
localparam S2=2;
localparam S3=3;
localparam S4=4;
localparam S5=5;

reg transmit2;
reg [2:0]state=S1;
wire [19:0]data0;
reg [19:0]data1;
wire [39:0]data2;
reg [7:0]data3;
reg start_binary2decimal;
reg [15:0]hex_val;
wire done1;
wire [2:0]dne;
wire finish;
reg [30:0]wait_counter;
assign done=(state==S5)?1:0;

always @(posedge clk)begin

case(state)
 S1:begin
  transmit2<=0;
  wait_counter<=0;
  if(start)begin
   hex_val<=val;
   start_binary2decimal<=1;
   state<=S2;
  end
 end

 S2:begin
  start_binary2decimal<=0;
  if(done1)begin
   data1<=data0;
   state<=S3;
  end
 end
 
 S3:begin
  state<=S4;
 end
 
 S4:begin
 transmit2<=1;
 if(finish==1)
 state<=S5;
 end

 S5:begin
state<=S1;
transmit2<=0;

end

endcase
end

always @(posedge clk)begin
 if(dne==0)
  data3<=data2[39:32];
 if(dne==1)
  data3<=data2[31:24];
 if(dne==2)
  data3<=data2[23:16];
 if(dne==3)
  data3<=data2[15:8];
 if(dne==4)
  data3<=data2[7:0];
 if(dne==5)
  data3<=8'h09;
end

 binary2decimal b2c(clk,start_binary2decimal,hex_val,data0,done1);
 convert C1(clk,data1[3:0],data2[7:0]);
 convert C2(clk,data1[7:4],data2[15:8]);
 convert C3(clk,data1[11:8],data2[23:16]);
 convert C4(clk,data1[15:12],data2[31:24]);
 convert C5(clk,data1[19:16],data2[39:32]);
 transmiter1 T2(clk,data3,transmit,transmit2,TxD,dne,finish);
    
endmodule
