LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;
use work.types.all ;

ENTITY radix4 IS
    PORT(
        x0r,x0i,x1r,x1i,x2r,x2i,x3r,x3i     : IN sfixed(vectorin'range) ;	-- entres
		y0r,y0i,y1r,y1i,y2r,y2i,y3r,y3i	    : OUT sfixed(vectorin'range) ;	-- sortie du radix
		d20,d21 							: IN std_logic
    );
END radix4;

architecture radix4_a of radix4 is
	
	COMPONENT radix2 IS
	PORT(
	d2	  : IN  std_logic ;					-- indique si on doit diviser par 2
	x0    : IN  vectorin ;  -- entree 1
	x1    : IN  vectorin ;	-- entree 2
	yp    : OUT vectorin ;	-- sortie somme
	ym    : OUT vectorin	-- sortie difference
	);
	END COMPONENT radix2;
	
signal z0r, z0i, z1r, z1i, z2r, z2i, z3r, z3i : sfixed(vectorin'left downto vectorin'right) := (others => '0') ;
	
begin
UUT_Z01r : radix2
port map (
    d2	  => '1' ,
    x0    => x0r ,
    x1    => x2r ,
    yp    => z0r ,
    ym    => z1r 
    );

UUT_Z01i : radix2
port map (
    d2    => '1' ,
    x0    => x0i ,
    x1    => x2i ,
    yp    => z0i ,
    ym    => z1i 
    );
    
UUT_Z23r : radix2
port map (
    d2	  => '1' ,
    x0    => x1r ,
    x1    => x3r ,
    yp    => z2r ,
    ym    => z3r 
    );
    
UUT_Z23i : radix2
port map (
    d2    => '1' ,
    x0    => x1i ,
    x1    => x3i ,
    yp    => z2i ,
    ym    => z3i 
    );
    
-- Outputs Y

UUT_Y02r : radix2
port map (
    d2    => d20 ,
    x0    => z0r ,
    x1    => z2r ,
    yp    => y0r ,
    ym    => y2r 
    );
    
UUT_Y02i : radix2
port map (
    d2    => d20 ,
    x0    => z0i ,
    x1    => z2i ,
    yp    => y0i ,
    ym    => y2i 
    );
    
UUT_Y13r : radix2
port map (
    d2    => d21 ,
    x0    => z1r ,
    x1    => z3i , -- -i*z3
    yp    => y1r ,
    ym    => y3r 
    );
    
UUT_Y13i : radix2
port map (
    d2	  => d21 ,
    x0    => z1i ,
    x1    => z3r , -- -i*z3
    yp    => y3i , -- -i*z3
    ym    => y1i  -- -i*z3
    );
    
    
end architecture radix4_a;