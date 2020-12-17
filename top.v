`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2019 10:16:17 PM
// Design Name: 
// Module Name: top
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



module top(
input clk,input vauxn6,vauxp6,vauxn7,vauxp7,input [2:0] sw,input transmit,output TxD,
output[3:0]an,output [6:0] seg, output hsync, output vsync,output[3:0]red, output[3:0] green, output[3:0] blue
);

    localparam freq_bins=128;
    localparam bin_addr_w = $clog2(freq_bins);
    
    
    wire [6:0] daddr_in;
    wire adc_ready;
    wire eos_out, isbusy, alarm, adc_data_ready;
    wire [15:0] adc_data;
    wire [4:0] channel_out;
    wire redy;
    wire [23:0]val,val_CT,bin,bin_CT;
    wire [15:0]sseg_data;
    
    reg [7:0]data1;
    wire [2:0]done1;
    wire [39:0]data2;
    reg [40:0]counter;
    reg start;
    reg [15:0]adc_data2;
    wire enable;
    wire [19:0]data0;
    reg start_CT;
   
    reg [15:0]adc_data2_CT;
    wire redy_CT;
    wire [bin_addr_w-1:0]index,index_CT;
    reg [23:0] VT_bin [freq_bins-1:0];
    reg [23:0] CT_bin [freq_bins-1:0];
    
    reg [15:0] one28val [freq_bins-1:0];
    wire [15:0] one28_val;
    
    reg [15:0]hex_val;
    wire [23:0]VT_val,CT_val;
    reg [30:0]clk_counter;
    reg [bin_addr_w-1:0]bin_counter;
 
    reg [2:0]state;
    reg [1:0]activate;
    reg [11:0]display_val;
    reg start_transmit;
    wire done_transmit;
    reg [30:0]y;
    reg [15:0]store[511:0];
    reg [30:0]i,x;
    
    reg [15:0]adc_Bata[511:0];
    wire devided_clk;
    wire [9:0]hcs,vcs;
    wire activevideo;
    reg [23:0]DipVgaBin;
    reg [8:0]bar[127:0];
    reg [15:0]k=16'h8889;
    reg [8:0]height;
    reg [28:0]counter2;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    reg [8:0]j;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    localparam S1=1;
    localparam S2=2;
    localparam S3=3;
    localparam S4=4;
    localparam S5=5;
    localparam S6=6;
    
    
    
     
     
    initial begin
    counter=0;
    counter2=0;/////////////////////////////////////////////////////////////////////////////////////////////////
    j=0;/////////////////////////////////////////////////////////////////////////////////////////////////////////////
    start=0;
    start_CT=0;
    state=S1;
    bin_counter=0;
    y=0;
    i=0;
    x=0;
    $readmemb("example6.mem",adc_Bata );
    $readmemb("one28.mem",one28val ); 
    end



xadc_wiz_0 your_instance_name (
  .di_in(0),              // input wire [15 : 0] di_in
  .daddr_in(daddr_in),        // input wire [6 : 0] daddr_in
  .den_in(enable),            // input wire den_in
  .dwe_in(1'b0),            // input wire dwe_in
  .drdy_out(adc_data_ready),        // output wire drdy_out
  .do_out(adc_data),            // output wire [15 : 0] do_out
  .dclk_in(clk),          // input wire dclk_in
  .vp_in(1'b0),              // input wire vp_in
  .vn_in(1'b0),              // input wire vn_in
  .vauxp6(vauxp6),            // input wire vauxp6
  .vauxn6(vauxn6),            // input wire vauxn6
  .vauxp7(vauxp7),            // input wire vauxp7
  .vauxn7(vauxn7),            // input wire vauxn7
  .channel_out(channel_out),  // output wire [4 : 0] channel_out
  .eoc_out(enable),          // output wire eoc_out
  .alarm_out(alarm),      // output wire alarm_out
  .eos_out(eos_out),          // output wire eos_out
  .busy_out(isbusy)        // output wire busy_out
);


    assign daddr_in=(sw[0]==0)? 7'h16:7'h17;
    
    always @(posedge clk)begin
    VT_bin[index]<=bin;
    CT_bin[index_CT]<=bin_CT;
    end
////////////////////////////////////////////////////////////////////////////////////////////////////////
    always @(posedge clk)begin
    if(counter2==1000000)begin
     for(j=0; j<128;j=j+1)begin
       VT_bin[j]<=0;
       CT_bin[j]<=0;
      end
      counter2<=0;
    end
    else begin
    counter2<=counter2+1;
    j<=0;
    end
    end
 ////////////////////////////////////////////////////////////////////////////////////////////////////////   
    always@(posedge clk)begin
                              //     512    128    1280          1024
    if(counter==78125)begin   //65120 195313 781250 78125 3080     97656
    counter<=0;
    if(sw[0]==0)begin
    start<=1;
  //  adc_data2<=adc_Bata[i];
   // store[i]<=adc_Bata[i];
    adc_data2<=adc_data;
    store[i]<=adc_data;
//    if(i==200000)
    if(i==511)
    i<=0;
    else
    i<=i+1;
    end
    else begin
    start_CT<=1;
    adc_data2_CT<=adc_data;
    end
    end
    
    else begin
    counter<=counter+1;
    start<=0;
    start_CT<=0;
    end
    
    end
    
   assign VT_val=VT_bin[y];
   assign CT_val=CT_bin[y];
   assign one28_val=one28val[y];
   
    
    
    calfft f1(.clk(clk),.start(start),.signal(adc_data2[15:0]),.ready(redy),.dout(val),.bin_val(bin),.bin_num(index));
    calfft_CT f2(.clk(clk),.start(start_CT),.signal(adc_data2_CT[15:0]),.ready(redy_CT),.dout(val_CT),.bin_val(bin_CT),.bin_num(index_CT));

always @(posedge clk)begin
case(state)
 S1:begin
 if(sw[1:0]==2'b00)begin
 // hex_val<=adc_Bata[x];
  hex_val<=store[x];
  if(x==511)
  x<=0;
  else
  x<=x+1;
  end
 if(sw[1:0]==2'b01)
  hex_val<=adc_data2_CT;
 if(sw[1:0]==2'b10)
   hex_val<={4'h0,VT_val[23:12]};//hex_val<=one28_val;
 if(sw[1:0]==2'b11) 
   hex_val<={4'h0,CT_val[23:12]};
 state<=S2;
 start_transmit<=1;
 end
 
 S2:begin
  start_transmit<=0;
  if(done_transmit)begin
    state<=S3;
   end
 end
 
 S3:begin
  if(sw[1]==1'b1)
  y<=y+1;
  if(y==129)
   state<=S4;
  else
   state<=S1;
  end
 
 S4:begin

 end
 
 endcase
end
    

Do_transmition d1(clk,start_transmit,transmit,hex_val,TxD,done_transmit);

 
 always @(posedge clk)begin
 case(sw[0])
  1'b0:display_val<=val[23:12];
  1'b1:display_val<=val_CT[23:12];
 endcase
 end
 
 always @(hcs)begin
 
   if(vcs<=29 &&  hcs>=143 && hcs<=782)begin
     DipVgaBin<=VT_bin[(hcs-143)/8];  //8---15
     bar[(hcs-143)/8]<=DipVgaBin/k;
   end
   else if(vcs<=510 && hcs>=143 && hcs<=782)begin
    height<=bar[(hcs-143)/8];
   end
   else if(vcs<=520 && hcs>=143 && hcs<=782)begin
    bar[(hcs-143)/8]<=0;
    height<=0;
   end
   else begin
   height<=0;
   bar[(hcs-143)/8]<=0;
   end
   
 end
    
 bin2seg b2(clk,display_val,seg,an);
 clk_devider cd1(clk,devided_clk);
 vga v1(devided_clk,hsync,vsync,hcs,vcs,activevideo);
 rgb rg1(vcs,hcs,activevideo,height,red,green,blue);
 
endmodule
