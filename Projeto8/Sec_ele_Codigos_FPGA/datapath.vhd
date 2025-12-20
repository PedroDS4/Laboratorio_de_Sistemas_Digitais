library ieee;
use ieee.std_logic_1164.all;


entity datapath is
   port (
        w_data : in std_logic_vector(7 downto 0);
        en_rd, en_wr, count_rd, count_wr: in std_logic;
        clk, clr : in std_logic;
	    em, fu: out std_logic;
	    addr_r: out std_logic_vector(3 downto 0);
   	    r_data : out std_logic_vector(7 downto 0)
);
end datapath;

architecture CKT of datapath is


   signal ck: std_logic;
   signal addr_r_s, addr_w: std_logic_vector(3 downto 0);




    component B_reg
	port (
        w_data : in std_logic_vector(7 downto 0);
        addr_r, addr_w : in std_logic_vector(3 downto 0);
        en_rd, en_wr: in std_logic;
        clk, clr : in std_logic;
        r_data: out std_logic_vector(7 downto 0)
	);
    end component;


   component comparador_4
     port (
        A      : in  std_logic_vector(3 downto 0);
        B      : in  std_logic_vector(3 downto 0);
        maior  : out std_logic;
        igual  : out std_logic;
        menor  : out std_logic
    );
     end component;




   component contador
	port (
   		clk, count, up_dw, clr: in std_logic;
   		V_count : out std_logic_vector(3 downto 0) 
	);
   end component;



begin

     	ck <= clk;


	ADDR_R_COUNTER: contador port map(
	    clk => clk,
	    count => count_rd,
	    up_dw => '1', 
	    clr => clr,
   	    V_count => addr_r_s
	);


	ADDR_W_COUNTER: contador port map(
	    clk => clk,
	    count => count_wr,
	    up_dw => '1', 
	    clr => clr,
   	    V_count => addr_w
	);        


     B_REGISTER: B_reg port map(
      w_data => w_data,
	addr_r => addr_r_s,
	addr_w => addr_w,
        en_rd => en_rd,
        en_wr => en_wr,
        clk => clk,
	clr => clr,
	r_data => r_data
     );
      
 
     COMPARADOR1_4_bits: comparador_4 port map(
          A => addr_r_s,
          B => "1111",
          maior => open,
          igual => em,
          menor => open
       );

     COMPARADOR2_4_bits: comparador_4 port map(
          A => addr_w,
          B => "1111",
          maior => open,
          igual => fu,
          menor => open
         );

	addr_r <= addr_r_s;


end CKT;
