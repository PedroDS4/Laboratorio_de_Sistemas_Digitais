library ieee;
use ieee.std_logic_1164.all;


entity RxC is
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
end RxC;




architecture CKT of RxC is
        

	signal c_out: std_logic_vector(3 downto 0);
	signal y_k, c_k: std_logic_vector(4 downto 0);
	signal y_reg: std_logic_vector(3 downto 0);
	component multiplicador_4_bits
		port(
		A: in std_logic_vector(4 downto 0);
		B: in std_logic_vector(4 downto 0);
  
		C_0: out std_logic;
		S: out std_logic_vector(7 downto 0)
		);
	end component;


	component reg_N

      port (ck, load, clr, set: in  std_logic;
    		I : in std_logic_vector(3 downto 0);
    		q : out std_logic_vector(3 downto 0) 
     );

     end component;
	


begin
    	Y_REGISTER: reg_N 
	port map(
     ck => clk,
     load => ld_r,
     clr => clr_r,
     set => '0',
	I => y,
	q => y_reg
     );

	y_out <= y_reg;

	C_REG: reg_N 
	port map(
     ck => clk,
     load => ld_c,
     clr => '0',
     set => '0',
	I => c,
	q => c_out
     );
	
	y_k <= "0" & y_reg;
	c_k <= "0" & c_out;
	
	Produto: multiplicador_4_bits 
	port map(
  	A => y_k,
  	B => c_k,
  	C_0 => carry_out,    
  	S => product
);
	
	  
end CKT;
