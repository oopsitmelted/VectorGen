module poscounter_test;

reg clk, reset;
reg [9:0] cyclecnt;
reg go, timer0, haltstrobe;
reg [11:0] dv;
wire [10:1] dacout;

poscounter U1 (
  .dv(dv),
  .go(go),
  .dacout(dacout),
  .haltstrobe(haltstrobe),
  .timer0(timer0),
  .clk(clk),
  .reset(reset)
);

initial
begin
  clk = 0;
  reset = 0;
  go = 0;
  timer0 = 0;
  haltstrobe = 0;
  dv = 0;
  cyclecnt = 0;

  @(posedge clk);
  reset = 1;
  @(posedge clk);
  reset = 0;
  haltstrobe = 1;
  dv = 10'd514;
  @(posedge clk);
  cyclecnt = 0;
  haltstrobe = 0;
  dv = 10'd200;
  dv[10] = 1;
  go = 1;
end

always
  #10 clk = ~clk;

always @(posedge clk )
begin
  cyclecnt <= cyclecnt + 1;
end
endmodule
