library ieee;
use ieee.std_logic_1164.all;

entity controller is
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
end controller;

architecture mindset of controller is

    type st is (ST_RESET, I, NP, P, R, NR);
    signal estado  : st := I; -- Estado inicial da máquina de estados

begin
    process (clk, clr)
    begin

        if clr = '1' then -- Reset 

	    estado <= ST_RESET;
	    en_wr <= '0';
	    en_rd <= '0';	
	    cnt_wr <= '0';
	    cnt_rd <= '0';
	    

        elsif rising_edge(clk) then -- Transições síncronas na borda de subida do clock
	 
            en_wr <= '0';
	    en_rd <= '0';	
	    cnt_wr <= '0';
	    cnt_rd <= '0';

            case estado is
                when ST_RESET =>
		    estado <= I;

		when I =>
		    if rec = '1' then
			estado <= R;
		    elsif play = '1' then
			estado <= P;
		end if;

                when R =>
                    en_wr <= '1';
	            if rec = '1' then
			estado <= NR;
		    elsif fu = '1' then
			estado <= I;
		    end if;

                when P =>
                    en_rd <= '1';
		    if em = '1' then
			estado <= I;
		    elsif play = '1' then
			estado <= NP;
		    end if;

                when NP =>
                    cnt_rd <= '1';
		    estado <= P;

                when NR =>
		    cnt_wr <= '1';
	            estado <= R;
                    
                when others =>
                    estado <= I;
            end case;
       end if;
    end process;

end architecture mindset;