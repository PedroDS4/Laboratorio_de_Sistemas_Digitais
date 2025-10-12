library ieee;
use ieee.std_logic_1164.all;


entity minigame is
	port(
	SW : in std_logic_vector(3 downto 0);
	key : in std_logic_vector(2 downto 0);
	clr: in std_logic;
        clk: in std_logic;
   
	LEDR : out std_logic_vector(7 downto 0);
	LEDG : out std_logic_vector(7 downto 0)
	);
end minigame;




architecture CKT of minigame is 
  

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


      component mux_2x3
 	 port(
		A: in std_logic_vector(2 downto 0);
		B: in std_logic_vector(2 downto 0);
		Sl: in std_logic;
		Y: out std_logic_vector(2 downto 0)
	);
	end component;


    component decoder_4x8
   port (
        en : in std_logic;
        s : in std_logic_vector(2 downto 0);
        d : out std_logic_vector(7 downto 0)
);
    end component;

  
    component subtrator_3_bit
   port(
	A,B : in std_logic_vector(2 downto 0);
	C_0 : out std_logic;
	S :  out std_logic_vector(2 downto 0)
	);
     end component; 


   component somador_3_bits
   port(
	A,B : in std_logic_vector(2 downto 0);
	C_0 : out std_logic;
	S :  out std_logic_vector(2 downto 0)
	);
     end component;


  component ffd
    port (ck, clr, set: in  std_logic;
  	d : in std_logic_vector(2 downto 0);
   	q : out std_logic_vector(2 downto 0)
	);
      end component;

 
  --Sinais da Matriz de Leds--

  signal M1: std_logic_vector(0 to 7);
  signal M2: std_logic_vector(0 to 7);
  signal M3: std_logic_vector(0 to 7);
  signal M4: std_logic_vector(0 to 7);
  signal M5: std_logic_vector(0 to 7);
  signal M6: std_logic_vector(0 to 7);
  signal M7: std_logic_vector(0 to 7);
  signal M8: std_logic_vector(0 to 7);

  signal Linha0, Linha1, Linha2, Linha3, Linha4, Linha5, Linha6, Linha7: std_logic_vector(7 downto 0);

  
  --Sinais Intermediários--
  
  signal x,y, x_sum, x_sub, y_sum, y_sub, x_future, y_future, x_sum_or_sub, y_sum_or_sub: std_logic_vector(2 downto 0);
  signal Sl_one_or_zero_y, Sl_one_or_zero_x: std_logic;
  signal vec_x, vec_y: std_logic_vector(7 downto 0);



