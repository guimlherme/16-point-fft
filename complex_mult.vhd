LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use work.types.all ;

entity complex_mult is
    port(
        coef_cos: in vectorin;
        coef_sin: in vectorin;
        input_number_r: in vectorin;
        input_number_i: in vectorin;
        output_number_r: out vectorin;
        output_number_i: out vectorin
    );
end complex_mult;

architecture complex_mult_a of complex_mult is
begin
    output_number_r <= resize(coef_cos * input_number_r - coef_sin * input_number_i,
	                    output_number_r'left, output_number_r'right,fixed_saturate,fixed_truncate);
    output_number_i <= resize(coef_cos * input_number_i + coef_sin * input_number_r,
	                    output_number_i'left, output_number_i'right, fixed_saturate,fixed_truncate);
end architecture complex_mult_a;