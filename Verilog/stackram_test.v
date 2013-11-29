module stackram_test;

integer cnt;
wire [11:0] q;
reg [1:0] a;
reg [11:0] d;
reg we;
reg clk;

stackram U1 (
  .q(q),
  .a(a),
  .d(d),
  .we(we),
  .clk(clk)
);

initial
begin

  clk = 0;
  a = 0;
  d = 0;
  we = 1;

  for( cnt = 0; cnt < 4; cnt = cnt + 1 )
  begin
    @(posedge clk )
    begin
      d = d + 1;
      a = a + 1;
    end
  end

  we = 0;
  a = 0;

  for( cnt = 0; cnt < 4; cnt = cnt + 1 )
  begin
    @(posedge clk )
    begin
      a = a + 1;
    end
  end

end

always
  #10 clk = ~clk;

endmodule
