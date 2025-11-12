library ieee;
use ieee.std_logic_1164.all;

entity multiplicador_4_bits is
    port(
        A     : in  std_logic_vector(4 downto 0);
        B     : in  std_logic_vector(4 downto 0);
        
        c_0 : out std_logic;
        S     : out std_logic_vector(7 downto 0)
        
    );
end multiplicador_4_bits;



architecture CKT of multiplicador_4_bits is

    component somador_1_bit
        port(
            A    : in  std_logic;
            B    : in  std_logic;
            C_i  : in  std_logic;
            C_0  : out std_logic;
            S    : out std_logic
        );
    end component;

    signal partial : std_logic_vector(24 downto 0);
    signal sum     : std_logic_vector(8 downto 0);
    signal carry   : std_logic_vector(23 downto 0); -- Carries intermediários

begin

    -- Produtos parciais
    partial(0)  <= A(0) and B(0); -- P0 direto
    partial(1)  <= A(1) and B(0);
    partial(2)  <= A(0) and B(1);
    partial(3)  <= A(2) and B(0);
    partial(4)  <= A(1) and B(1);
    partial(5)  <= A(0) and B(2);
    partial(6)  <= A(3) and B(0);
    partial(7)  <= A(2) and B(1);
    partial(8)  <= A(1) and B(2);
    partial(9)  <= A(0) and B(3);
    partial(10) <= A(4) and B(0);
    partial(11) <= A(3) and B(1);
    partial(12) <= A(2) and B(2);
    partial(13) <= A(1) and B(3);
    partial(14) <= A(0) and B(4);
    partial(15) <= A(4) and B(1);
    partial(16) <= A(3) and B(2);
    partial(17) <= A(2) and B(3);
    partial(18) <= A(1) and B(4);
    partial(19) <= A(4) and B(2);
    partial(20) <= A(3) and B(3);
    partial(21) <= A(2) and B(4);
    partial(22) <= A(4) and B(3);
    partial(23) <= A(3) and B(4);
    partial(24) <= A(4) and B(4); -- vai ser o C_out

    -- P(0) = A0 * B0
    S(0) <= partial(0);

    -- P(1) = A1B0 + A0B1
    U1: somador_1_bit port map(partial(1), partial(2), '0', carry(0), S(1));

    -- P(2) = A2B0 + A1B1 + A0B2
    U2a: somador_1_bit port map(partial(3), partial(4), carry(0), carry(1), sum(0));
    U2b: somador_1_bit port map(sum(0), partial(5), carry(1), carry(2), S(2));

    -- P(3) = A3B0 + A2B1 + A1B2 + A0B3
    U3a: somador_1_bit port map(partial(6), partial(7), carry(2), carry(3), sum(1));
    U3b: somador_1_bit port map(sum(1), partial(8), carry(3), carry(4), sum(2));
    U3c: somador_1_bit port map(sum(2), partial(9), carry(4), carry(5), S(3));

    -- P(4) = A4B0 + A3B1 + A2B2 + A1B3 + A0B4
    U4a: somador_1_bit port map(partial(10), partial(11), carry(5), carry(6), sum(3));
    U4b: somador_1_bit port map(sum(3), partial(12), carry(6), carry(7), sum(4));
    U4c: somador_1_bit port map(sum(4), partial(13), carry(7), carry(8), sum(5));
    U4d: somador_1_bit port map(sum(5), partial(14), carry(8), carry(9), S(4));

    -- P(5) = A4B1 + A3B2 + A2B3 + A1B4
    U5a: somador_1_bit port map(partial(15), partial(16), carry(9), carry(10), sum(6));
    U5b: somador_1_bit port map(sum(6), partial(17), carry(10), carry(11), sum(7));
    U5c: somador_1_bit port map(sum(7), partial(18), carry(11), carry(12), S(5));

    -- P(6) = A4B2 + A3B3 + A2B4
    U6a: somador_1_bit port map(partial(19), partial(20), carry(12), carry(13), sum(8));
    U6b: somador_1_bit port map(sum(8), partial(21), carry(13), carry(14), S(6));

    -- P(7) = A4B3 + A3B4
    U7: somador_1_bit port map(partial(22), partial(23), carry(14), carry(15), S(7));

    -- C_out = A4B4
    U8: somador_1_bit port map(partial(24), '0', carry(15), open, c_0);


end CKT;