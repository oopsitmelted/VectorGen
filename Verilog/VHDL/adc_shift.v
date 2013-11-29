`define STATE_WAIT    2'h0
`define STATE_SHIFT   2'h1
`define STATE_STROBE  2'h2
`define STATE_STROBE2 2'h3

module adc_shift (
  clk,
  shift_clk,
  reset,
  reg_0_in,
  reg_1_in,
  reg_2_in,
  reg_0_out,
  reg_1_out,
  reg_2_out,
  adc_strobe
);

input clk, shift_clk, reset;
input [7:0] reg_0_in, reg_1_in, reg_2_in;
output reg_0_out, reg_1_out, reg_2_out, adc_strobe;

reg [7:0] reg_0, reg_1, reg_2;
reg [1:0] state, next_state;
reg [3:0] shift_cnt;

reg prev_clk_val;
reg adc_strobe;

wire reg_0_out, reg_1_out, reg_2_out;

assign reg_0_out = reg_0[7];
assign reg_1_out = reg_1[7];
assign reg_2_out = reg_2[7];

// State register
always @( posedge shift_clk )
begin
  if( reset )
    state <= `STATE_WAIT;
  else
    state <= next_state;
end

// ADC Strobe
always @( negedge shift_clk )
begin
  if( state == `STATE_STROBE2 )
    adc_strobe <= 1;
  else
    adc_strobe <= 0;
end

// Counter and Shifters
always @( posedge shift_clk )
begin
  if( reset )
  begin
    prev_clk_val <= 0;
    shift_cnt <= 0;
    reg_0 <= 0;
    reg_1 <= 0;
    reg_2 <= 0;
  end
  else
  begin
    prev_clk_val <= clk;
 
    if( state == `STATE_SHIFT )
    begin
      if( shift_cnt < 7 )
      begin
        reg_0 <= { reg_0[6:0], 1'b0 };
        reg_1 <= { reg_1[6:0], 1'b0 };
        reg_2 <= { reg_2[6:0], 1'b0 };
      end
      shift_cnt <= shift_cnt + 1;
    end
    else
    begin
      reg_0 <= reg_0_in;
      reg_1 <= reg_1_in;
      reg_2 <= reg_2_in;
      shift_cnt <= 0;
    end
  end
end

// Next State Logic
always @( state or prev_clk_val or clk or shift_cnt )
begin
  next_state = state;
  case( state )
    `STATE_WAIT:
      if( prev_clk_val == 1'b0 && clk == 1'b1 )
        next_state = `STATE_SHIFT;
    `STATE_SHIFT:
      if( shift_cnt == 7 )
        next_state = `STATE_STROBE;
    `STATE_STROBE:
      next_state = `STATE_STROBE2;
    `STATE_STROBE2:
      next_state = `STATE_WAIT;
    default:
      next_state = `STATE_WAIT;
  endcase
end

endmodule
