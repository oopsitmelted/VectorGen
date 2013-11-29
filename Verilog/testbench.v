module brm_test;

reg clk;
reg clr;

brm U1 (
  .clk(clk),
  .strobe(1'b0),
  .enable(1'b0),
  .unity_cas(1'b1),
  .clr(clr),
  .b(6'b001011)
);

initial
begin
  clk = 0;
  clr = 0;
  #5 clr = 1;
  #5 clr = 0;
end

always
  #1 clk = !clk;

endmodule
