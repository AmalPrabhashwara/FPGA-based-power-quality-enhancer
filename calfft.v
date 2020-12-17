
module calfft
#(
parameter data_width =24,
parameter freq_bins = 128,
parameter freq_w = 24
)
(
input wire clk,input wire start,input [15:0]signal,output ready,output reg[23:0]dout,output reg[23:0]bin_val,output reg [6:0]bin_num//,output [23:0]SIGNAL,ABS,output reg[7:0]sample_num,output reg[6:0]bin_num
);
    
reg  [data_width-1:0] sample;
reg  [freq_w-1:0] bin_out_real [freq_bins-1:0];
reg  [freq_w-1:0] bin_out_imag [freq_bins-1:0];

reg [9:0] cycles =0;
reg [40:0] counter=0;
//reg [6:0] sample_num=0;

localparam bin_addr_w = $clog2(freq_bins);
reg [bin_addr_w-1:0] tw_addr;
reg [bin_addr_w-1:0] sample_index;

wire  [ data_width-1:0] twid_real;
wire  [data_width-1:0] twid_imag;

twiddle_rom #(.addr_w(bin_addr_w), 
.data_w(data_width)) twiddle_rom_0(.clk(clk),
.addr(tw_addr),
.dout_real(twid_real),
.dout_imag(twid_imag)
   );
reg  [freq_w-1:0] frequency_bins_real [freq_bins-1:0];
reg  [freq_w-1:0] frequency_bins_imag [freq_bins-1:0]; 
wire [freq_w-1:0] out1,out2,out3;
//reg [47:0]sumReal;
wire [47:0]squardReal;
//reg [47:0]sumImag;
wire [47:0]squardImag;
//reg [47:0]sum;
//reg [23:0]firstReal,firstImag;
//reg [23:0]THD;
reg START;
wire FINISH;
reg [47:0] squad_abs [freq_bins-1:0];
reg [23:0] abs [freq_bins-1:0];
wire [23:0]ans1;
reg [15:0]data;
reg sign;

//always@(*)begin
//sumReal=sumReal+squardReal;
//sumImag=sumImag+squardImag;
//end 

reg [data_width-1:0] samples [freq_bins-1:0];   

reg [data_width-1:0] delta;
wire [data_width-1:0] diff;
reg [data_width-1:0] x;
  integer j;
    initial begin
        
        tw_addr = 0;
        sample_index = 0;
        delta = 0;
        for(j = 0; j < freq_bins; j = j + 1)  begin
            samples[j] = 0;
            frequency_bins_real[j] = 0;
            frequency_bins_imag[j] = 0;
        end
    end
    
    
    localparam STATE_WAIT           = 0;
    localparam STATE_START          = 1;
  //  localparam STATE_CAL_THD         = 2;
    localparam STATE_LOAD_ROM       = 3;
    localparam STATE_WAIT_ROM       = 4;
    localparam STATE_CALC           = 5;
    localparam STATE_FINISH         = 6;
    localparam CANCEL_OFFSET         = 7;
    localparam NEXT_CAL         = 8;
    localparam STATE_MID=9;
    localparam CAL_SQUAD_ABS =10;
    localparam CAL_ABS =11;
    localparam WAIT_CLK=12;
    localparam WAIT_CLK2=13;
    localparam STATE_MUL=14;
    localparam STATE_MID2=15;
    reg [3:0] state = STATE_WAIT;
    reg start_cal_0,start_CAL2_0,start_power_0,start_mul_1,start_cal_THD_0,start_MUL_0,start_calVoltage;
    wire done1,done2,done3,done4;
    reg [15:0]y;
    wire [23:0]voltage;
    wire [23:0]In1;
    assign ready = (state == STATE_FINISH) ? 1'b1 : 1'b0;
