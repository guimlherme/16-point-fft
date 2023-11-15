LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use work.types.all ;

entity sf16_c_register is
    port(
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        d: in tab16_c;
        q: out tab16_c
    );
end sf16_c_register;

architecture sf16_c_register_a of sf16_c_register is

signal current_state: fft_state;

begin
	 
    process(clk)
    begin
        --if (reset = '0') then
            --q <= (others => (others => (others => '0')));
        if rising_edge(clk) then
            if (enable = '1') then
                q <= d;
            end if;
        end if;
    end process;
end architecture sf16_c_register_a;