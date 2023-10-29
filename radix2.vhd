LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use work.types.all;

ENTITY radix2 IS
    PORT(
		d2	   : IN  std_logic ;		-- division by two
        x0     : IN  vectorin ;
        x1     : IN  vectorin;
        yp     : OUT vectorin;	-- sum output
		ym     : OUT vectorin	-- diff output
    );
END radix2;

architecture radix2_a of radix2 is

  signal som,dif : sfixed(vectorin'left+1 downto vectorin'right);
  signal two_sf : sfixed(2 downto 0);
  
  begin
  
    som <= x0+x1;
    dif <= x0-x1;
      
    process (d2,som,dif)
  
    begin
  
      if (d2='0') then
        yp <= resize( som,yp'left,yp'right,fixed_saturate,fixed_truncate) ;
        ym <= resize( dif,ym'left,ym'right,fixed_saturate,fixed_truncate) ;
      else
        yp <= resize( som sra 1,yp'left,yp'right,fixed_saturate,fixed_truncate) ; -- divide by two
        ym <= resize( dif sra 1,ym'left,ym'right,fixed_saturate,fixed_truncate) ; -- divide by two
      end if ;
    end process ;
  
  end architecture radix2_a ;
  
  