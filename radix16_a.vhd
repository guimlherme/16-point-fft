architecture radix16_a of radix16 is
	
	component radix_16_state_machine is
		port(
			clk: in std_logic;
			reset: in std_logic;
			enable: in std_logic;
			state: out fft_state
		);
	end component radix_16_state_machine;

	component sf16_c_register is
		port(
			clk: in std_logic;
			reset: in std_logic;
			enable: in std_logic;
			d: in tab16_c;
			q: out tab16_c
		);
	end component sf16_c_register;

	component radix_16_logic is
		port(
			enable: in std_logic;
			state: in fft_state;
			input_radix16: in tab16;
			from_mult: in tab4_c;
			reg_enable: out std_logic;
			to_radix: out tab4_c;
			from_register: in tab16_c;
			to_register: out tab16_c;
			output: out tab9_c
		);
	end component radix_16_logic;

	component radix4 IS
	port(
		x0r,x0i,x1r,x1i,x2r,x2i,x3r,x3i     : IN sfixed(vectorin'range) ;	-- entres
		y0r,y0i,y1r,y1i,y2r,y2i,y3r,y3i	    : OUT sfixed(vectorin'range) ;	-- sortie du radix
		d20,d21								: IN std_logic
	);
	end component radix4;

	component complex_mult is
		port(
			coef_cos: in vectorin;
			coef_sin: in vectorin;
			input_number_r: in vectorin;
			input_number_i: in vectorin;
			output_number_r: out vectorin;
			output_number_i: out vectorin
		);
	end component complex_mult;

	component coefficients is
		port(
			state: in fft_state;
			coef_cos1: out vectorin;
			coef_sin1: out vectorin;
			coef_cos2: out vectorin;
			coef_sin2: out vectorin;
			coef_cos3: out vectorin;
			coef_sin3: out vectorin
		);
	end component coefficients;


signal state : fft_state;

signal radix_in : tab4_c;
signal r0r,r0i,r1r,r1i,r2r,r2i,r3r,r3i : sfixed(vectorin'range) ; -- radix outputs
signal mult_out : tab4_c; -- multiplication output

signal reg_enable : std_logic; -- enable register
signal register_in : tab16_c; -- register input
signal register_out : tab16_c; -- register output

signal coef_cos1 : vectorin;
signal coef_sin1 : vectorin;
signal coef_cos2 : vectorin;
signal coef_sin2 : vectorin;
signal coef_cos3 : vectorin;
signal coef_sin3 : vectorin;

signal zero_sfixed : vectorin;

signal output : tab9_c;

begin
	
	process(output)
	begin
		for i in y'range loop
			--y(i) <= resize(output(i)(0) * output(i)(0) + output(i)(1) * output(i)(1), zero_sfixed); -- temporary sol
			y(i) <= output(i)(0);
		end loop;
	end process;
	
	unit_state_machine : radix_16_state_machine port map(
		clk, reset, enable, state
	);

	unit_register : sf16_c_register port map(
		clk, reset, reg_enable, register_in, register_out
	);

	unit_radix_16_logic : radix_16_logic port map(
		enable, state, x, mult_out, reg_enable, radix_in, register_out, register_in, output
	);
	
	unit_radix4 : radix4 port map(
		radix_in(0)(0),radix_in(0)(1),radix_in(1)(0),radix_in(1)(1),
		radix_in(2)(0),radix_in(2)(1),radix_in(3)(0),radix_in(3)(1),
		r0r,r0i,r1r,r1i,r2r,r2i,r3r,r3i,
		'1', '1'
	);

	mult_out(0)(0) <= r0r;
	mult_out(0)(1) <= r0i;

	unit_coefficients : coefficients port map(
		state, coef_cos1, coef_sin1, coef_cos2, coef_sin2, coef_cos3, coef_sin3
	);

	unit_complex_mult_1 : complex_mult port map(
		coef_cos1, coef_sin1, r1r, r1i, mult_out(1)(0), mult_out(1)(1)
	);

	unit_complex_mult_2 : complex_mult port map(
		coef_cos2, coef_sin2, r2r, r2i, mult_out(2)(0), mult_out(2)(1)
	);

	unit_complex_mult_3 : complex_mult port map(
		coef_cos3, coef_sin3, r3r, r3i, mult_out(3)(0), mult_out(3)(1)
	);
		
end architecture radix16_a;