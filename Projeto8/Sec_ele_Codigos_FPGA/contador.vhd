library ieee;
use ieee.std_logic_1164.all;

entity contador is
   port (
   clk, count, up_dw, clr: in std_logic;
   V_count : out std_logic_vector(3 downto 0) 
);
end contador;


architecture logica of contador is

  component mux_2x3
     port(
        A  : in std_logic_vector(3 downto 0);
        B  : in std_logic_vector(3 downto 0);
        Sl : in std_logic;
        Y  : out std_logic_vector(3 downto 0)
    );
  end component;

  component reg_4
      port (ck, load, clr, set: in  std_logic;
   	I : in std_logic_vector(3 downto 0);
   	q : out std_logic_vector(3 downto 0) 
    );
  end component;

  component somador_4_bits
      port(
	A,B : in std_logic_vector(3 downto 0);
	C_i : in std_logic;
	C_0 : out std_logic;
	S :   out std_logic_vector(3 downto 0)
	);
  end component;


  
  signal q_reg, S_mux, V_next: std_logic_vector(3 downto 0):= "0000";	-- Saida do mux
  signal not_up_dw, c_0: std_logic;

		
begin

   REG_COUNT: reg_4 port map(
        ck  => clk,
        load => count,
        clr => clr,
        set => '0',
        I => V_next,
        q => q_reg
    ); 
	
   S0_MUX: mux_2x3 port map(
	A  => "1110",		
        B  => "0001",
        Sl => up_dw,
        Y  => S_mux
	);

   

   not_up_dw <= not(up_dw);


   SUM_3: somador_4_bits port map( 
	A => q_reg,
        B => S_mux,
        C_i => not_up_dw,
        C_0 => c_0,
        S => V_next 
	);

   V_count <= q_reg;
   
end logica;