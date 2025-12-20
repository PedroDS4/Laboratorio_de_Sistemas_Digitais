library ieee;
use ieee.std_logic_1164.all;


entity decoder_4x16 is
   port (
        en : in std_logic;
        s : in std_logic_vector(3 downto 0);
        d : out std_logic_vector(15 downto 0)
);
end decoder_4x16;




architecture CKT of decoder_4x16 is


begin
    
    d(0) <= en and not(s(3)) and not(s(2)) and not(s(1)) and not(s(0));
    d(1) <= en and not(s(3)) and not(s(2)) and not(s(1)) and s(0);
    d(2) <= en and not(s(3)) and not(s(2)) and s(1) and not(s(0));
    d(3) <= en and not(s(3)) and not(s(2)) and s(1) and s(0);
    d(4) <= en and not(s(3)) and s(2) and not(s(1)) and not(s(0));
    d(5) <= en and not(s(3)) and s(2) and not(s(1)) and s(0);	
    d(6) <= en and not(s(3)) and s(2) and s(1) and not(s(0));	
    d(7) <= en and not(s(3)) and s(2) and s(1) and s(0);
    d(8) <= en and s(3) and not(s(2)) and not(s(1)) and not(s(0));
    d(9) <= en and s(3) and not(s(2)) and not(s(1)) and s(0);
    d(10) <= en and s(3) and not(s(2)) and s(1) and not(s(0));
    d(11) <= en and s(3) and not(s(2)) and s(1) and s(0);
    d(12) <= en and s(3) and s(2) and not(s(1)) and not(s(0));
    d(13) <= en and s(3) and s(2) and not(s(1)) and s(0);	
    d(14) <= en and s(3) and s(2) and s(1) and not(s(0));	
    d(15) <= en and s(3) and s(2) and s(1) and s(0);	

end CKT;
