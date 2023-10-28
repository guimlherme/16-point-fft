LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use work.types.all ;

entity coefficients is
    port(
        state: in fft_state;
        coef_cos1: out vectorin;
        coef_sin1: out vectorin;
        coef_cos2: out vectorin;
        coef_sin2: out vectorin;
        coef_cos3: out vectorin;
        coef_sin3: out vectorin
    );
end coefficients;

architecture coefficients_a of coefficients is

-- Define base constants
signal cos_0         : vectorin;      -- cos(0)
signal cos_pi_over_8 : vectorin;      -- cos(pi/8)
signal cos_2pi_over_8 : vectorin;     -- cos(2*pi/8)
signal cos_3pi_over_8 : vectorin;     -- cos(3*pi/8)
signal cos_4pi_over_8 : vectorin;     -- cos(4*pi/8)
signal cos_6pi_over_8 : vectorin;     -- cos(6*pi/8)
signal cos_9pi_over_8 : vectorin;     -- cos(9*pi/8)

signal sin_minus_pi_over_8 : vectorin;       -- sin(-pi/8)
signal sin_minus_4pi_over_8 : vectorin;      -- sin(-4*pi/8)

-- Populate the vectors using the base constants
signal cos_values : coefficients_vector;
signal sin_values : coefficients_vector;

    

begin

-- Define base constants
cos_0         <= to_sfixed(1, cos_0);
cos_pi_over_8 <= to_sfixed(0.9238795325, cos_pi_over_8);      -- cos(pi/8)
cos_2pi_over_8 <= to_sfixed(0.7071067812, cos_2pi_over_8);     -- cos(2*pi/8)
cos_3pi_over_8 <= to_sfixed(0.3826834324, cos_3pi_over_8);     -- cos(3*pi/8)
cos_4pi_over_8 <= to_sfixed(0, cos_4pi_over_8);                -- cos(4*pi/8)
cos_6pi_over_8 <= to_sfixed(-0.7071067812, cos_6pi_over_8);     -- cos(6*pi/8)
cos_9pi_over_8 <= to_sfixed(-0.9238795325, cos_9pi_over_8);     -- cos(9*pi/8)

sin_minus_pi_over_8 <= to_sfixed(-0.3826834324, sin_minus_pi_over_8);       -- sin(-pi/8)
sin_minus_4pi_over_8 <= to_sfixed(-1.0, sin_minus_4pi_over_8);             -- sin(-4*pi/8)

-- Populate the vectors using the base constants
cos_values <= (
    cos_0,                                             -- cos(0)
    cos_pi_over_8,                                     -- cos(pi/8)
    cos_2pi_over_8,                                    -- cos(2*pi/8)
    cos_3pi_over_8,                                    -- cos(3*pi/8)
    cos_4pi_over_8,                                    -- cos(4*pi/8)
    cos_6pi_over_8,                                    -- cos(6*pi/8)
    cos_9pi_over_8                                     -- cos(9*pi/8)
);

sin_values <= (
    cos_4pi_over_8,                                    -- sin(-0) = cos(4*pi/8)
    sin_minus_pi_over_8,                               -- sin(-pi/8)
    cos_6pi_over_8,                                    -- sin(-2*pi/8) = cos(6*pi/8)
    cos_9pi_over_8,                                    -- sin(-3*pi/8) = cos(9*pi/8)
    sin_minus_4pi_over_8,                              -- sin(-4*pi/8)
    cos_6pi_over_8,                                    -- sin(-6*pi/8) = cos(6*pi/8)
    cos_3pi_over_8                                     -- sin(-9*pi/8) = cos(3*pi/8)
);

process(state)
begin
    case state is
        when Calc00 | Calc10 | Calc11 | Calc12 | Calc13 =>
            coef_cos1 <= cos_values(0);
            coef_sin1 <= sin_values(0);
            coef_cos2 <= cos_values(0);
            coef_sin2 <= sin_values(0);
            coef_cos3 <= cos_values(0);
            coef_sin3 <= sin_values(0);
        when Calc01 =>
            coef_cos1 <= cos_values(1);
            coef_sin1 <= sin_values(1);
            coef_cos2 <= cos_values(2);
            coef_sin2 <= sin_values(2);
            coef_cos3 <= cos_values(3);
            coef_sin3 <= sin_values(3);
        when Calc02 =>
            coef_cos1 <= cos_values(2);
            coef_sin1 <= sin_values(2);
            coef_cos2 <= cos_values(4);
            coef_sin2 <= sin_values(4);
            coef_cos3 <= cos_values(5);
            coef_sin3 <= sin_values(5);
        when Calc03 =>
            coef_cos1 <= cos_values(3);
            coef_sin1 <= sin_values(3);
            coef_cos2 <= cos_values(5);
            coef_sin2 <= sin_values(5);
            coef_cos3 <= cos_values(6);
            coef_sin3 <= sin_values(6);
    end case;
end process;
end architecture coefficients_a;