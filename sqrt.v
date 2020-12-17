
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2019 11:33:59 AM
// Design Name: 
// Module Name: sqrt
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


module sqrt(
input clk,input [47:0]num,output reg[23:0]sqr
    );
 //reg [23:0] sqr;

//Verilog function to find square root of a 32 bit number.
//The output is 16 bit.
//function [15:0] sqrt;
   // reg [47:0] num=32'd25;  //declare input
    //intermediate signals.
    //reg [15:0]sqrt;
    reg [47:0] a;
    reg [23:0] q;
    reg [25:0] left,right,r;    
    integer i;
always@(posedge clk) begin
    //initialize all the variables.
    a = num;
    q = 0;
    i = 0;
    left = 0;   //input to adder/sub
    right = 0;  //input to adder/sub
    r = 0;  //remainder

    //run the calculations for 16 iterations.
    for(i=0;i<24;i=i+1) begin 
        right = {q,r[25],1'b1};
        left = {r[23:0],a[47:46]};
        a = {a[45:0],2'b00};    //left shift by 2 bits.
        if (r[25] == 1) //add if r is negative
            r = left + right;
        else    //subtract if r is positive
            r = left - right;
        q = {q[22:0],!r[25]};       
    
      //final assignment of output.
   end
    sqr = q;
//endfunction //end of Function

////simulation-Apply inputs.
//    initial begin
//        sqr = sqrt(32'd4000000);    #100;
//        sqr = sqrt(32'd96100);  #100;
//        sqr = sqrt(32'd25); #100;
//        sqr = sqrt(32'd100000000);  #100;
//        sqr = sqrt(32'd33); #100;
//        sqr = sqrt(32'd3300);   #100;
//        sqr = sqrt(32'd330000); #100;
//        sqr = sqrt(32'd3300000000); #100;
end
      

endmodule
