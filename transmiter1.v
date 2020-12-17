`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2020 12:43:12 PM
// Design Name: 
// Module Name: transmiter
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


module transmiter1(
    input clk,
    input [7:0] data,
    input transmit,transmit2,
   // input reset,
    output reg TXD,
  //  output [7:0]led,
    output reg [2:0]done,
    output reg finish
    );
//wire transmit=1;
//wire [7:0]data=8'h41;
reg [4:0] bit_counter;
reg [13:0] boudrate_counter;
reg [9:0] shiftright_register;
reg state=0; 
reg next_state;
reg shift;
reg load;
reg clear;
wire do;

assign do=transmit & transmit2;
//assign led=data[7:0];
//assign done=load;

initial begin
bit_counter=0;
boudrate_counter=0;
state<=0;
done<=0;
end

always @(posedge clk)    
 begin
//  if(reset)  
//   begin
//    state<=0;
//    bit_counter<=0;
//    boudrate_counter<=0;
//   end
//  else begin
//   boudrate_counter=boudrate_counter+1;
   if(transmit2)begin
   if(boudrate_counter==10417)
    begin
     boudrate_counter<=0;
     state<=next_state;
     if(load)
      shiftright_register<={1'b1,data,1'b0};
     if(clear)
       bit_counter<=0;
     else
        bit_counter<=bit_counter+1;
     if(shift)
       shiftright_register<=shiftright_register>>1;
    // bit_counter<=bit_counter+1;
    end
   else
   boudrate_counter=boudrate_counter+1;
   end
end

always @(posedge clk)
begin
    load <=0; // set load equal to 0 at the beginning
    shift <=0; // set shift equal to 0 at the beginning
    clear <=0; // set clear equal to 0 at the beginning
    TXD <=1; // set TxD equals to during no transmission
    //done<=0;
    finish<=0;
    case (state)
        0: begin // idle state
             if (do) begin // assert transmit input
             next_state <= 1; // Move to transmit state
             load <=1; // set load to 1 to prepare to load the data
             shift <=0; // set shift to 0 so no shift ready yet
             clear <=0; // set clear to 0 to avoid clear any counter
             if(boudrate_counter==10415)begin
             done<=done+1;
             if(done==5)begin
             finish<=1;
             done<=0;
             end
//             else
//             finish<=0;
             end
             end 
            
		else begin // if transmit not asserted
             next_state <= 0; // next state is back to idle state
             TXD <= 1; 
             end
           end
        1: begin  // transmit state
             if (bit_counter ==10) begin // check if transmission is complete or not. If complete
             next_state <= 0; // set nextstate back to 0 to idle state
             clear <=1; // set clear to 1 to clear all counters
      //       done<=1;
             end 
		else begin // if transmisssion is not complete 
             next_state <= 1; // set nextstate to 1 to stay in transmit state
             TXD <=shiftright_register[0]; // shift the bit to output TxD
             shift <=1; // set shift to 1 to continue shifting the data
             end
           end
         default: next_state <= 0;                      
    endcase
end


endmodule
