library ieee;
use ieee.std_logic_1164.all;

entity ffd_10 is
   port (ck, clr, set: in  std_logic;
   d : in std_logic_vector(9 downto 0);
   q : out std_logic_vector(9 downto 0)
);
end ffd_10;

architecture logica of ffd_10 is

begin

   process(ck, clr, set)
   begin
      if    (set = '1')            then q <= "1111111111";
      elsif (clr = '1')            then q <= "0000000000";
      elsif (ck'event and ck ='1') then q <= d;   
      end if;   
   end process;
   
end logica;