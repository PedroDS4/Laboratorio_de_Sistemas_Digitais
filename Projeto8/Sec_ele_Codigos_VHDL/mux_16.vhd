
library ieee;
use ieee.std_logic_1164.all;

entity mux_16 is
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
end mux_16;

architecture CKT of mux_16 is

	signal X: std_logic_vector(1 downto 0);
	signal Y1: std_logic_vector(7 downto 0);
	signal Y2: std_logic_vector(7 downto 0);

	component mux_1
	port(
		A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);
		Sl: in std_logic;
		Y: out std_logic_vector(7 downto 0)
	);
	end component;

	component mux_8
	port(
		A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);
		C: in std_logic_vector(7 downto 0);
		D: in std_logic_vector(7 downto 0);
		E: in std_logic_vector(7 downto 0);
		F: in std_logic_vector(7 downto 0);
		G: in std_logic_vector(7 downto 0);
		H: in std_logic_vector(7 downto 0);

		S: in std_logic_vector(2 downto 0);

		Y_8: out std_logic_vector(7 downto 0)
	);
	end component;

	

begin

	U0: mux_8 port map(
		A => A,
		B => B,
		C => C,
		D => D,
		E => E,
		F => F,
		G => G,
		H => H,
		S => S(2 downto 0),
		Y_8 => Y1
	);

	U1: mux_8 port map(
		A => I,
		B => J,
		C => K,
		D => L,
		E => M,
		F => N,
		G => O,
		H => P,
		S => S(2 downto 0),
		Y_8 => Y2
	);

	U2: mux_1 port map(
		A => Y1,
		B => Y2,
		Sl => S(3),
		Y => Y_16
	);

end CKT;