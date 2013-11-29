`define OP_VCTR_DIV_512  4'h0
`define OP_VCTR_DIV_256  4'h1
`define OP_VCTR_DIV_128  4'h2
`define OP_VCTR_DIV_64   4'h3
`define OP_VCTR_DIV_32   4'h4
`define OP_VCTR_DIV_16   4'h5
`define OP_VCTR_DIV_8    4'h6
`define OP_VCTR_DIV_4    4'h7
`define OP_VCTR_DIV_2    4'h8
`define OP_VCTR_DIV_1    4'h9
`define OP_LABS          4'ha
`define OP_HALT          4'hb
`define OP_JSRL          4'hc
`define OP_RTSL          4'hd
`define OP_JMPL          4'he
`define OP_SVEC          4'hf

`define STATE_RESET       4'h0
`define STATE_1           4'h1
`define STATE_2           4'h2
`define STATE_3           4'h3
`define STATE_4           4'h4
`define STATE_5           4'h5
`define STATE_6           4'h6
`define STATE_7           4'h7
`define STATE_DMA_PUSH    4'h8
`define STATE_DMA_LOAD    4'h9
`define STATE_GO_STROBE   4'ha
`define STATE_HALT_STROBE 4'hb
`define STATE_LATCH_0     4'hc
`define STATE_LATCH_1     4'hd
`define STATE_LATCH_2     4'he
`define STATE_LATCH_3     4'hf

module statemachine_test;

reg clk;
reg reset;
reg [3:0] op;
reg dmago;
reg stop;
integer cnt, delay;

state_machine U1 (
  .clk(clk),
  .reset(reset),
  .op(op),
  .dmacnt(1'b0),
  .dmago(dmago),
  .stop(stop),
  .latch0(latch0),
  .latch1(latch1),
  .latch2(latch2),
  .latch3(latch3),
  .go(go)
);

initial 
begin
  clk = 0;

  // SVEC 

  op = `OP_SVEC;
  stop = 0;
  reset = 1;
  cnt = 0;
  dmago = 0;
  @(posedge clk)
    reset = 0;
  @(posedge clk)
  go_strobe;

  delay = 10;
  wait_clks;

  stop_strobe;

  // LABS
  wait( U1.state == `STATE_LATCH_1 );
  op = `OP_LABS;
  delay = 2;
  wait_clks;

  // JMPL
  wait( U1.state == `STATE_LATCH_1 );
  op = `OP_JMPL;
  delay = 2;
  wait_clks;

  // HALT
  wait( U1.state == `STATE_LATCH_1 );
  op = `OP_HALT;
  delay = 10;
  wait_clks;
  go_strobe;

  // JSRL
  wait( U1.state == `STATE_LATCH_1 );
  op = `OP_JSRL;
  delay = 2;
  wait_clks;
  
  // RTSL
  wait( U1.state == `STATE_LATCH_1 );
  op = `OP_RTSL;
  delay = 2;
  wait_clks;

  // VCTR_DIV_1
  wait( U1.state == `STATE_LATCH_1 );
  op = `OP_VCTR_DIV_1;
  delay = 10;
  wait_clks;
  stop_strobe;

end

always
  #10 clk = !clk;

task wait_clks;
integer cnt;
 
begin
cnt = 0;

while( cnt < delay )
  @(posedge clk)
    cnt = cnt + 1;
end

endtask

task stop_strobe;
  begin
    stop = 1;
    @(posedge clk)
      stop = 0;
  end
endtask

task go_strobe;
  begin
    dmago = 1;
    @(posedge clk)
      dmago = 0;
  end
endtask

endmodule
