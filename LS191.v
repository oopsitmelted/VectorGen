// LS191 Counter

module ls191 (
  clk,
  down_up,
  g,
  ld,
  a,
  b,
  c,
  d,
  m_m,
  rip,
  qa,
  qb,
  qc,
  qd );

input clk, down_up, ld, a, b, c, d, g;
output m_m, rip, qa, qb, qc, qd;

reg [3:0] cnt;
reg m_m;

assign { qd, qc, qb, qa } = cnt;
assign rip = ( m_m == 1 ) && ( clk == 1'b0 ) ? 0 : 1;

// Max Min output
always @( cnt or down_up or negedge clk )
  if( ( down_up == 1 && cnt == 4'b0 ) || ( down_up == 0 && cnt == 4'b1111 ) ) 
    m_m = 1;
  else
    m_m = 0;
    
always @( posedge clk or negedge ld )
  if( !ld )
    cnt <= { d, c, b, a };
  else
  if( !g )
    if( down_up == 1 )
      cnt <= cnt - 1;
    else
      cnt <= cnt + 1;

endmodule
