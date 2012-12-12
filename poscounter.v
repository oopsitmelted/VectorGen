module poscounter (
  dv,
  go,
  dacout,
  haltstrobe,
  timer0,
  clk,
  reset,
  vld
);

input [11:0] dv;
input go, clk, reset, haltstrobe, timer0;
output [10:1] dacout;
output vld;
wire loadstrobe;

reg  [21:0] acc;
wire [12:1] cnt;
reg  [10:1] dacout;
reg vld;

assign loadstrobe = !timer0 && haltstrobe;
assign cnt = acc[21:10];

always @( posedge clk )
begin
  if( reset )
    acc <= 0;
  else if( loadstrobe )
    acc[21:10] <= dv;
  else if( go )
  begin
    if( !dv[10] )
      acc = acc + dv[9:0];
    else
      acc = acc - dv[9:0];
  end
end

always @( negedge clk )
begin
  if( reset )
    dacout <= 0;
  else
  begin
    if( !cnt[11] )
    begin
      vld <= ~cnt[12];
      dacout <= cnt[10:1];
    end
    else
    begin
      vld <= 0;
      dacout <= {10{~cnt[12]}};
    end
  end
end

endmodule
