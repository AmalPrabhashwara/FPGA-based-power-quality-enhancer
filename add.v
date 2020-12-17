module add(
input clk,input [23:0]a,b,input en,output reg[23:0]out,output done
    );
    
localparam S_IDLE=1;
localparam S_MID=2;
localparam FINISH=3;
reg [2:0]state=S_IDLE;
assign done=(state==FINISH)?1:0;
always @(posedge clk)begin
case(state)
    S_IDLE:begin
     if((en==1))//||(en==4))begin
      state<=S_MID;
      end
    S_MID:begin
       if(a[23]==b[23])
        out={a[23],a[22:0]+b[22:0]};
       else if(a[22:0]>b[22:0])
        out={a[23],a[22:0]-b[22:0]};
       else if(a[22:0]<b[22:0])
        out={b[23],b[22:0]-a[22:0]};
       else
         out<=24'h000000;
        state<=FINISH;
       end
    FINISH:begin
     //  done<=1'b1;
       state<=S_IDLE;
    end
 
//  if(en==1)
//  state=2;
//  else
//  state=5;

endcase
end
endmodule
