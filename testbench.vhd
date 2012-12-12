library ieee;
use ieee.std_logic_1164.all;

entity test is
end test;

architecture behavior of test is

component brm port (
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
end component;

signal clk: std_logic := '0';
signal strobe: std_logic := '0';
signal enable: std_logic := '0'; 
signal unity_cas: std_logic := '1';
signal clr: std_logic := '1';
signal b: std_logic_vector(5 downto 0);

begin

  u1: brm port map (  clk => clk,
                      strobe => strobe,
                      enable => enable,
                      unity_cas => unity_cas,
                      clr => clr,
                      b => b );

  b <= "000111";
  clr <= '0' after 30ns;
  clk <= not clk after 10ns;

end behavior;
                      