//    assign SIGNAL=sample;
//    assign ABS=abs[tw_addr];
   // assign bin_num=tw_addr;
    
    
    
    integer i;
    always@(posedge clk) begin
        case(state)
            STATE_WAIT: begin
                if(start)
                    state <=CANCEL_OFFSET;
                //if(read)
                 //   state <= STATE_READ;
            end 
            
           CANCEL_OFFSET:begin
            if(signal>16'h7fe8)begin
            y<=signal-16'h7fe8;
            sign<=1'b0;
//            data<={sign,y[14:0]};
            end
            else if(signal==16'h7fe8)begin
            y<=16'h0000;
            sign<=1'b0;
            //data<={16'h0000};
            end
            else begin
            y<=16'h7fe8-signal;
            sign<=1'b1;
           // data<={1'b1,y[14:0]};
            end
            //x<=samples[sample_index];
            state<=STATE_MID2;
            
//            state<=STATE_MUL;
//            start_MUL_0<=1'b1;
           end
           
           STATE_MID2:begin
            data<={sign,y[14:0]};
            state<=STATE_MUL;
            start_MUL_0<=1'b1;
           end

             STATE_MUL:begin
               start_MUL_0<=1'b0;
               if(done3==1'b1)
                begin
                 sample<=out3;
                 x<=samples[sample_index];
                 state<=STATE_START;
                 start_calVoltage<=1'b1;
                end
                end
                
////           STATE_READ: begin
////                for( i=0 ; i<freq_bins ;i=i+1)begin
////                bin_out_real[i] <= frequency_bins_real[i];
////                bin_out_imag[i] <= frequency_bins_imag[i];
////                end
////                state <= STATE_WAIT;
////                end
//           STATE_CAL_THD:begin
//             sum<=sumReal+sumImag;
//             firstReal<=frequency_bins_real[0];
//             firstImag<=frequency_bins_imag[0];
//             state<=STATE_WAIT;
//           end
           STATE_START: begin
             //   START<=1;
                cycles <= cycles + 1; // keep track of how many cycles
                start_calVoltage<=1'b0;
//                sample_num<=sample_num+1;
//                if(sample_num==100)
//                sample_num<=0;
                // get delta: newest - oldest
                //delta <= sample - samples[sample_index];
               // x<=samples[sample_index];
              delta<=diff;
//                if(x[23]==0)
//                  x[23]<=1'b1;
//                else 
//                  x[23]<=1'b0;
//                 x[22]<=1'b1;
            //    if(sample[23]==x[23])begin
//                 delta<={x[23],sample[22:0]};//+x[22:0]};
//                // state <= STATE_CALC;
               //  end
//                else if(sample[22:0]>x[22:0])begin
//                 delta<={sample[23],sample[22:0]-x[22:0]};
//                // state <= STATE_CALC;
//                 end
//                else begin
//                 delta<={x[23],x[22:0]-sample[22:0]};
//                // state <= STATE_CALC;
//                 end
//                // store new sample
               samples[sample_index] <= sample;
//                tw_addr <= 0;
            
             
             state <= STATE_MID;
             
            end
            
            STATE_MID:begin
              start_cal_0<=1'b1;
              start_CAL2_0<=1'b1;
              state <= STATE_CALC;
            end
            
            
            STATE_LOAD_ROM: begin // 2
               
                tw_addr <= tw_addr + 1; 
                if(tw_addr == freq_bins -1) begin
                    tw_addr <= 0;
                    state <= STATE_FINISH;
                end else
                    state <= STATE_WAIT_ROM;
                    
            end

            STATE_WAIT_ROM: begin // 3
               state <= STATE_MID;
            end

           STATE_CALC: begin // 4
             start_cal_0<=1'b0;
             start_CAL2_0<=1'b0;
              if(done1==1'b1)begin
              frequency_bins_real[tw_addr]<=out1;
              state <= WAIT_CLK2;
              end
              if(done2==1'b1)
              frequency_bins_imag[tw_addr]<=out2;
              //start_CAL2_0<=1'b1;
             // start_power_0<=1'b1;
            //  state <=STATE_LOAD_ROM ;
              
           end
           
            WAIT_CLK2:begin
            state<=CAL_SQUAD_ABS;
           end
           
           
           CAL_SQUAD_ABS:begin
            squad_abs[tw_addr]<=squardReal+squardImag;
            state<=WAIT_CLK;
           end
           
           WAIT_CLK:begin
            state<=CAL_ABS;
           end
           
           
           CAL_ABS:begin
          //  bin_num<=tw_addr;
            abs[tw_addr]<=ans1;
            bin_val<=ans1;
            bin_num<=tw_addr;
            state<=STATE_LOAD_ROM;
           end
           


            STATE_FINISH: begin
                // increment sample index (same as rotating)
                sample_index <= sample_index + 1;
                // reset index if it wraps
                if(sample_index == freq_bins)
                    sample_index <= 0;
                 state <=STATE_WAIT;
            end 
//        endcase
//      end            
  endcase
 end

  
   cal cal_0(clk,start_cal_0,frequency_bins_real[tw_addr],delta,twid_real,frequency_bins_imag[tw_addr],twid_imag,out1,done1);
   CAL2 CAL2_0(clk,start_CAL2_0,frequency_bins_real[tw_addr],delta,twid_imag,frequency_bins_imag[tw_addr],twid_real,out2,done2);
   power power_0(clk,frequency_bins_real[tw_addr],squardReal);
   power power_1(clk,frequency_bins_imag[tw_addr],squardImag);
   sqrt sqrt_0(clk,squad_abs[tw_addr],ans1);
   multiply multiply_0(clk,data,start_MUL_0,out3,done3);
   calVoltage f2(clk,start_calVoltage,sample,voltage);
 //  calIn I1(clk,frequency_bins_real[0],frequency_bins_imag[0],In1);
//    calTHD calTHD_0(clk,sum,firstReal,firstImag,THD);
  
new new_0(clk,x,sample,diff);


always @(posedge clk)begin
dout<=voltage;
end

endmodule

