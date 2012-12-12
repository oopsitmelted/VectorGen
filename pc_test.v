module pc_test;

reg clk;
reg reset;
reg dmaload, dmapush;
reg latch0, latch2;
reg [11:0] count_in;
reg load_pc;
integer cnt;

wire [11:0] count_out;

pc U1(
  .dmaload(dmaload),
  .dmapush(dmapush),
  .count_in(count_in),
  .count_out(count_out),
  .latch0(latch0),
  .latch2(latch2),
  .load_pc(load_pc),
  .reset(reset),
  .clk(clk)
);

initial
begin
  clk = 0;
  reset = 0;
  dmaload = 0;
  dmapush = 0;
  latch0 = 0;
  latch2 = 0;
  count_in = 0;
  load_pc = 0;

  @(posedge clk);
  reset = 1;
  @(posedge clk);
  reset = 0;

  count_in = 12'habc;
  dmaload = 1;
  load_pc = 1;
  @(posedge clk);
  dmaload = 0; 
  load_pc = 0;

  latch0 = 1;
  for( cnt = 0; cnt < 3; cnt = cnt + 1 )
  begin
    @(posedge clk);
  end
  latch0 = 0;

  @(posedge clk);
  dmapush = 1;
  @(posedge clk);
  dmapush = 0;
  @(posedge clk);
  count_in = 12'hdef;
  load_pc = 1;
  dmaload = 1;
  @(posedge clk);
  load_pc = 0;
  dmaload = 0;
  
  @(posedge clk);
  dmapush = 1;
  @(posedge clk);
  dmapush = 0;

  count_in = 12'h123;
  load_pc = 1;
  dmaload = 1;
  @(posedge clk);
  load_pc = 0;
  dmaload = 0;

  latch0 = 1;
  for( cnt = 0; cnt < 3; cnt = cnt + 1 )
  begin
    @(posedge clk);
  end
  latch0 = 0;

  @(posedge clk);
  dmaload = 1;
  @(posedge clk);
  dmaload = 0;

  @(posedge clk);
  dmaload = 1;
  @(posedge clk);
  dmaload = 0;
end

always
  #10 clk = ~clk;

endmodule
