module vec_timer (
  timer_val,
  dvx11,
  dvy11,
  scale,
  latch2,
  go,
  stop,
  alphanum,
  clk,
  reset
);

input [3:0] timer_val;
input [3:0] scale;
input dvx11,dvy11;
input latch2, go, clk, reset;
output stop, alphanum;

reg [11:0] count;
reg [3:0] scale_reg;
wire alphanum;
wire [11:0] count_in;
wire [3:0] mux_out;
wire [3:0] timer_sum;
wire [9:0] decoder_out;

assign alphanum = ( timer_val == 4'hf );
assign mux_out = alphanum ? { 1'h0, dvx11, ~dvx11, dvy11 } : timer_val;
assign timer_sum = mux_out + scale_reg;
assign decoder_out = ~(10'h1 << timer_sum );
assign count_in = { 1'b1, decoder_out, 1'b1 };
assign stop = ( count == 12'hFFF );

always @(posedge clk)
begin
  if( !go )
    count <= count_in;
  else
    count <= count + 1;
end

always @(posedge clk)
begin
  if( reset )
    scale_reg <= 0;
  else
    if( latch2 && timer_val[3] && timer_val[1] )
      scale_reg <= scale;
end

endmodule
