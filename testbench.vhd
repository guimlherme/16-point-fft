library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use ieee.math_real.all; -- used for cos() and math_pi
use work.types.all;

entity testbench  is
end testbench;

architecture testbench_a of testbench is

signal clk	: std_logic := '1' ; -- system clock
signal reset	: std_logic := '1' ; -- reset signal
signal enable	: std_logic := '1' ; -- enable signal


COMPONENT radix16 IS
    PORT( clk, reset, enable: in std_logic;
 		  x : in tab16 ;
		  y : out tab9  );
END COMPONENT radix16;

signal x : tab16 ;
signal y : tab9 ;

begin

  -- clock control
  clk <= not clk after 10 ns;

  -- radix16 instantiation 
  UUT : radix16  port map(clk, reset, enable, x,y);     

  process
  begin

  wait until rising_edge(clk);
  reset <= '0';
  enable <= '0';
  wait until rising_edge(clk);

  reset <= '1';

	for k in integer range 0 to 8 loop
		wait until rising_edge(clk);
		enable <= '1';
		for l in integer range 0 to 15 loop
			x(l) <= to_sfixed(cos(real(l)*real(k)*math_pi/8.0)*0.99,vectorin'left,vectorin'right) ;
		end loop ;
		wait until rising_edge(clk);
		enable <= '0';
		wait for 1 us ;
	end loop ;
  end process ;
end testbench_a;

