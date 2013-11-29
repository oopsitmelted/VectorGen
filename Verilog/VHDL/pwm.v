module pwm(
  val,
  out,
  clk,
  reset
);

input [4:0] val;
input clk, reset;
output out;

reg [4:0] cnt;
reg out;

always @( posedge clk )
begin
  if( reset )
    cnt <= 0;
  else
    cnt <= cnt + 1;
end

always @( posedge clk )
begin
  if( reset )
    out <= 0;
  else
  begin
    if( cnt < val )
      out <= 1;
    else
      out <= 0;
  end
end

endmodule
