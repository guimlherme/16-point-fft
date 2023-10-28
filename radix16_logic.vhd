LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use work.types.all ;

entity radix_16_logic is
    port(
        enable: in std_logic;
        state: in fft_state;
        input_radix16: in tab16; -- careful ! not complex
        from_mult: in tab4_c;
        from_register: in tab16_c;
        reg_enable: out std_logic;
        to_radix: out tab4_c;
        to_register: out tab16_c;
        output: out tab9_c
    );
end radix_16_logic;

architecture radix_16_logic_a of radix_16_logic is
signal zero_sfixed : vectorin;
begin
    zero_sfixed <= to_sfixed(0, zero_sfixed);
    process(state, input_radix16, from_mult, from_register)
    begin

        -- Set default values
        reg_enable <= '1';
        to_register <= from_register;
        to_radix(0)(0) <= input_radix16(0);
        to_radix(1)(0) <= input_radix16(4);
        to_radix(2)(0) <= input_radix16(8);
        to_radix(3)(0) <= input_radix16(12);
        for i in to_radix'range loop
            to_radix(i)(1) <= zero_sfixed;
        end loop;
        output <= (from_register(0), from_register(4), from_register(8), from_register(12), from_register(1), from_register(5), from_register(9), from_register(13), from_register(2));
        
        -- Set values by state
        case state is
            when Calc00 =>
                if (enable = '0') then
                    reg_enable <= '0'; -- hold the last calculation
                end if;
                for i in to_register'range loop
                    to_register(i)(0) <= input_radix16(i);
                    to_register(i)(1) <= zero_sfixed;
                end loop;
                to_register(0) <= from_mult(0);
                to_register(4) <= from_mult(1);
                to_register(8) <= from_mult(2);
                to_register(12) <= from_mult(3);
                -- to_radix will be default value
                -- output will be default value
            when Calc01 =>
                to_register(1) <= from_mult(0);
                to_register(5) <= from_mult(1);
                to_register(9) <= from_mult(2);
                to_register(13) <= from_mult(3);
                to_radix <= (from_register(1),from_register(5),from_register(9),from_register(13));
            when Calc02 =>
                to_register(2) <= from_mult(0);
                to_register(6) <= from_mult(1);
                to_register(10) <= from_mult(2);
                to_register(14) <= from_mult(3);
                to_radix <= (from_register(2), from_register(6), from_register(10), from_register(14));
            when Calc03 =>
                to_register(3) <= from_mult(0);
                to_register(7) <= from_mult(1);
                to_register(11) <= from_mult(2);
                to_register(15) <= from_mult(3);
                to_radix <= (from_register(3), from_register(7), from_register(11), from_register(15));
            when Calc10 =>
                to_register(0) <= from_mult(0);
                to_register(1) <= from_mult(1);
                to_register(2) <= from_mult(2);
                to_register(3) <= from_mult(3);
                to_radix <= (from_register(0), from_register(1), from_register(2), from_register(3));
            when Calc11 =>
                to_register(4) <= from_mult(0);
                to_register(5) <= from_mult(1);
                to_register(6) <= from_mult(2);
                to_register(7) <= from_mult(3);
                to_radix <= (from_register(4), from_register(5), from_register(6), from_register(7));
            when Calc12 =>
                to_register(8) <= from_mult(0);
                to_register(9) <= from_mult(1);
                to_register(10) <= from_mult(2);
                to_register(11) <= from_mult(3);
                to_radix <= (from_register(8), from_register(9), from_register(10), from_register(11));
            when Calc13 =>
                to_register(12) <= from_mult(0);
                to_register(13) <= from_mult(1);
                to_register(14) <= from_mult(2);
                to_register(15) <= from_mult(3);
                to_radix <= (from_register(12), from_register(13), from_register(14), from_register(15));
                output <= (from_register(0), from_register(4), from_register(8), from_mult(0), from_register(1), from_register(5), from_register(9), from_mult(1), from_register(2));
        end case;
    end process;
end architecture;