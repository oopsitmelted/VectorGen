module vectorgen (
  clkin,
  state_clk_out,
  pll_out,
  shift_out_0,
  shift_out_1,
  shift_out_2,
  adc_strobe
);

input clkin;
output state_clk_out, shift_out_0, shift_out_1, shift_out_2, adc_strobe;
output pll_out;

reg [7:0] latch0_reg, latch1_reg, latch2_reg, latch3_reg;
reg [6:0] clkdiv;
reg [3:0] reset_ctr;
reg clk, reset, dmacnt, dmago;

wire [12:0] read_addr;
wire [11:0] count_out;
wire [7:0] rom_out, ram_out, mem_out;
wire [3:0] scale;
wire [11:0] dvx;
wire [11:0] dvy;
wire [3:0] timer;
wire [9:0] xdac, ydac;
wire [3:0] zdac;
wire dmaload, dmapush;
wire latch0, latch1, latch2, latch3;
wire a0;
wire go, stop;
wire haltstrobe, alphanum;
wire pll_out;
wire xvld, yvld, bvld;
wire blank;

//wire clk;

assign state_clk_out = clk;
assign a0 = latch1 || latch3;
assign read_addr = { count_out, a0 };
assign bvld = xvld && yvld;
assign zdac = (!bvld && blank) ? 4'h0 : (4'hf - scale);

/* Memory Map:
 * 0x0000 -- 0x03FF - Vector RAM
 * 0x1000 -- 0x17FF - Vector ROM
 */
assign mem_out = read_addr[12] ? rom_out : ram_out;

assign scale = latch3_reg[7:4];
assign dvx = { latch3_reg[3:0], latch2_reg };
assign timer = latch1_reg[7:4];
assign dvy = { latch1_reg[3:0], latch0_reg };

initial
begin
  reset_ctr = 0;
  dmacnt = 0;
  dmago = 0;
  reset = 0;
  clkdiv = 0;
end

mainpll pll1 (
  .inclk0(clkin),
  .c0(pll_out)
);

/* Divide 30 MHz PLL clock by 20 to get 1.5 MHz system clock */
always @(posedge pll_out)
begin
  if( clkdiv == 7'd9 )
  begin
    clkdiv <= 0;
    clk <= ~clk;
  end
  else
    clkdiv <= clkdiv + 1;
end

//assign clk = clkin;

state_machine U1 (
  .clk(clk),
  .reset(reset),
  .op(timer),
  .dmacnt(dmacnt),
  .dmago(dmago),
  .stop(stop),
  .latch0(latch0),
  .latch1(latch1),
  .latch2(latch2),
  .latch3(latch3),
  .dmaload(dmaload),
  .dmapush(dmapush),
  .haltstrobe(haltstrobe),
  .go(go),
  .blank(blank)
);

pc U2 (
  .dmaload(dmaload),
  .dmapush(dmapush),
  .count_in( {latch1_reg[3:0], latch0_reg} ),
  .count_out(count_out),
  .latch0(latch0),
  .latch2(latch2),
  .load_pc(~latch1_reg[4]),
  .reset(reset),
  .clk(clk)
);

vectorrom U3 (
  .address( read_addr[10:0] ),
  .clock(~clk),
  .q(rom_out)
);

vectorram U4 (
  .address( read_addr[9:0] ),
  .clock(~clk),
  .q(ram_out)
);

vec_timer U5 (
  .timer_val(timer),
  .dvx11(dvx[11]),
  .dvy11(dvy[11]),
  .scale(scale),
  .latch2(latch2),
  .go(go),
  .stop(stop),
  .alphanum(alphanum),
  .clk(clk),
  .reset(reset)
);

poscounter pos_x (
  .dv(dvx),
  .go(go),
  .dacout(xdac),
  .haltstrobe(haltstrobe),
  .timer0(timer[0]),
  .clk(clk),
  .reset(reset),
  .vld(xvld)
);

poscounter pos_y (
  .dv(dvy),
  .go(go),
  .dacout(ydac),
  .haltstrobe(haltstrobe),
  .timer0(timer[0]),
  .clk(clk),
  .reset(reset),
  .vld(yvld)
);

adc_shift dac_out (
  .clk(clk),
  .shift_clk(pll_out),
  .reset(reset),
  .reg_0_in(xdac[9:2]),
//  .reg_0_in(8'hff),
  .reg_1_in({xdac[1:0],ydac[0],ydac[1],ydac[2],ydac[3],ydac[4],ydac[5]}),
//  .reg_1_in(8'hc0),
  .reg_2_in({ydac[6],ydac[7], ydac[8], ydac[9], zdac[3:0]}),
//  .reg_2_in(8'h0f),
  .reg_0_out(shift_out_0),
  .reg_1_out(shift_out_1),
  .reg_2_out(shift_out_2),
  .adc_strobe(adc_strobe)
);

always @(posedge clk)
begin
  if( reset || dmago || alphanum )
    latch0_reg <= 0;
  else
    if( latch0 )
      latch0_reg <= mem_out;
end

always @(posedge clk)
begin
  if( reset || dmago )
    latch1_reg <= 0;
  else
    if( latch1 )
      latch1_reg <= mem_out;
end

always @(posedge clk)
begin
  if( reset || alphanum )
    latch2_reg <= 0;
  else
    if( latch2 )
      latch2_reg <= mem_out;
end

always @(posedge clk)
begin
  if( reset )
    latch3_reg <= 0;
  else
    if( latch3 || ( latch0 && alphanum ) )
      latch3_reg <= mem_out;
end

// Power on reset
always @(posedge clk)
begin
  if( reset_ctr < 15 )
  begin
    reset_ctr <= reset_ctr + 1;
  end

  if( reset_ctr < 10 )
    reset <= 1;
  else
    reset <= 0;

  if( reset_ctr == 14 )
    dmago = 1;
  else
  if( reset_ctr == 15 )
    dmago = 0;
end

endmodule
