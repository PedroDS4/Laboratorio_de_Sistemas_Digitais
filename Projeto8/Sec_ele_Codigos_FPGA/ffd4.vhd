library ieee;
use ieee.std_logic_1164.all;

entity ffd3 is
   port (ck, clr, set: in  std_logic;
   d : in std_logic_vector(3 downto 0);
   q : out std_logic_vector(3 downto 0)
);
end ffd3;

architecture logica of ffd3 is

begin

   process(ck, clr, set)
   begin
      if    (set = '1')            then q <= "1111";
      elsif (clr = '1')            then q <= "0000";
      elsif (ck'event and ck ='1') then q <= d;   
      end if;   
   end process;
   
end logica;