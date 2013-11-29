module adc_shift_test;

reg clk, shift_clk;
reg reset;
reg [7:0] reg_0_in, reg_1_in, reg_2_in;
reg [4:0] clk_div;

wire reg_0_out, reg_1_out, reg_2_out, adc_strobe;

adc_shift U1(
  .clk(clk),
  .shift_clk(shift_clk),
  .reset(reset),
  .reg_0_in(reg_0_in),
  .reg_1_in(reg_1_in),
  .reg_2_in(reg_2_in),
  .reg_0_out(reg_0_out),
  .reg_1_out(reg_1_out),
  .reg_2_out(reg_2_out),
  .adc_strobe(adc_strobe)
);

initial
begin
  clk = 0;
  shift_clk = 0;
  reset = 0;
  clk_div = 0;
  reg_0_in = 8'hab;
  reg_1_in = 8'hcd;
  reg_2_in = 8'hef;

  @(posedge shift_clk)
  reset = 1;
  @(posedge shift_clk)
  reset = 0;

end

always
  #10 shift_clk = ~shift_clk;

always @( posedge shift_clk )
begin
  if( clk_div == 9 )
  begin
    clk_div <= 0;
    clk <= ~clk;
  end
  else
    clk_div = clk_div + 1;
end

endmodule
