module pc (
  dmaload,
  dmapush,
  count_in,
  count_out,
  latch0,
  latch2,
  load_pc,
  reset,
  clk
);

output [11:0] count_out;
input  [11:0] count_in;
input dmaload, dmapush;
input latch0, latch2;
input load_pc;
input clk;
input reset;

reg [11:0] cnt;
reg [1:0] stack_cnt;
wire [11:0] stack_out;

assign count_out = cnt;

stackram U1 (
  .q(stack_out),
  .a(stack_cnt),
  .d(cnt),
  .we(dmapush),
  .clk(clk)
);

always @(posedge clk)
begin
  if( reset )
    cnt <= 0;
  else
  if( dmaload )
    if( load_pc )
      cnt <= count_in;
    else
      cnt <= stack_out;
  else
    if( latch0 || latch2 )
      cnt <= cnt + 1;
end

always @(negedge clk)
begin
  if( reset )
    stack_cnt <= 0;
  else
  if( dmapush ) 
    stack_cnt <= stack_cnt + 1;
  else
    if( dmaload && !load_pc )
      stack_cnt <= stack_cnt - 1;
end

endmodule
