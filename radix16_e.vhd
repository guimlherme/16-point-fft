LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use work.types.all ;

ENTITY radix16 IS
    PORT(
        clk   : IN std_logic;
        reset : IN std_logic;
        enable: IN std_logic;
        x     : IN tab16 ;	-- entres
		y	  : OUT tab9   -- sortie du radix
    );
END radix16;
