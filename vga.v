`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2020 11:08:32 AM
// Design Name: 
// Module Name: vga
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


module vga(
input clk,  
output wire hsync, 
output wire vsync, 
output reg [9:0] hcs=0, 
output reg [9:0] vcs=0, 
output wire activevideo 
    );

  
 
 reg  vcsenable;
 
 localparam hpixels = 800;
 localparam vpixels = 521;
 
assign hsync = ( hcs >127) ? 1:0;
assign vsync = ( vcs >1  ) ? 1:0;
assign activevideo =((hcs>=143) &&(hcs<=783) && (vcs >=30) && (vcs <=510)) ? 1:0;
 always@(posedge clk)
 begin
 if(hcs == hpixels-1 ) begin
 hcs <=0;
 vcsenable =1; end
 else begin
 hcs <= hcs +1;
 vcsenable =0; end
 end
 
 always@(posedge clk && vcsenable ==1)
 begin
 if(vcs == vpixels-1)
   vcs <=0;
 else 
 vcs <= vcs + 1; 
 end
 
 //clk_devider d1(clk,)
//barhight barhight(.hcs(hcs),.vcs(vcs),.hight(hight));

endmodule

