library ieee;
use ieee.std_logic_1164.all;



entity B_reg is
   port (
        w_data : in std_logic_vector(7 downto 0);
        addr_r, addr_w : in std_logic_vector(3 downto 0);
        en_rd, en_wr: in std_logic;
        clk, clr : in std_logic;
        r_data: out std_logic_vector(7 downto 0)
);
end B_reg;

	    


architecture logica of B_reg is
  
    
        signal V_0, V_1, V_2, V_3, V_4, V_5, V_6, V_7, V_8, V_9, V_10, V_11, V_12, V_13, V_14, V_15, V_i: std_logic_vector(7 downto 0);
	signal d: std_logic_vector(15 downto 0);



	component mux_16
       port(
	A: in std_logic_vector(7 downto 0);
	B: in std_logic_vector(7 downto 0);
	C: in std_logic_vector(7 downto 0);
	D: in std_logic_vector(7 downto 0);
	E: in std_logic_vector(7 downto 0);
	F: in std_logic_vector(7 downto 0);
	G: in std_logic_vector(7 downto 0);
	H: in std_logic_vector(7 downto 0);
	I: in std_logic_vector(7 downto 0);
	J: in std_logic_vector(7 downto 0);
	K: in std_logic_vector(7 downto 0);
	L: in std_logic_vector(7 downto 0);
	M: in std_logic_vector(7 downto 0);
	N: in std_logic_vector(7 downto 0);
	O: in std_logic_vector(7 downto 0);
	P: in std_logic_vector(7 downto 0);
	S: in std_logic_vector(3 downto 0);
	Y_16: out std_logic_vector(7 downto 0)
	);

    end component;

      component reg_N
    port (ck, load, clr, set: in  std_logic;
    	I : in std_logic_vector(7 downto 0);
    	q : out std_logic_vector(7 downto 0) 
     );
    end component;


      component decoder_4x16
    port (
        en : in std_logic;
        s : in std_logic_vector(3 downto 0);
        d : out std_logic_vector(15 downto 0)
);
    end component;



begin

  
        Decoder: decoder_4x16 port map(
		en => en_wr,
		s => addr_w,
		d => d
	);

        
	V0_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(0),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_0
        	);

	V1_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(1),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_1
        	);

	V2_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(2),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_2
        	);

	V3_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(3),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_3
        	);
	V4_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(4),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_4
        	);

	V5_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(5),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_5
        	);
	V6_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(6),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_6
        	);
	V7_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(7),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_7
        	);

	V8_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(8),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_8
        	);

	V9_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(9),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_9
        	);

	V10_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(10),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_10
        	);

	V11_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(11),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_11
        	);
	V12_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(12),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_12
        	);

	V13_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(13),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_13
        	);

	V14_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(14),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_14
        	);

	V15_REGISTER: reg_N port map(
        	ck => clk,
        	load => d(15),
 	    	clr => clr,
          	set => '0',
            	I => w_data,
	    	q => V_15
        	);



	mux_M_i: mux_16 port map(
	  A => V_0,
	  B => V_1,
	  C => V_2,
	  D => V_3,
	  E => V_4,
	  F => V_5,
	  G => V_6,
	  H => V_7,
	   I => V_8,
	  J => V_9,
	  K => V_10,
	  L => V_11,
	  M => V_12,
	  N => V_13,
	  O => V_14,
	  P => V_15,
	  S => addr_r,
	  Y_16 => V_i
	); 


	READ_OUT_REGISTER: reg_N port map(
        	ck => clk,
        	load => en_rd,
 	    	clr => clr,
          	set => '0',
            	I => V_i,
	    	q => r_data
        	);



   
end logica;