begin 



    sum_x: somador_3_bits port map(
	A => x,
	B => "001",
	C_0 => open,
	S => x_sum
	);

    sub_x: subtrator_3_bit port map(
	A => x,
	B => "001",
	C_0 => open,
	S => x_sub
	);

    mux_sum_or_sub_x: mux_2x3 port map(
	A => x_sum,
	B => x_sub,
	Sl => SW(1),
	Y => x_sum_or_sub
        );

    Sl_one_or_zero_x <= SW(1) or SW(2);

    mux_bypass_x: mux_2x3 port map(
	A => x,
	B => x_sum_or_sub,
	Sl => Sl_one_or_zero_x,
	Y => x_future
        );
   
     
    FF_D_x: ffd port map( 
	ck => clk,
        clr => clr,
        set => '0',
        d => x_future,
        q => x
	);
    


   sum_y: somador_3_bits port map(
	A => y,
	B => "001",
	C_0 => open,
	S => y_sum
	);

   sub_y: subtrator_3_bit port map(
	A => y,
	B => "001",
	C_0 => open,
	S => y_sub
	);

   mux_sum_or_sub_y: mux_2x3 port map(
	A => y_sum,
	B => y_sub,
	Sl => SW(0),
	Y => y_sum_or_sub
        );
   
   Sl_one_or_zero_y <= SW(3) or SW(0);

   mux_bypass_y: mux_2x3 port map(
	A => y,
	B => y_sum_or_sub,
	Sl => Sl_one_or_zero_y,
	Y => y_future
        );

   FF_D_y: ffd port map( 
	ck => clk,
        clr => clr,
        set => '0',
        d => y_future,
        q => y
	);


   
   decode_x: decoder_4x8 port map(
	en => '1',
	s => x,
        d => vec_x
        );

   decode_y: decoder_4x8 port map(
	en => '1',
	s => y,
        d => vec_y
        );
	


   --Inicializando as colunas que são nulas por padrão
	--Coluna 1
	M1(7) <= vec_x(7) and vec_y(0);
        M1(6) <= vec_x(6) and vec_y(0);
        M1(5) <= vec_x(5) and vec_y(0);
	M1(4) <= vec_x(4) and vec_y(0);
	M1(3) <= vec_x(3) and vec_y(0);
	M1(2) <= vec_x(2) and vec_y(0);
	M1(1) <= vec_x(1) and vec_y(0);
	M1(0) <= vec_x(0) and vec_y(0);

	 --Coluna 2
	M2(7) <= vec_x(7) and vec_y(1);
        M2(6) <= vec_x(6) and vec_y(1);
        M2(5) <= vec_x(5) and vec_y(1);
	M2(4) <= vec_x(4) and vec_y(1);
	M2(3) <= vec_x(3) and vec_y(1);
	M2(2) <= vec_x(2) and vec_y(1);
	M2(1) <= vec_x(1) and vec_y(1);
	M2(0) <= vec_x(0) and vec_y(1);

        --Coluna 3
	M3(7) <= vec_x(7) and vec_y(2);
        M3(6) <= vec_x(6) and vec_y(2);
        M3(5) <= vec_x(5) and vec_y(2);
	M3(4) <= vec_x(4) and vec_y(2);
	M3(3) <= vec_x(3) and vec_y(2);
	M3(2) <= vec_x(2) and vec_y(2);
	M3(1) <= vec_x(1) and vec_y(2);
	M3(0) <= vec_x(0) and vec_y(2);

        --Coluna 4
	M4(7) <= vec_x(7) and vec_y(3);
        M4(6) <= vec_x(6) and vec_y(3);
        M4(5) <= vec_x(5) and vec_y(3);
	M4(4) <= vec_x(4) and vec_y(3);
	M4(3) <= vec_x(3) and vec_y(3);
	M4(2) <= vec_x(2) and vec_y(3);
	M4(1) <= vec_x(1) and vec_y(3);
	M4(0) <= vec_x(0) and vec_y(3);

	--Coluna 5
	M5(7) <= vec_x(7) and vec_y(4);
        M5(6) <= vec_x(6) and vec_y(4);
        M5(5) <= vec_x(5) and vec_y(4);
	M5(4) <= vec_x(4) and vec_y(4);
	M5(3) <= vec_x(3) and vec_y(4);
	M5(2) <= vec_x(2) and vec_y(4);
	M5(1) <= vec_x(1) and vec_y(4);
	M5(0) <= vec_x(0) and vec_y(4);
	
	--Coluna 6
	M6(7) <= vec_x(7) and vec_y(5);
        M6(6) <= vec_x(6) and vec_y(5);
        M6(5) <= vec_x(5) and vec_y(5);
	M6(4) <= vec_x(4) and vec_y(5);
	M6(3) <= vec_x(3) and vec_y(5);
	M6(2) <= vec_x(2) and vec_y(5);
	M6(1) <= vec_x(1) and vec_y(5);
	M6(0) <= vec_x(0) and vec_y(5);
	
        --Coluna 7
	M7(7) <= vec_x(7) and vec_y(6);
        M7(6) <= vec_x(6) and vec_y(6);
        M7(5) <= vec_x(5) and vec_y(6);
	M7(4) <= vec_x(4) and vec_y(6);
	M7(3) <= vec_x(3) and vec_y(6);
	M7(2) <= vec_x(2) and vec_y(6);
	M7(1) <= vec_x(1) and vec_y(6);
	M7(0) <= vec_x(0) and vec_y(6);

	M8(7) <= vec_x(7) and vec_y(7);
        M8(6) <= vec_x(6) and vec_y(7);
        M8(5) <= vec_x(5) and vec_y(7);
	M8(4) <= vec_x(4) and vec_y(7);
	M8(3) <= vec_x(3) and vec_y(7);
	M8(2) <= vec_x(2) and vec_y(7);
	M8(1) <= vec_x(1) and vec_y(7);
	M8(0) <= vec_x(0) and vec_y(7);



    Linha0 <= M1(0) & M2(0) & M3(0) & M4(0) & M5(0) & M6(0) & M7(0) & M8(0);
    Linha1 <= M1(1) & M2(1) & M3(1) & M4(1) & M5(1) & M6(1) & M7(1) & M8(1);
    Linha2 <= M1(2) & M2(2) & M3(2) & M4(2) & M5(2) & M6(2) & M7(2) & M8(2);
    Linha3 <= M1(3) & M2(3) & M3(3) & M4(3) & M5(3) & M6(3) & M7(3) & M8(3);
    Linha4 <= M1(4) & M2(4) & M3(4) & M4(4) & M5(4) & M6(4) & M7(4) & M8(4);
    Linha5 <= M1(5) & M2(5) & M3(5) & M4(5) & M5(5) & M6(5) & M7(5) & M8(5);
    Linha6 <= M1(6) & M2(6) & M3(6) & M4(6) & M5(6) & M6(6) & M7(6) & M8(6);
    Linha7 <= M1(7) & M2(7) & M3(7) & M4(7) & M5(7) & M6(7) & M7(7) & M8(7);



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
