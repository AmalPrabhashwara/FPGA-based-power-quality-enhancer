`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2019 12:31:44 AM
// Design Name: 
// Module Name: calTHD
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


module calTHD(
input clk,input [47:0]sum,input[23:0]a,b,output [23:0]out
    );
wire [47:0]c,d;
reg [23:0]sumHarmSqr,firstHarmSqr;
wire [23:0]ans1,ans2;
always@(*)begin
sumHarmSqr=ans1;
firstHarmSqr=ans2;
end
power power_0(clk,a,c);
power power_1(clk,b,d);
sqrt sqrt_0(clk,sum,ans1);
sqrt sqrt_1(clk,c+d,ans2);
division division_0(sumHarmSqr,firstHarmSqr,out);
endmodule
