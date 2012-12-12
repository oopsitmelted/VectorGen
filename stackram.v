module stackram (
  q,
  a,
  d,
  we,
  clk
);

output [11:0] q;
input [1:0] a;
input [11:0] d;
input we, clk;

reg [11:0] mem [3:0];
wire [11:0] q;

assign q = mem[a];

always @(negedge clk )
begin
  if( we )
    mem[a] <= d;
end
endmodule
