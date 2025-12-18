library ieee;
use ieee.std_logic_1164.all;


entity sec_ele is
   port (
	    w_data : in std_logic_vector(7 downto 0);
	    play, rec: in std_logic;
	    clk : in std_logic;
	    clr: in std_logic;	
	    em, fu: out std_logic;
	    addr_r: out std_logic_vector(3 downto 0);
	    r_data: out std_logic_vector(7 downto 0)
);
end sec_ele;





architecture CKT of sec_ele is

   signal ck: std_logic;
   signal en_rd, en_wr, count_rd, count_wr: std_logic;
   signal em_s, fu_s: std_logic;



    component datapath
	port (
	w_data : in std_logic_vector(7 downto 0);
	en_rd, en_wr, count_rd, count_wr: in std_logic;
	clk : in std_logic;
        clr : in std_logic;
	em, fu: out std_logic;
	addr_r: out std_logic_vector(3 downto 0);
	r_data: out std_logic_vector(7 downto 0)
);
	end component; 


	component controller
	port(
        clk         : in std_logic;
        clr         : in std_logic;
        en_rd       : out std_logic;
        en_wr       : out std_logic;
	play	    : in std_logic;
	rec	    : in std_logic;
	cnt_rd	    : out std_logic;
	cnt_wr	    : out std_logic;
	em	    : in std_logic;
	fu	    : in std_logic
    );
	end component;



begin


   
     
	ck <= clk;

	
	CONTROLLER_CIRCUIT: controller
	port map(
	clk => ck,
	clr => clr,
	en_rd => en_rd,
   	en_wr => en_wr,
	play => play,
	rec => rec,
	cnt_rd => count_rd,
	cnt_wr => count_wr,
	em => em_s,
	fu => fu_s
	);


	DATAPATH_CIRCUIT: datapath 
	   port map(
     	   w_data => w_data,
	   en_rd => en_rd,
	   en_wr => en_wr,
	   count_rd => count_rd,
	   count_wr => count_wr,
	   clk => ck,
	   clr => clr,
	   em => em_s,
	   fu => fu_s,
	   addr_r => addr_r,
	   r_data => r_data
	   );

	
     em <= em_s;
     fu <= fu_s;
  


end CKT;