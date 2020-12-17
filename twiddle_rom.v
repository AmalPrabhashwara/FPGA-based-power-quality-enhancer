`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2019 11:49:53 PM
// Design Name: 
// Module Name: twiddle_rom
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

module twiddle_rom
  #(
    parameter addr_w    = 7,
    parameter data_w    = 24
)
(
    input wire                  clk,
    input wire [addr_w-1:0]     addr,
    output reg [data_w-1:0]     dout_real,
    output reg [data_w-1:0]     dout_imag
);
    reg signed [7:0]a;
    reg [data_w-1:0] rom_real [127:0];
    reg [data_w-1:0] rom_imag [127:0];
    
    initial begin
       $readmemb("real.mem",rom_real );
       $readmemb("imag.mem",rom_imag );
    end

    always @(posedge clk) begin
        dout_real = rom_real[addr];
        dout_imag = rom_imag[addr];
    end

endmodule
