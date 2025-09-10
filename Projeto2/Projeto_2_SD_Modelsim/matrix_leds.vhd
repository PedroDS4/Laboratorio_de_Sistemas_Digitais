library ieee;
use ieee.std_logic_1164.all;


entity matrix_leds is
	port(
	SW : in std_logic_vector(3 downto 0);
	key : in std_logic_vector(2 downto 0);
	
	LEDR : out std_logic_vector(7 downto 0);
	LEDG : out std_logic_vector(7 downto 0)
	);
end matrix_leds;




architecture CKT of matrix_leds is 
  

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

    component decoder_4x8
   port (
        en : in std_logic;
        s : in std_logic_vector(2 downto 0);
        d : out std_logic_vector(7 downto 0)
);
    end component;

  

  signal M1: std_logic_vector(7 downto 0);
  signal M2: std_logic_vector(7 downto 0);
  signal M3: std_logic_vector(7 downto 0);
  signal M4: std_logic_vector(7 downto 0);
  signal M5: std_logic_vector(7 downto 0);
  signal M6: std_logic_vector(7 downto 0);
  signal M7: std_logic_vector(7 downto 0);
  signal M8: std_logic_vector(7 downto 0);

  signal Linha0, Linha1, Linha2, Linha3, Linha4, Linha5, Linha6, Linha7: std_logic_vector(7 downto 0);

  signal S_0, S_1, S_2, S_3, S_4, S_5, S_6, S_7, S_8, S_9, S_10, S_11, S_12, S_13, S_14, S_15: std_logic;
  
  

  
  
