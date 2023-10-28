LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use work.types.all ;

entity radix_16_state_machine is
    port(
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        state: out fft_state
    );
end radix_16_state_machine;

architecture radix_16_state_machine_a of radix_16_state_machine is

signal current_state: fft_state;

begin
    
    state <= current_state;
	 
    process(clk, reset)
    begin
        if (reset = '0') then
            current_state <= Calc00;
        elsif rising_edge(clk) then
            if ((current_state = Calc00) and (enable = '1')) then
                current_state <= Calc01;
            else
                case current_state is
                    when Calc00 =>
                    current_state <= current_state;
                    when Calc01 =>
                    current_state <= Calc02;
                    when Calc02 =>
                    current_state <= Calc03;
                    when Calc03 =>
                    current_state <= Calc10;
                    when Calc10 =>
                    current_state <= Calc11;
                    when Calc11 =>
                    current_state <= Calc12;
                    when Calc12 =>
                    current_state <= Calc13;
                    when Calc13 =>
                    current_state <= Calc00;
                end case;
				end if;
        end if;
    end process;
end architecture radix_16_state_machine_a;