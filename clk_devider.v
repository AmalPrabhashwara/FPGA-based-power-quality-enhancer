`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2020 12:32:18 PM
// Design Name: 
// Module Name: clk_divider
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


module clk_devider(
input wire dclk_in,
output reg clk=0
);
 integer counter_value = 0 ;
always@(posedge dclk_in)
begin
if(counter_value == 1)
counter_value <=0;
else
counter_value <= counter_value + 1;  
end   
always@(posedge dclk_in)
begin     
if(counter_value == 0)
clk <= ~clk;  
else  
clk <= clk;
end

endmodule
