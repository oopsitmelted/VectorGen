module pwm_test;

reg clk, reset;
reg [4:0] val;
wire out;

pwm U1 (
  .val(val),
  .out(out),
  .clk(clk),
  .reset(reset)
);

initial
begin
  clk = 0;
  reset = 0;
  val = 30;
  @(posedge clk);
  reset = 1;
  @(posedge clk);
  reset = 0;
end


always 
begin
  #10 clk = ~clk;
end
 
endmodule
