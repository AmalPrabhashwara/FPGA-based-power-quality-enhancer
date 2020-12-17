`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2019 11:59:13 AM
// Design Name: 
// Module Name: power
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


module power(
input clk,input [23:0]a,output reg[47:0]out
    );
always @(posedge clk)begin
 out<=a[22:0]*a[22:0];
end   
endmodule
