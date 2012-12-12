// Binary rate multiplier - Based on TI 7497 design

module brm (
  clk,
  strobe,
  enable,
  unity_cas,
  clr,
  b,
  z,
  y,
  enable_out );

input clk, strobe, enable, unity_cas, clr;
input [5:0] b;
output z, y, enable_out;

reg d0_out, d1_out, d2_out, d3_out, d4_out, d5_out;
wire a0_out, a1_out, a2_out, a3_out, a4_out;
wire d0_next, d1_next, d2_next, d3_next, d4_next, d5_next;
wire aa_out, ab_out, ac_out, ad_out, ae_out, af_out;
wire not_enable;
wire nor0_out, nor1_out;

always @( posedge clk or posedge clr )
  if( clr ) 
  begin
    d0_out <= 1'b0;
    d1_out <= 1'b0;
    d2_out <= 1'b0;
    d3_out <= 1'b0;
    d4_out <= 1'b0;
    d5_out <= 1'b0;
  end
  else
  begin
    d0_out <= d0_next;
    d1_out <= d1_next;
    d2_out <= d2_next;
    d3_out <= d3_next;
    d4_out <= d4_next;
    d5_out <= d5_next;
  end

assign not_enable = ~enable;

assign a0_out = not_enable & d0_out;
assign a1_out = a0_out & d1_out;
assign a2_out = a1_out & d2_out;
assign a3_out = a2_out & d3_out;
assign a4_out = a3_out & d4_out;
assign #5 enable_out = not_enable & d0_out & d1_out & d2_out &
  d3_out & d4_out & d5_out;
assign nor0_out = ~( clk | strobe );

assign af_out = b[5] & nor0_out & ~d0_out;
assign ae_out = b[4] & nor0_out & d0_out & ~d1_out;
assign ad_out = b[3] & nor0_out & d0_out & d1_out & ~d2_out;
assign ac_out = b[2] & nor0_out & d0_out & d1_out & d2_out & ~d3_out;
assign ab_out = b[1] & nor0_out & d0_out & d1_out & d2_out & d3_out & ~d4_out;
assign aa_out = b[0] & nor0_out & d0_out & d1_out & d2_out & d3_out & d4_out & ~d5_out;

assign nor1_out = ~( aa_out | ab_out | ac_out | ad_out | ae_out | af_out );
assign #5 z = nor1_out;
assign #5 y = ~( nor1_out & unity_cas );

assign d0_next = not_enable ? ~d0_out : d0_out;
assign d1_next = a0_out ? ~d1_out : d1_out;
assign d2_next = a1_out ? ~d2_out : d2_out;
assign d3_next = a2_out ? ~d3_out : d3_out;
assign d4_next = a3_out ? ~d4_out : d4_out;
assign d5_next = a4_out ? ~d5_out : d5_out;

endmodule
