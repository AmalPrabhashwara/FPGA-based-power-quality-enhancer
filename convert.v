`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2020 03:12:32 PM
// Design Name: 
// Module Name: convert
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


module convert(
input clk,input [3:0]Data,output reg [7:0]Data2
    );

always@(posedge clk)begin
case(Data)
 4'h0:Data2<=8'h30;
 4'h1:Data2<=8'h31;
 4'h2:Data2<=8'h32;
 4'h3:Data2<=8'h33;
 4'h4:Data2<=8'h34;
 4'h5:Data2<=8'h35;
 4'h6:Data2<=8'h36;
 4'h7:Data2<=8'h37;
 4'h8:Data2<=8'h38;
 4'h9:Data2<=8'h39;
 4'hA:Data2<=8'h41;
 4'hB:Data2<=8'h42;
 4'hC:Data2<=8'h43;
 4'hD:Data2<=8'h44;
 4'hE:Data2<=8'h45;
 4'hF:Data2<=8'h46;
endcase
end
endmodule
