library IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;


PACKAGE TYPES IS
  
  -- This is the main data type used in the library
  subtype vectorin is sfixed(0 downto -11) ;          -- signed fixed-point number from -1 to 1

  type coefficients_vector is array(0 to 6) of vectorin;

  type tab16 is array(0 to 15) of vectorin ;  -- arrays of vectorin
  type tab9 is array(0 to 8) of vectorin ;  
  type tab4 is array(0 to 3) of vectorin ;  
  type tab9u is array(0 to 8) of unsigned(7 downto 0) ;  

  type complex_num is array(0 to 1) of vectorin ;         -- index 0 is real, 1 is complex
  type tab16_c is array(0 to 15) of complex_num ;  -- arrays of complex numbers
  type tab9_c is array(0 to 8) of complex_num ;  
  type tab4_c is array(0 to 3) of complex_num ;
  
  type fft_state is (Calc00, Calc01, Calc02, Calc03, Calc10, Calc11, Calc12, Calc13) ;
  
END TYPES;
