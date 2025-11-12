library ieee;
use ieee.std_logic_1164.all;


entity filtrofir is
   port (
   y : in std_logic_vector(3 downto 0);
   c :	 in std_logic_vector(3 downto 0);

   clk : in std_logic;
	clr_r: in std_logic;
	en_cod: in std_logic;
	s_cod: in std_logic_vector(1 downto 0);
	ld_r: in std_logic;
	ld_out: in std_logic;
   
	ck_saida: out std_logic;
	HEX0:  out std_logic_vector(6 downto 0);
	HEX1: out std_logic_vector(13 downto 7);
	HEX2: out std_logic_vector(20 downto 14);
	HEX3: out std_logic_vector(27 downto 21)
);
end filtrofir;




architecture CKT of filtrofir is
        

	signal y_k_minus_one, y_k_minus_two, y_k_minus_three: std_logic_vector(3 downto 0);
	signal p_1, p_2, p_3: std_logic_vector(7 downto 0);
	signal  p_12, reg_in: std_logic_vector(9 downto 0);
	signal F, s_1,s_2,s_3: std_logic_vector(9 downto 0);
	signal ld_c: std_logic_vector(3 downto 0);
	signal carry_out_1, carry_out_2, carry_out_3, carry_out_4, carry_out_5: std_logic;
	signal BCD: std_logic_vector(15 downto 0);
	signal cod_0, cod_1, cod_2: std_logic;
	signal ck: std_logic;


	component coder_2x4
	port (
        en : in std_logic;
        s : in std_logic_vector(1 downto 0);
        d : out std_logic_vector(3 downto 0)
	);
	end component;
		
	component somador_8_bits
	port(
		A: in std_logic_vector(9 downto 0);
		B: in std_logic_vector(9 downto 0);
		C_0: out std_logic;
		S: out std_logic_vector(9 downto 0)
	);
	end component;


	component RxC
	port (
        	y : in std_logic_vector(3 downto 0);
        	c : in std_logic_vector(3 downto 0);
		ld_c : in std_logic;
		ld_r : in std_logic;
		clr_r: in std_logic;
		clk: in std_logic;	
		carry_out: out std_logic;
		y_out: out std_logic_vector(3 downto 0);
		product: out std_logic_vector(7 downto 0)
	);
	end component;


	component reg_10
	port (ck, load, clr, set: in std_logic;
			I : in std_logic_vector(9 downto 0);
			q : out std_logic_vector(9 downto 0)
	);
	end component;


	  
  	component display7
    	port (
      	  A, B, C, D : in std_logic;
      	  l: out std_logic_vector(6 downto 0)
 	   );
    
  	end component;

	component ck_div
	port(
		ck_in: in std_logic;
		ck_out: out std_logic
	);
	end component;

	
	component bin10_to_bcd4_expanded is
    	port(
        	bin : in  std_logic_vector(9 downto 0);
        	bcd : out std_logic_vector(15 downto 0)
    	);
	end component;

	


begin

	ck_div_component: ck_div
	port map(
	ck_in => clk,	
	ck_out => ck
	);
	
	
	register_codification: coder_2x4 
	port map(
	en => en_cod,
	s => s_cod,
	d => ld_c
	);
	
	
	cod_0 <= ld_c(0);
	cod_1 <= ld_c(1);
	cod_2 <= ld_c(2);


	RxC_y_k: RxC port map(
	y => y,
	c => c,
	ld_c => cod_0,
	ld_r => ld_r,
	clr_r => clr_r,
	clk => ck,
	carry_out => carry_out_1,
	y_out => y_k_minus_one,
	product =>  p_1
	);

	RxC_y_k_minus_one: RxC port map(
	y => y_k_minus_one,
	c => c,
	ld_c => cod_1,
	ld_r => ld_r,
	clr_r => clr_r,
	clk => ck,
	carry_out => carry_out_2,
	y_out => y_k_minus_two,
	product =>  p_2
	);

	RxC_y_k_minus_two: RxC port map(
	y => y_k_minus_two,
	c => c,
	ld_c => cod_2,
	ld_r => ld_r,
	clr_r => clr_r,
	clk => ck,
	carry_out => carry_out_3,
	y_out => y_k_minus_three,
	product =>  p_3
	);

	ck_saida <= ck;
	
	s_1 <= "00" & p_1;
	s_2 <= "00" & p_2;

	
	Somador_1: somador_8_bits port map(
  	A => s_1,
  	B => s_2,
  	C_0 => carry_out_4,      -- carry-out vai pro pr�ximo est�gio
  	S => p_12
	);
	
	s_3 <= "00" & p_3;
	Somador_2: somador_8_bits port map(
  	A =>  p_12,
  	B => s_3,
  	C_0 => carry_out_5,      -- carry-out vai pro pr�ximo est�gio
  	S => reg_in
	);


	F_REG: reg_10
	port map(
	ck => clk,
	load => ld_out,
	clr => '0',
	set => '0',
	I => reg_in,
	q => F
	);
	
	
	BIN_TO_BCD: bin10_to_bcd4_expanded port map(
	   bin => F,
	   bcd => BCD
	   );

	   
	 --- A: bit mais significativo ---
	 LED1: display7 port map(
	   A => BCD(15),
	   B => BCD(14),
	   C => BCD(13),
	   D => BCD(12),
	   l => HEX3
	   );
	   
	   
	   LED2: display7 port map(
	   A => BCD(11),
	   B => BCD(10),
	   C => BCD(9),
	   D => BCD(8),
	   l => HEX2
	   );
	   
	   LED3: display7 port map(
	   A => BCD(7),
	   B => BCD(6),
	   C => BCD(5),
	   D => BCD(4),
	   l => HEX1
	   );

	   LED4: display7 port map(
	   A => BCD(3),
	   B => BCD(2),
	   C => BCD(1),
	   D => BCD(0),
	   l => HEX0
	   );
	
	


end CKT;