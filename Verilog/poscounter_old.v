module poscounter (
  dv,
  go,
  dacout,
  haltstrobe,
  timer0,
  clk,
  reset
);

input [11:0] dv;
input go, clk, reset, haltstrobe, timer0;
output [10:1] dacout;
wire cnt_enable, z_out, enable_out;
wire loadstrobe;
wire go_and_countenable;

reg [12:1] cnt;
reg [10:1] dacout;
reg xvld;

assign loadstrobe = !timer0 && haltstrobe;
assign go_and_countenable = go && cnt_enable;

brm U1 (
  .clk(clk),
  .strobe(enable_out),
  .enable(enable_out),
  .unity_cas(z_out),
  .clr(!go),
  .b({ dv[3:0], 2'b00 }),
  .y(cnt_enable)
);

brm U2 (
  .clk(clk),
  .strobe(!go),
  .enable(!go),
  .unity_cas(1'b1),
  .clr(!go),
  .b(dv[9:4]),
  .z(z_out),
  .enable_out(enable_out)
);

always @( posedge clk )
begin
  if( reset ) 
  begin
    cnt <= 0;
  end 
  else if( loadstrobe ) 
  begin
    cnt <= dv;
  end 
  else if( go_and_countenable )
  begin
//    if( dv[10] )
//    begin
//      cnt <= cnt - 1;
//    end
//    else
//    begin
      cnt <= cnt + 1;
//    end
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
      xvld <= ~cnt[12];
      dacout <= cnt[10:1];
    end
    else
    begin
      xvld <= 0;
      dacout <= {10{~cnt[12]}};
    end
  end
end

endmodule 
