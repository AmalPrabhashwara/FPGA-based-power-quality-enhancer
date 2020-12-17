`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/29/2020 04:11:21 PM
// Design Name: 
// Module Name: rgb
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


module rgb(
/*input wire clk,*/
input wire [9:0] vcs,
input wire [9:0] hcs,
input wire activevideo,
input wire [8:0] hight,
output reg[3:0] red,
output reg[3:0] green,
output reg [3:0] blue
    );
 always@(*) 
 begin
 if(activevideo ==1)begin
   if(hight >=(480-vcs)) begin
    if( /*((hcs>=143)&&(hcs<=147)) ||*/((hcs>=183)&&(hcs<=190)) || ((hcs>=223)&&(hcs<=230)) || ((hcs>=263)&&(hcs<=270)) || ((hcs>=303)&&(hcs<=310)) || ((hcs>=343)&&(hcs<=350) || ((hcs>=383)&&(hcs<=390))) || ((hcs>=423)&&(hcs<=430)) || ((hcs>=463)&&(hcs<=470)) || ((hcs>=503)&&(hcs<=510)) || ((hcs>=543)&&(hcs<=550)))begin
    red <=4'h0;
    green <= 4'hf;
    blue <= 4'h0; end
    else begin          //100hz                   //150hz                   //200hz                   //250hz                  //300hz                   //350hz                    //400hz                        //450hz              //500hz                                              
    red <=4'hf;
    green <= 4'h0;
    blue <= 4'h0;end
    end             
    else begin
    red <=4'h0;
    green <= 4'h0;
    blue <= 4'hf; end
      end 
 else  begin
    red <=4'h0;
    green <= 4'h0;
    blue <= 4'h0; end
 
 end   
endmodule
