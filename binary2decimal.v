`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2020 02:19:20 AM
// Design Name: 
// Module Name: binary2decimal
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


module binary2decimal(
    input clk,
    input start,
    input [15:0] din,
   // output done,
    output reg [19:0] out,
    output reg done1
    );
   localparam  S_IDLE=0,
                S_DONE=1,
                S_DIVIDE=2,
                S_NEXT_DIGIT=3,
                S_CONVERT=4;
    reg [2:0] state=S_IDLE;
    reg [31:0] data;
    reg [31:0] div;
    reg [3:0] mod;
    reg [2:0] byte_count;
    reg [19:0] dout;
    
   // assign done = (state == S_IDLE || state == S_DONE) ? 1 : 0;
    
    always@(posedge clk)
        case (state)
        S_IDLE: begin
            done1<=0;
            if (start == 1) begin
                state <= S_DIVIDE;
                data <= din;
                byte_count <= 0;
            end
        end
        S_DONE: begin
            out<=dout;
            done1<=1;
            if (start == 0)
                state <= S_IDLE;
        end
        S_DIVIDE: begin
            div <= data / 10;
            mod <= data % 10;
            state <= S_CONVERT;
        end
        S_NEXT_DIGIT: begin
            if (byte_count == 4)
                state <= S_DONE;
            else
                state <= S_DIVIDE;
            data <= div;
            byte_count <= byte_count + 1;
        end
        S_CONVERT: begin
            dout[15:0] <= dout[19:4];
            dout[19:16] <= mod[3:0];
            state <= S_NEXT_DIGIT;
        end
        default: begin
            state <= S_IDLE;
        end
        endcase  
    
     
endmodule