begin 
	
        S_0 <= not(SW(3)) and not(SW(2)) and not(SW(1)) and not(SW(0));
        S_1 <= not(SW(3)) and not(SW(2)) and not(SW(1)) and (SW(0));
        S_2 <= not(SW(3)) and not(SW(2)) and (SW(1)) and not(SW(0));
	S_3 <= not(SW(3)) and not(SW(2)) and (SW(1)) and (SW(0));
	S_4 <= not(SW(3)) and (SW(2)) and not(SW(1)) and not(SW(0));
	S_5 <= not(SW(3)) and (SW(2)) and not(SW(1)) and (SW(0));
	S_6 <= not(SW(3)) and (SW(2)) and (SW(1)) and not(SW(0));
	S_7 <= not(SW(3)) and (SW(2)) and (SW(1)) and (SW(0));
	S_8 <= (SW(3)) and not(SW(2)) and not(SW(1)) and not(SW(0));
	S_9 <= (SW(3)) and not(SW(2)) and not(SW(1)) and (SW(0));
	S_10 <= (SW(3)) and not(SW(2)) and (SW(1)) and not(SW(0));
	S_11 <= (SW(3)) and (SW(2)) and not(SW(1)) and (SW(0));
	S_12 <= (SW(3)) and (SW(2)) and not(SW(1)) and not(SW(0));
	S_13 <= (SW(3)) and (SW(2)) and not(SW(1)) and (SW(0));
	S_14 <= (SW(3)) and (SW(2)) and (SW(1)) and not(SW(0));
	S_15 <= (SW(3)) and (SW(2)) and (SW(1)) and (SW(0));


	

	--Inicializando as colunas que são nulas por padrão
	M1 <= "00000000";
        M2 <= "00000000";
	M8 <= "00000000";


        --Lógica Combinacional de cada led pra cada número a ser exibido
        --Coluna 3
	M3(7) <= '0';
        M3(6) <= S_5 or S_7 or S_11;
        M3(5) <= S_0 or S_2 or S_3 or S_5 or S_8 or S_9 or S_11;
	M3(4) <= S_0 or S_5 or S_6 or S_8 or S_9 or S_11;
	M3(3) <= S_0 or S_4 or S_6 or S_11 or S_12 or S_13 or S_14;
	M3(2) <= S_0 or S_4 or S_6 or S_8 or S_11 or S_12 or S_13 or S_14;
	M3(1) <= S_0 or S_2 or S_3 or S_5 or S_6 or S_8 or S_10 or S_11 or S_12 or S_13 or S_14;
	M3(0) <= S_2 or S_11;

        --Coluna 4
	M4(7) <= '0';
        M4(6) <= S_0 or S_2 or S_3 or S_5 or S_7 or S_8 or S_9;
        M4(5) <= S_1 or S_6;
	M4(4) <= S_4 or S_5 or S_10 or S_12 or S_13 or S_14;
	M4(3) <= S_3 or S_6 or S_8 or S_9 or S_11 or S_15;
	M4(2) <= S_0 or S_2 or S_4 or S_7 or S_10 or S_14;
	M4(1) <= S_7;
	M4(0) <= S_0 or S_1 or S_2 or S_3 or S_5 or S_6 or S_7 or S_8 or S_9 or S_10 or S_11 or S_12 or S_13 or S_14;

	--Coluna 5
	M5(7) <= '0';
        M5(6) <= S_0 or S_1 or S_2 or S_3 or S_5 or S_6 or S_7 or S_8 or S_9;
        M5(5) <= S_1 or S_4 or S_15;
	M5(4) <= S_1 or S_5 or S_10 or S_11 or S_12 or S_13 or S_14 or S_15;
	M5(3) <= S_0 or S_1 or S_2 or S_3 or S_6 or S_7 or S_8 or S_9 or S_15;
	M5(2) <= S_1 or S_4 or S_10 or S_14 or S_15;
	M5(1) <= S_1 or S_15;
	M5(0) <= S_0 or S_1 or S_2 or S_3 or S_5 or S_6 or S_8 or S_9 or S_10 or S_11 or S_12 or S_13 or S_14 or S_15;
	
	--Coluna 6
	M6(7) <= '0';
        M6(6) <= S_0 or S_2 or S_3 or S_4 or S_5 or S_6 or S_7 or S_8 or S_9 or S_15;
        M6(5) <= S_4;
	M6(4) <= S_0 or S_4 or S_5 or S_7 or S_11 or S_12 or S_14;
	M6(3) <= S_2 or S_3 or S_4 or S_6 or S_8 or S_9 or S_10 or S_13 or S_15;
	M6(2) <= S_4 or S_10 or S_14;
	M6(1) <= S_4 or S_9 or S_10;
	M6(0) <= S_0 or S_1 or S_2 or S_3 or S_4 or S_5 or S_6 or S_8 or S_10 or S_11 or S_12 or S_13 or S_14;
	
        --Coluna 7
	M7(7) <= '0';
        M7(6) <= S_5 or S_7 or S_13;
        M7(5) <= S_0 or S_2 or S_3 or S_7 or S_8 or S_9 or S_13 or S_15;
	M7(4) <= S_0 or S_2 or S_3 or S_8 or S_9 or S_13;
	M7(3) <= S_0 or S_5 or S_9 or S_11 or S_13 or S_14;
	M7(2) <= S_0 or S_3 or S_4 or S_5 or S_6 or S_8 or S_9 or S_11 or S_13;
	M7(1) <= S_0 or S_3 or S_5 or S_6 or S_8 or S_11 or S_12 or S_13;
	M7(0) <= S_2 or S_10 or S_13;


	
    Linha7 <= M1(0) & M2(0) & M3(0) & M4(0) & M5(0) & M6(0) & M7(0) & M8(0);
    Linha6 <= M1(1) & M2(1) & M3(1) & M4(1) & M5(1) & M6(1) & M7(1) & M8(1);
    Linha5 <= M1(2) & M2(2) & M3(2) & M4(2) & M5(2) & M6(2) & M7(2) & M8(2);
    Linha4 <= M1(3) & M2(3) & M3(3) & M4(3) & M5(3) & M6(3) & M7(3) & M8(3);
    Linha3 <= M1(4) & M2(4) & M3(4) & M4(4) & M5(4) & M6(4) & M7(4) & M8(4);
    Linha2 <= M1(5) & M2(5) & M3(5) & M4(5) & M5(5) & M6(5) & M7(5) & M8(5);
    Linha1 <= M1(6) & M2(6) & M3(6) & M4(6) & M5(6) & M6(6) & M7(6) & M8(6);
    Linha0 <= M1(7) & M2(7) & M3(7) & M4(7) & M5(7) & M6(7) & M7(7) & M8(7);



        mux_8_led_saida: mux_8 port map(
	A => M1,
	B => M2,
	C => M3,
	D => M4,
	E => M5,
	F => M6,
	G => M7,
	H => M8,
	S => key,
	Y_8 => LEDR
	);
		
	Decoder: decoder_4x8 port map(
		en => '1',
		s => key,
		d => LEDG
	);
   

end CKT;