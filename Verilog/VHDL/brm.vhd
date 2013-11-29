-- Binary Rate Multiplier - Based on TI 7497 Design

library ieee;
use ieee.std_logic_1164.all;

entity brm is port
(
  clk:        in std_logic;
  strobe:     in std_logic;
  enable:     in std_logic;
  unity_cas:  in std_logic;
  clr:        in std_logic;
  b:          in std_logic_vector(5 downto 0);
  z:          out std_logic;
  y:          out std_logic;
  enable_out: out std_logic
);
end brm;

architecture synthesis of brm is

signal a0_out, a1_out, a2_out, a3_out, a4_out: std_logic;
signal d0_out, d1_out, d2_out, d3_out, d4_out, d5_out: std_logic;
signal d0_next, d1_next, d2_next, d3_next, d4_next, d5_next: std_logic;
signal aa_out, ab_out, ac_out, ad_out, ae_out, af_out: std_logic;
signal not_enable: std_logic;
signal nor0_out: std_logic;
signal nor1_out: std_logic;

begin

not_enable <= not enable;
a0_out <= not_enable and d0_out;
a1_out <= a0_out and d1_out;
a2_out <= a1_out and d2_out;
a3_out <= a2_out and d3_out;
a4_out <= a3_out and d4_out;
enable_out <= not_enable and d0_out and d1_out and d2_out and 
              d3_out and d4_out and d5_out;
nor0_out <= clk nor strobe;

af_out <= b(5) and nor0_out and not d0_out;
ae_out <= b(4) and nor0_out and d0_out and not d1_out;
ad_out <= b(3) and nor0_out and d0_out and d1_out and not d2_out;
ac_out <= b(2) and nor0_out and d0_out and d1_out and d2_out and not d3_out;
ab_out <= b(1) and nor0_out and d0_out and 
          d1_out and d2_out and d3_out and not d4_out;
aa_out <= b(0) and nor0_out and d0_out and 
          d1_out and d2_out and d3_out and d4_out and not d5_out;

nor1_out <= not ( aa_out or ab_out or ac_out or ad_out or ae_out or af_out );
z <= nor1_out;
y <= nor1_out nand unity_cas;

process ( clk, clr ) begin
  if clr = '1' then
    d0_out <= '0'; 
    d1_out <= '0'; 
    d2_out <= '0'; 
    d3_out <= '0'; 
    d4_out <= '0'; 
    d5_out <= '0'; 
  elsif clk'event and clk = '1' then
    d0_out <= d0_next;
    d1_out <= d1_next;
    d2_out <= d2_next;
    d3_out <= d3_next;
    d4_out <= d4_next;
    d5_out <= d5_next;
  end if;
end process;

d0_next <= not d0_out when not_enable = '1' else d0_out;
d1_next <= not d1_out when a0_out = '1' else d1_out;
d2_next <= not d2_out when a1_out = '1' else d2_out;
d3_next <= not d3_out when a2_out = '1' else d3_out;
d4_next <= not d4_out when a3_out = '1' else d4_out;
d5_next <= not d5_out when a4_out = '1' else d5_out;

end synthesis;
