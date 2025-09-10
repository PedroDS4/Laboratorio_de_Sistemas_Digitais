library ieee;
use ieee.std_logic_1164.all;


entity decoder_4x8 is
   port (
        en : in std_logic;
        s : in std_logic_vector(2 downto 0);

        d : out std_logic_vector(7 downto 0)
);
end decoder_4x8;




architecture CKT of decoder_4x8 is


begin
    
    d(0) <= en and not(s(2)) and not(s(1)) and not(s(0));
    d(1) <= en and not(s(2)) and not(s(1)) and s(0);
    d(2) <= en and not(s(2)) and s(1) and not(s(0));
    d(3) <= en and not(s(2)) and s(1) and s(0);
    d(4) <= en and s(2) and not(s(1)) and not(s(0));
    d(5) <= en and s(2) and not(s(1)) and s(0);	
    d(6) <= en and s(2) and s(1) and not(s(0));	
    d(7) <= en and s(2) and s(1) and s(0);	

end CKT;
