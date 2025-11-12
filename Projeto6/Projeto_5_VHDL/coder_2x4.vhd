library ieee;
use ieee.std_logic_1164.all;


entity coder_2x4 is
   port (
        en : in std_logic;
        s : in std_logic_vector(1 downto 0);

        d : out std_logic_vector(3 downto 0)
);
end coder_2x4;




architecture CKT of coder_2x4 is


begin
    
    d(0) <= en and not(s(1)) and not(s(0));
    d(1) <= en and not(s(1)) and s(0);
    d(2) <= en and s(1) and not(s(0));
    d(3) <= en and s(1) and s(0);

end CKT;

