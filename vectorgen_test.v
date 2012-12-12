`timescale 1 ps / 1 ps

module vectorgen_test;

reg clkin;
wire state_clk_out, xdac_hi_out, xdac_lo_out, ydac_hi_out, ydac_lo_out;

vectorgen U1 (
  .clkin(clkin),
  .state_clk_out(state_clk_out),
  .xdac_hi_out(xdac_hi_out),
  .xdac_lo_out(xdac_lo_out),
  .ydac_hi_out(ydac_hi_out),
  .ydac_lo_out(ydac_lo_out)
);

initial
begin
  clkin = 0;
end

always
begin
  #10000 clkin = ~clkin;
end

endmodule
