`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2020 02:53:55 PM
// Design Name: 
// Module Name: calVoltage
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


module calVoltage(
input clk,input start,input [23:0]sample,output reg[23:0]Vrms
    );
reg [30:0]i;
//reg start_power,
reg start_devision,start_cal_vrms;
reg done1,done2,done3;
wire [47:0]ans1;
wire [23:0]ans3;
wire [55:0]ans2;
reg [47:0]voltage_squad_val,Vrms_squad_val;
reg [55:0]sum;
localparam STATE_WAIT=0;
localparam STATE_START=1;
localparam STATE_SUM=2;
localparam STATE_DIVISION=3;
localparam STATE_CAL_VRMS=4;
localparam STATE_FINISH=5;
localparam STATE_WAIT_CLK=6;
localparam STATE_MID=7;

reg [2:0]state=STATE_WAIT;

initial begin
i<=0;
sum<=0;

end

always @(posedge clk)begin
 case(state)
   STATE_WAIT:begin
    if(start==1'b1)
   //  start_power<=1'b1;
     state<=STATE_START;
   end
   
   STATE_START:begin
  //  start_power<=1'b0;
   // if(done1==1'b1)begin
     voltage_squad_val<=ans1;
     state<=STATE_SUM;
  //  end
   end
   
   STATE_SUM:begin
    sum<=sum+voltage_squad_val;
    i<=i+1;
    state<=STATE_MID;
//    if(i==2)begin
//     state<=STATE_DIVISION;
//     i<=0;
//     end
//    else
//     state<=STATE_FINISH;
   // start_devision<=1'b1;
     
   end
   
   STATE_MID:begin
    if(i==2048)begin
     state<=STATE_DIVISION;
     i<=0;
     end
    else
     state<=STATE_FINISH;
   
   end

   STATE_DIVISION:begin
    //start_devision<=1'b0;
   // if(done2==1'b1)begin
     Vrms_squad_val<=ans2[47:0];
     state<=STATE_WAIT_CLK;
     
   //  start_cal_vrms<=1'b1;
    //end
   end
   
   STATE_WAIT_CLK:begin
    state<=STATE_CAL_VRMS;
    sum<=0;
   end
   
   STATE_CAL_VRMS:begin
   // start_cal_vrms<=1'b0;
   // if(done3==1'b1)begin
     Vrms<=ans3;
     state<=STATE_FINISH;
  //  end
   end
   
   STATE_FINISH:begin
    state<=STATE_WAIT;
   end
   
 endcase
end

power power_0(clk,sample,ans1);
DIVISION2 division_0(sum,ans2);
sqrt sqr_0(clk,Vrms_squad_val,ans3);


endmodule
