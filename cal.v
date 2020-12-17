module cal(
input clk,en,input [23:0]frequency_bins_real,delta,twid_real,frequency_bins_imag,twid_imag,output reg [23:0]out,output done
    );

//wire start;
reg [23:0]answerA,answerB,Ans;
//assign start=(en==1) ? 1'b1:1'b0;
assign done=(state==STATEMID)? 1'b1:1'b0;
localparam STATEWAIT=0;
localparam ADD_FREQBINREAL_AND_DELTA=1;
localparam MUL_ANSWERA_AND_TWIDREAL=2;
localparam MUL_FREQBINIMAG_AND_TWIDIMAG=3;
localparam SUB_ANSWERA_B=4;
localparam STATEOUT=5;
localparam STATEMID=6;

reg [3:0]state=STATEWAIT;
reg start_add_0,start_mul_0,start_mul_1,start_sub_0;
wire [23:0]answer1,answer2,answer3,answer4;
//wire [23:0]answer2;
wire done1,done2,done3,done4;
always @(posedge clk)
begin
 case(state)
  STATEWAIT:begin
   if(en)begin
    start_add_0<=1;
    state<=ADD_FREQBINREAL_AND_DELTA;end
   end
   ADD_FREQBINREAL_AND_DELTA:begin
    start_add_0<=0;
    if(done1==1)begin
    answerA<=answer1;
    start_mul_0<=1;
    state<=MUL_ANSWERA_AND_TWIDREAL;
    end
   end
  MUL_ANSWERA_AND_TWIDREAL:begin
     start_mul_0<=0;
     if(done2==1)begin
     answerA<=answer2;
     start_mul_1<=1;
     state<=MUL_FREQBINIMAG_AND_TWIDIMAG;
     end
  end
  MUL_FREQBINIMAG_AND_TWIDIMAG:begin
     start_mul_1<=0;
     if(done3==1)begin
     answerB<=answer3;
     start_sub_0<=1;
     state<=SUB_ANSWERA_B;
     end
     end
  SUB_ANSWERA_B:begin
    start_sub_0<=0;
      if(done4==1)begin
     Ans<=answer4;
    // start_sub_0<=1;
     state<=STATEOUT;
     end
  end
  STATEOUT:begin
   out<=Ans;
   //nextState<=8;
   state<=STATEMID;
  end
  STATEMID:begin
   state<=STATEWAIT;
  end
 endcase
end

add add_0(clk,frequency_bins_real,delta,start_add_0,answer1,done1);//state,answerA);//state);
mul mul_0(clk,answerA,twid_real,start_mul_0,answer2,done2);
mul mul_1(clk,frequency_bins_imag,twid_imag,start_mul_1,answer3,done3);
sub sub_0(clk,answerA,answerB,start_sub_0,answer4,done4);

endmodule


