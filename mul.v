module mul(input clk,input [23:0]a,b,input en,output reg[23:0]out,output done);
reg sign;
reg [45:0]x;

localparam S_IDLE=1;
localparam S_MID=2;
localparam S_MID2=4;
localparam FINISH=3;
reg [2:0]state=S_IDLE;
assign done=(state==FINISH)?1:0;
always@(posedge clk)begin
case(state)
  S_IDLE:begin
    if(en==1)
     state<=S_MID;
  end
  S_MID:begin
  if(a[23]==b[23])
   sign=1'b0;
  else
   sign=1'b1;
   
   x=(a[22:0]*b[22:0])>>12;
  // out<={sign,x[22:0]};
  // state<=FINISH;
   state<=S_MID2;
  end
  
  S_MID2:begin
   out<={sign,x[22:0]};
   state<=FINISH;
  end
  
  FINISH:begin
    //   done<=1'b1;
       state<=S_IDLE;
    end
 
 
  
// x=x>>12;
//  out[22:0]=x[22:0];
//  out[23]=sign;

 endcase
// if(en==2)
//  state=3;
// else
//  state=4;
end


endmodule
