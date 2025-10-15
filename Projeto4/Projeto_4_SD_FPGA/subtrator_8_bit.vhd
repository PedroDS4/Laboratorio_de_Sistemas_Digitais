

library ieee;
use ieee.std_logic_1164.all;


entity subtrator_3_bit is
	port(

	A,B : in std_logic_vector(2 downto 0);
		
	C_0 : out std_logic;
	S :   out std_logic_vector(2 downto 0)
	);
end subtrator_3_bit;



architecture CKT of subtrator_3_bit is 
	
	
	component somador_1_bit
		port(
			A: in std_logic;
			B: in std_logic;
			C_i: in std_logic;

			C_0: out std_logic;
			S: out std_logic
			);
	end component;

	
	signal c : std_logic_vector(2 downto 0);
		
	signal B_inv : std_logic_vector(2 downto 0);


begin 
	
	B_inv <= not(B);

	S0: somador_1_bit port map(
  	A => A(0),
  	B => B_inv(0),
  	C_i => '1',       -- carry-in inicial
  	C_0 => c(0),      -- carry-out vai pro próximo estágio
  	S => S(0)
);
	S1: somador_1_bit port map(
  	A => A(1),
  	B => B_inv(1),
  	C_i => c(0),
  	C_0 => c(1),
  	S => S(1)
);
	S2: somador_1_bit port map(
  	A => A(2),
  	B => B_inv(2),
  	C_i => c(1),
  	C_0 => c(2),
  	S => S(2)
);

	C_0 <= c(2);

end CKT;