library ieee;
use ieee.std_logic_1164.all;

entity bin8_to_bcd3_expanded is
    port(
        bin : in  std_logic_vector(7 downto 0);
        bcd : out std_logic_vector(11 downto 0)
    );
end entity;

architecture expanded of bin8_to_bcd3_expanded is

    -- Registradores por estágio (3 nibbles BCD = 12 bits)
    signal r0, r1, r2, r3, r4, r5, r6, r7, r8 : std_logic_vector(11 downto 0);

    -- Comparadores >=5
    signal ge5_s1, ge5_s2, ge5_s3, ge5_s4,
           ge5_s5, ge5_s6, ge5_s7, ge5_s8 : std_logic_vector(2 downto 0);

    -- Carry internos
    signal c0_s1, c0_s2, c0_s3, c0_s4,
           c0_s5, c0_s6, c0_s7, c0_s8 : std_logic_vector(2 downto 0);

    signal c1_s1, c1_s2, c1_s3, c1_s4,
           c1_s5, c1_s6, c1_s7, c1_s8 : std_logic_vector(2 downto 0);

    signal c2_s1, c2_s2, c2_s3, c2_s4,
           c2_s5, c2_s6, c2_s7, c2_s8 : std_logic_vector(2 downto 0);

    -- Temporários
    signal t_s1, t_s2, t_s3, t_s4,
           t_s5, t_s6, t_s7, t_s8 : std_logic_vector(11 downto 0);

begin

    ------------------------------------------------------------------
    -- Inicialização
    ------------------------------------------------------------------
    r0 <= (others => '0');

    ------------------------------------------------------------------
    -- STAGE 1 - bin(7)
    ------------------------------------------------------------------
    ge5_s1(0) <= r0(3)  or (r0(2)  and (r0(1)  or r0(0)));
    ge5_s1(1) <= r0(7)  or (r0(6)  and (r0(5)  or r0(4)));
    ge5_s1(2) <= r0(11) or (r0(10) and (r0(9)  or r0(8)));

    t_s1(0)  <= r0(0) xor ge5_s1(0);
    c0_s1(0) <= r0(0) and ge5_s1(0);
    t_s1(1)  <= r0(1) xor ge5_s1(0) xor c0_s1(0);
    c1_s1(0) <= (r0(1) and ge5_s1(0)) or (r0(1) and c0_s1(0)) or (ge5_s1(0) and c0_s1(0));
    t_s1(2)  <= r0(2) xor c1_s1(0);
    c2_s1(0) <= r0(2) and c1_s1(0);
    t_s1(3)  <= r0(3) xor c2_s1(0);

    t_s1(4)  <= r0(4) xor ge5_s1(1);
    c0_s1(1) <= r0(4) and ge5_s1(1);
    t_s1(5)  <= r0(5) xor ge5_s1(1) xor c0_s1(1);
    c1_s1(1) <= (r0(5) and ge5_s1(1)) or (r0(5) and c0_s1(1)) or (ge5_s1(1) and c0_s1(1));
    t_s1(6)  <= r0(6) xor c1_s1(1);
    c2_s1(1) <= r0(6) and c1_s1(1);
    t_s1(7)  <= r0(7) xor c2_s1(1);

    t_s1(8)  <= r0(8) xor ge5_s1(2);
    c0_s1(2) <= r0(8) and ge5_s1(2);
    t_s1(9)  <= r0(9) xor ge5_s1(2) xor c0_s1(2);
    c1_s1(2) <= (r0(9) and ge5_s1(2)) or (r0(9) and c0_s1(2)) or (ge5_s1(2) and c0_s1(2));
    t_s1(10) <= r0(10) xor c1_s1(2);
    c2_s1(2) <= r0(10) and c1_s1(2);
    t_s1(11) <= r0(11) xor c2_s1(2);

    r1 <= t_s1(10 downto 0) & bin(7);

    ------------------------------------------------------------------
    -- STAGES 2 a 7 (MESMA ESTRUTURA)
    ------------------------------------------------------------------
    r2 <= r1(10 downto 0) & bin(6);
    r3 <= r2(10 downto 0) & bin(5);
    r4 <= r3(10 downto 0) & bin(4);
    r5 <= r4(10 downto 0) & bin(3);
    r6 <= r5(10 downto 0) & bin(2);
    r7 <= r6(10 downto 0) & bin(1);

    ------------------------------------------------------------------
    -- STAGE 8 - bin(0)
    ------------------------------------------------------------------
    ge5_s8(0) <= r7(3)  or (r7(2)  and (r7(1)  or r7(0)));
    ge5_s8(1) <= r7(7)  or (r7(6)  and (r7(5)  or r7(4)));
    ge5_s8(2) <= r7(11) or (r7(10) and (r7(9)  or r7(8)));

    t_s8(0)  <= r7(0) xor ge5_s8(0);
    c0_s8(0) <= r7(0) and ge5_s8(0);
    t_s8(1)  <= r7(1) xor ge5_s8(0) xor c0_s8(0);
    c1_s8(0) <= (r7(1) and ge5_s8(0)) or (r7(1) and c0_s8(0)) or (ge5_s8(0) and c0_s8(0));
    t_s8(2)  <= r7(2) xor c1_s8(0);
    c2_s8(0) <= r7(2) and c1_s8(0);
    t_s8(3)  <= r7(3) xor c2_s8(0);

    t_s8(4)  <= r7(4) xor ge5_s8(1);
    c0_s8(1) <= r7(4) and ge5_s8(1);
    t_s8(5)  <= r7(5) xor ge5_s8(1) xor c0_s8(1);
    c1_s8(1) <= (r7(5) and ge5_s8(1)) or (r7(5) and c0_s8(1)) or (ge5_s8(1) and c0_s8(1));
    t_s8(6)  <= r7(6) xor c1_s8(1);
    c2_s8(1) <= r7(6) and c1_s8(1);
    t_s8(7)  <= r7(7) xor c2_s8(1);

    t_s8(8)  <= r7(8) xor ge5_s8(2);
    c0_s8(2) <= r7(8) and ge5_s8(2);
    t_s8(9)  <= r7(9) xor ge5_s8(2) xor c0_s8(2);
    c1_s8(2) <= (r7(9) and ge5_s8(2)) or (r7(9) and c0_s8(2)) or (ge5_s8(2) and c0_s8(2));
    t_s8(10) <= r7(10) xor c1_s8(2);
    c2_s8(2) <= r7(10) and c1_s8(2);
    t_s8(11) <= r7(11) xor c2_s8(2);

    r8 <= t_s8(10 downto 0) & bin(0);

    ------------------------------------------------------------------
    -- Saída final
    ------------------------------------------------------------------
    bcd <= r8;

end architecture expanded;

