// DVG state machine

// Opcodes

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

// States

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

module state_machine (
  clk,
  reset,
  op,
  dmacnt,
  dmago,
  stop,
  latch0,
  latch1,
  latch2,
  latch3,
  dmaload,
  dmapush,
  haltstrobe,
  go,
  blank
);

input clk;
input reset;
input [3:0] op;
input dmacnt, dmago, stop;
output latch0, latch1, latch2, latch3, go, haltstrobe;
output dmapush, dmaload;
output blank;

reg [3:0] state;
reg [3:0] next_state;
reg halt;
reg go;
reg vctr_op;

wire state_halt;

assign latch0 = ( state == `STATE_LATCH_0 ) ? 1 : 0;
assign latch1 = ( state == `STATE_LATCH_1 ) ? 1 : 0;
assign latch2 = ( state == `STATE_LATCH_2 ) ? 1 : 0;
assign latch3 = ( state == `STATE_LATCH_3 ) ? 1 : 0;
assign dmapush = ( state == `STATE_DMA_PUSH ) ? 1 : 0;
assign dmaload = ( state == `STATE_DMA_LOAD ) ? 1 : 0;
assign haltstrobe = (state == `STATE_HALT_STROBE ) ? 1 : 0;
assign blank = halt || state[3];

assign state_halt = halt || go;

always @( posedge clk )
begin
  if( reset || ( ( op == `OP_HALT ) && ( state == `STATE_HALT_STROBE ) ) )
    halt = 1;
  else
  if( dmago || dmacnt )
    halt = 0;
end

always @( negedge clk )
begin
  if( halt )
    go = 0;
  else
  if( state == `STATE_GO_STROBE )
    go = 1;
  else
  if( stop )
    go = 0;
end

// Vector instruction detector
always @( op )
begin
  if( ( op != `OP_LABS ) && ( op != `OP_HALT ) && ( op != `OP_JSRL ) &&
      ( op != `OP_RTSL ) && ( op != `OP_JMPL ) && ( op != `OP_SVEC ) )
    vctr_op = 1;
  else
    vctr_op = 0;
end

// State Register
always @( posedge clk )
begin
  if( reset )
    state <= `STATE_RESET;
  else
    state <= next_state;
end

// Next State Logic
always @( op or state or state_halt or vctr_op )
begin
  next_state = state;
  case( state )
    `STATE_RESET:
      if( !state_halt )
        next_state = `STATE_DMA_LOAD;
    `STATE_1:
      if( !state_halt )
        next_state = `STATE_2;
    `STATE_2:
      next_state = `STATE_LATCH_1;
    `STATE_3:
      next_state = `STATE_LATCH_1;
    `STATE_4:
      next_state = `STATE_5;
    `STATE_5:
      next_state = `STATE_6;
    `STATE_6:
      next_state = `STATE_7;
    `STATE_7:
      next_state = `STATE_LATCH_1;
    `STATE_DMA_PUSH:
      if( op == `OP_HALT )
        next_state = `STATE_HALT_STROBE;
      else
        next_state = `STATE_DMA_LOAD;
    `STATE_DMA_LOAD:
      next_state = `STATE_LATCH_1;
    `STATE_GO_STROBE:
      next_state = `STATE_1;
    `STATE_HALT_STROBE:
      if( op == `OP_LABS )
        next_state = `STATE_LATCH_1;
      else
        next_state = `STATE_RESET;
    `STATE_LATCH_0:
      if( op == `OP_SVEC )
        next_state = `STATE_GO_STROBE;
      else
      if( vctr_op || op == `OP_LABS )
        next_state = `STATE_LATCH_3;
      else
      if( ( op == `OP_JMPL ) || ( op == `OP_RTSL ) )
        next_state = `STATE_DMA_LOAD;
      else
        next_state = `STATE_DMA_PUSH;
    `STATE_LATCH_1:
      next_state = `STATE_LATCH_0;
    `STATE_LATCH_2:
      if( op == `OP_LABS )
        next_state = `STATE_HALT_STROBE;
      else
        next_state = `STATE_GO_STROBE;
    `STATE_LATCH_3:
      next_state = `STATE_LATCH_2;
    default:
      next_state = `STATE_RESET;
  endcase
end

endmodule
