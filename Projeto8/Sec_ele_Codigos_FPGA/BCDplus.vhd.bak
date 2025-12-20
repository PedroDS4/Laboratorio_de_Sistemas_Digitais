
library ieee;
use ieee.std_logic_1164.all;

entity bin10_to_bcd4_expanded is
    port(
        bin : in  std_logic_vector(9 downto 0);
        bcd : out std_logic_vector(15 downto 0)
    );
end entity;

architecture expanded of bin10_to_bcd4_expanded is

    -- registros por estágio (16 bits)
    signal r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10 : std_logic_vector(15 downto 0);

    -- sinais por estágio: ge5 (por nibble), carries intermediários, palavra temporária t
    signal ge5_s1, ge5_s2, ge5_s3, ge5_s4, ge5_s5, ge5_s6, ge5_s7, ge5_s8, ge5_s9, ge5_s10 : std_logic_vector(3 downto 0);
    signal c0_s1, c0_s2, c0_s3, c0_s4, c0_s5, c0_s6, c0_s7, c0_s8, c0_s9, c0_s10 : std_logic_vector(3 downto 0);
    signal c1_s1, c1_s2, c1_s3, c1_s4, c1_s5, c1_s6, c1_s7, c1_s8, c1_s9, c1_s10 : std_logic_vector(3 downto 0);
    signal c2_s1, c2_s2, c2_s3, c2_s4, c2_s5, c2_s6, c2_s7, c2_s8, c2_s9, c2_s10 : std_logic_vector(3 downto 0);
    signal t_s1, t_s2, t_s3, t_s4, t_s5, t_s6, t_s7, t_s8, t_s9, t_s10 : std_logic_vector(15 downto 0);

begin

    -------------------------------------------------------------------
    -- Inicial
    -------------------------------------------------------------------
    r0 <= (others => '0');

    -------------------------------------------------------------------
    -- STAGE 1: consume bin(9)
    -------------------------------------------------------------------
    -- ge5 por nibble (index 0 -> least significant nibble bits 3..0)
    ge5_s1(0) <= r0(3)  or (r0(2)  and (r0(1)  or r0(0)));
    ge5_s1(1) <= r0(7)  or (r0(6)  and (r0(5)  or r0(4)));
    ge5_s1(2) <= r0(11) or (r0(10) and (r0(9)  or r0(8)));
    ge5_s1(3) <= r0(15) or (r0(14) and (r0(13) or r0(12)));

    -- nibble 0 (bits 3 downto 0)
    t_s1(0) <= r0(0) xor ge5_s1(0);
    c0_s1(0) <= r0(0) and ge5_s1(0);
    t_s1(1) <= r0(1) xor ge5_s1(0) xor c0_s1(0);
    c1_s1(0) <= (r0(1) and ge5_s1(0)) or (r0(1) and c0_s1(0)) or (ge5_s1(0) and c0_s1(0));
    t_s1(2) <= r0(2) xor c1_s1(0);
    c2_s1(0) <= r0(2) and c1_s1(0);
    t_s1(3) <= r0(3) xor c2_s1(0);

    -- nibble 1 (bits 7 downto 4)
    t_s1(4) <= r0(4) xor ge5_s1(1);
    c0_s1(1) <= r0(4) and ge5_s1(1);
    t_s1(5) <= r0(5) xor ge5_s1(1) xor c0_s1(1);
    c1_s1(1) <= (r0(5) and ge5_s1(1)) or (r0(5) and c0_s1(1)) or (ge5_s1(1) and c0_s1(1));
    t_s1(6) <= r0(6) xor c1_s1(1);
    c2_s1(1) <= r0(6) and c1_s1(1);
    t_s1(7) <= r0(7) xor c2_s1(1);

    -- nibble 2 (bits 11 downto 8)
    t_s1(8)  <= r0(8) xor ge5_s1(2);
    c0_s1(2) <= r0(8) and ge5_s1(2);
    t_s1(9)  <= r0(9) xor ge5_s1(2) xor c0_s1(2);
    c1_s1(2) <= (r0(9) and ge5_s1(2)) or (r0(9) and c0_s1(2)) or (ge5_s1(2) and c0_s1(2));
    t_s1(10) <= r0(10) xor c1_s1(2);
    c2_s1(2) <= r0(10) and c1_s1(2);
    t_s1(11) <= r0(11) xor c2_s1(2);

    -- nibble 3 (bits 15 downto 12)
    t_s1(12) <= r0(12) xor ge5_s1(3);
    c0_s1(3) <= r0(12) and ge5_s1(3);
    t_s1(13) <= r0(13) xor ge5_s1(3) xor c0_s1(3);
    c1_s1(3) <= (r0(13) and ge5_s1(3)) or (r0(13) and c0_s1(3)) or (ge5_s1(3) and c0_s1(3));
    t_s1(14) <= r0(14) xor c1_s1(3);
    c2_s1(3) <= r0(14) and c1_s1(3);
    t_s1(15) <= r0(15) xor c2_s1(3);

    -- shift-left + insert bin(9) as new LSB
    r1 <= t_s1(14 downto 0) & bin(9);

    -------------------------------------------------------------------
    -- STAGE 2: consume bin(8)
    -------------------------------------------------------------------
    ge5_s2(0) <= r1(3)  or (r1(2)  and (r1(1)  or r1(0)));
    ge5_s2(1) <= r1(7)  or (r1(6)  and (r1(5)  or r1(4)));
    ge5_s2(2) <= r1(11) or (r1(10) and (r1(9)  or r1(8)));
    ge5_s2(3) <= r1(15) or (r1(14) and (r1(13) or r1(12)));

    -- nibble 0
    t_s2(0) <= r1(0) xor ge5_s2(0);
    c0_s2(0) <= r1(0) and ge5_s2(0);
    t_s2(1) <= r1(1) xor ge5_s2(0) xor c0_s2(0);
    c1_s2(0) <= (r1(1) and ge5_s2(0)) or (r1(1) and c0_s2(0)) or (ge5_s2(0) and c0_s2(0));
    t_s2(2) <= r1(2) xor c1_s2(0);
    c2_s2(0) <= r1(2) and c1_s2(0);
    t_s2(3) <= r1(3) xor c2_s2(0);

    -- nibble 1
    t_s2(4) <= r1(4) xor ge5_s2(1);
    c0_s2(1) <= r1(4) and ge5_s2(1);
    t_s2(5) <= r1(5) xor ge5_s2(1) xor c0_s2(1);
    c1_s2(1) <= (r1(5) and ge5_s2(1)) or (r1(5) and c0_s2(1)) or (ge5_s2(1) and c0_s2(1));
    t_s2(6) <= r1(6) xor c1_s2(1);
    c2_s2(1) <= r1(6) and c1_s2(1);
    t_s2(7) <= r1(7) xor c2_s2(1);

    -- nibble 2
    t_s2(8)  <= r1(8) xor ge5_s2(2);
    c0_s2(2) <= r1(8) and ge5_s2(2);
    t_s2(9)  <= r1(9) xor ge5_s2(2) xor c0_s2(2);
    c1_s2(2) <= (r1(9) and ge5_s2(2)) or (r1(9) and c0_s2(2)) or (ge5_s2(2) and c0_s2(2));
    t_s2(10) <= r1(10) xor c1_s2(2);
    c2_s2(2) <= r1(10) and c1_s2(2);
    t_s2(11) <= r1(11) xor c2_s2(2);

    -- nibble 3
    t_s2(12) <= r1(12) xor ge5_s2(3);
    c0_s2(3) <= r1(12) and ge5_s2(3);
    t_s2(13) <= r1(13) xor ge5_s2(3) xor c0_s2(3);
    c1_s2(3) <= (r1(13) and ge5_s2(3)) or (r1(13) and c0_s2(3)) or (ge5_s2(3) and c0_s2(3));
    t_s2(14) <= r1(14) xor c1_s2(3);
    c2_s2(3) <= r1(14) and c1_s2(3);
    t_s2(15) <= r1(15) xor c2_s2(3);

    r2 <= t_s2(14 downto 0) & bin(8);

    -------------------------------------------------------------------
    -- STAGE 3: consume bin(7)
    -------------------------------------------------------------------
    ge5_s3(0) <= r2(3)  or (r2(2)  and (r2(1)  or r2(0)));
    ge5_s3(1) <= r2(7)  or (r2(6)  and (r2(5)  or r2(4)));
    ge5_s3(2) <= r2(11) or (r2(10) and (r2(9)  or r2(8)));
    ge5_s3(3) <= r2(15) or (r2(14) and (r2(13) or r2(12)));

    -- nibble 0
    t_s3(0) <= r2(0) xor ge5_s3(0);
    c0_s3(0) <= r2(0) and ge5_s3(0);
    t_s3(1) <= r2(1) xor ge5_s3(0) xor c0_s3(0);
    c1_s3(0) <= (r2(1) and ge5_s3(0)) or (r2(1) and c0_s3(0)) or (ge5_s3(0) and c0_s3(0));
    t_s3(2) <= r2(2) xor c1_s3(0);
    c2_s3(0) <= r2(2) and c1_s3(0);
    t_s3(3) <= r2(3) xor c2_s3(0);

    -- nibble 1
    t_s3(4) <= r2(4) xor ge5_s3(1);
    c0_s3(1) <= r2(4) and ge5_s3(1);
    t_s3(5) <= r2(5) xor ge5_s3(1) xor c0_s3(1);
    c1_s3(1) <= (r2(5) and ge5_s3(1)) or (r2(5) and c0_s3(1)) or (ge5_s3(1) and c0_s3(1));
    t_s3(6) <= r2(6) xor c1_s3(1);
    c2_s3(1) <= r2(6) and c1_s3(1);
    t_s3(7) <= r2(7) xor c2_s3(1);

    -- nibble 2
    t_s3(8)  <= r2(8) xor ge5_s3(2);
    c0_s3(2) <= r2(8) and ge5_s3(2);
    t_s3(9)  <= r2(9) xor ge5_s3(2) xor c0_s3(2);
    c1_s3(2) <= (r2(9) and ge5_s3(2)) or (r2(9) and c0_s3(2)) or (ge5_s3(2) and c0_s3(2));
    t_s3(10) <= r2(10) xor c1_s3(2);
    c2_s3(2) <= r2(10) and c1_s3(2);
    t_s3(11) <= r2(11) xor c2_s3(2);

    -- nibble 3
    t_s3(12) <= r2(12) xor ge5_s3(3);
    c0_s3(3) <= r2(12) and ge5_s3(3);
    t_s3(13) <= r2(13) xor ge5_s3(3) xor c0_s3(3);
    c1_s3(3) <= (r2(13) and ge5_s3(3)) or (r2(13) and c0_s3(3)) or (ge5_s3(3) and c0_s3(3));
    t_s3(14) <= r2(14) xor c1_s3(3);
    c2_s3(3) <= r2(14) and c1_s3(3);
    t_s3(15) <= r2(15) xor c2_s3(3);

    r3 <= t_s3(14 downto 0) & bin(7);

    -------------------------------------------------------------------
    -- STAGE 4: consume bin(6)
    -------------------------------------------------------------------
    ge5_s4(0) <= r3(3)  or (r3(2)  and (r3(1)  or r3(0)));
    ge5_s4(1) <= r3(7)  or (r3(6)  and (r3(5)  or r3(4)));
    ge5_s4(2) <= r3(11) or (r3(10) and (r3(9)  or r3(8)));
    ge5_s4(3) <= r3(15) or (r3(14) and (r3(13) or r3(12)));

    -- nibble 0
    t_s4(0) <= r3(0) xor ge5_s4(0);
    c0_s4(0) <= r3(0) and ge5_s4(0);
    t_s4(1) <= r3(1) xor ge5_s4(0) xor c0_s4(0);
    c1_s4(0) <= (r3(1) and ge5_s4(0)) or (r3(1) and c0_s4(0)) or (ge5_s4(0) and c0_s4(0));
    t_s4(2) <= r3(2) xor c1_s4(0);
    c2_s4(0) <= r3(2) and c1_s4(0);
    t_s4(3) <= r3(3) xor c2_s4(0);

    -- nibble 1
    t_s4(4) <= r3(4) xor ge5_s4(1);
    c0_s4(1) <= r3(4) and ge5_s4(1);
    t_s4(5) <= r3(5) xor ge5_s4(1) xor c0_s4(1);
    c1_s4(1) <= (r3(5) and ge5_s4(1)) or (r3(5) and c0_s4(1)) or (ge5_s4(1) and c0_s4(1));
    t_s4(6) <= r3(6) xor c1_s4(1);
    c2_s4(1) <= r3(6) and c1_s4(1);
    t_s4(7) <= r3(7) xor c2_s4(1);

    -- nibble 2
    t_s4(8)  <= r3(8) xor ge5_s4(2);
    c0_s4(2) <= r3(8) and ge5_s4(2);
    t_s4(9)  <= r3(9) xor ge5_s4(2) xor c0_s4(2);
    c1_s4(2) <= (r3(9) and ge5_s4(2)) or (r3(9) and c0_s4(2)) or (ge5_s4(2) and c0_s4(2));
    t_s4(10) <= r3(10) xor c1_s4(2);
    c2_s4(2) <= r3(10) and c1_s4(2);
    t_s4(11) <= r3(11) xor c2_s4(2);

    -- nibble 3
    t_s4(12) <= r3(12) xor ge5_s4(3);
    c0_s4(3) <= r3(12) and ge5_s4(3);
    t_s4(13) <= r3(13) xor ge5_s4(3) xor c0_s4(3);
    c1_s4(3) <= (r3(13) and ge5_s4(3)) or (r3(13) and c0_s4(3)) or (ge5_s4(3) and c0_s4(3));
    t_s4(14) <= r3(14) xor c1_s4(3);
    c2_s4(3) <= r3(14) and c1_s4(3);
    t_s4(15) <= r3(15) xor c2_s4(3);

    r4 <= t_s4(14 downto 0) & bin(6);

    -------------------------------------------------------------------
    -- STAGE 5: consume bin(5)
    -------------------------------------------------------------------
    ge5_s5(0) <= r4(3)  or (r4(2)  and (r4(1)  or r4(0)));
    ge5_s5(1) <= r4(7)  or (r4(6)  and (r4(5)  or r4(4)));
    ge5_s5(2) <= r4(11) or (r4(10) and (r4(9)  or r4(8)));
    ge5_s5(3) <= r4(15) or (r4(14) and (r4(13) or r4(12)));

    -- nibble 0
    t_s5(0) <= r4(0) xor ge5_s5(0);
    c0_s5(0) <= r4(0) and ge5_s5(0);
    t_s5(1) <= r4(1) xor ge5_s5(0) xor c0_s5(0);
    c1_s5(0) <= (r4(1) and ge5_s5(0)) or (r4(1) and c0_s5(0)) or (ge5_s5(0) and c0_s5(0));
    t_s5(2) <= r4(2) xor c1_s5(0);
    c2_s5(0) <= r4(2) and c1_s5(0);
    t_s5(3) <= r4(3) xor c2_s5(0);

    -- nibble 1
    t_s5(4) <= r4(4) xor ge5_s5(1);
    c0_s5(1) <= r4(4) and ge5_s5(1);
    t_s5(5) <= r4(5) xor ge5_s5(1) xor c0_s5(1);
    c1_s5(1) <= (r4(5) and ge5_s5(1)) or (r4(5) and c0_s5(1)) or (ge5_s5(1) and c0_s5(1));
    t_s5(6) <= r4(6) xor c1_s5(1);
    c2_s5(1) <= r4(6) and c1_s5(1);
    t_s5(7) <= r4(7) xor c2_s5(1);

    -- nibble 2
    t_s5(8)  <= r4(8) xor ge5_s5(2);
    c0_s5(2) <= r4(8) and ge5_s5(2);
    t_s5(9)  <= r4(9) xor ge5_s5(2) xor c0_s5(2);
    c1_s5(2) <= (r4(9) and ge5_s5(2)) or (r4(9) and c0_s5(2)) or (ge5_s5(2) and c0_s5(2));
    t_s5(10) <= r4(10) xor c1_s5(2);
    c2_s5(2) <= r4(10) and c1_s5(2);
    t_s5(11) <= r4(11) xor c2_s5(2);

    -- nibble 3
    t_s5(12) <= r4(12) xor ge5_s5(3);
    c0_s5(3) <= r4(12) and ge5_s5(3);
    t_s5(13) <= r4(13) xor ge5_s5(3) xor c0_s5(3);
    c1_s5(3) <= (r4(13) and ge5_s5(3)) or (r4(13) and c0_s5(3)) or (ge5_s5(3) and c0_s5(3));
    t_s5(14) <= r4(14) xor c1_s5(3);
    c2_s5(3) <= r4(14) and c1_s5(3);
    t_s5(15) <= r4(15) xor c2_s5(3);

    r5 <= t_s5(14 downto 0) & bin(5);

    -------------------------------------------------------------------
    -- STAGE 6: consume bin(4)
    -------------------------------------------------------------------
    ge5_s6(0) <= r5(3)  or (r5(2)  and (r5(1)  or r5(0)));
    ge5_s6(1) <= r5(7)  or (r5(6)  and (r5(5)  or r5(4)));
    ge5_s6(2) <= r5(11) or (r5(10) and (r5(9)  or r5(8)));
    ge5_s6(3) <= r5(15) or (r5(14) and (r5(13) or r5(12)));

    -- nibble 0
    t_s6(0) <= r5(0) xor ge5_s6(0);
    c0_s6(0) <= r5(0) and ge5_s6(0);
    t_s6(1) <= r5(1) xor ge5_s6(0) xor c0_s6(0);
    c1_s6(0) <= (r5(1) and ge5_s6(0)) or (r5(1) and c0_s6(0)) or (ge5_s6(0) and c0_s6(0));
    t_s6(2) <= r5(2) xor c1_s6(0);
    c2_s6(0) <= r5(2) and c1_s6(0);
    t_s6(3) <= r5(3) xor c2_s6(0);

    -- nibble 1
    t_s6(4) <= r5(4) xor ge5_s6(1);
    c0_s6(1) <= r5(4) and ge5_s6(1);
    t_s6(5) <= r5(5) xor ge5_s6(1) xor c0_s6(1);
    c1_s6(1) <= (r5(5) and ge5_s6(1)) or (r5(5) and c0_s6(1)) or (ge5_s6(1) and c0_s6(1));
    t_s6(6) <= r5(6) xor c1_s6(1);
    c2_s6(1) <= r5(6) and c1_s6(1);
    t_s6(7) <= r5(7) xor c2_s6(1);

    -- nibble 2
    t_s6(8)  <= r5(8) xor ge5_s6(2);
    c0_s6(2) <= r5(8) and ge5_s6(2);
    t_s6(9)  <= r5(9) xor ge5_s6(2) xor c0_s6(2);
    c1_s6(2) <= (r5(9) and ge5_s6(2)) or (r5(9) and c0_s6(2)) or (ge5_s6(2) and c0_s6(2));
    t_s6(10) <= r5(10) xor c1_s6(2);
    c2_s6(2) <= r5(10) and c1_s6(2);
    t_s6(11) <= r5(11) xor c2_s6(2);

    -- nibble 3
    t_s6(12) <= r5(12) xor ge5_s6(3);
    c0_s6(3) <= r5(12) and ge5_s6(3);
    t_s6(13) <= r5(13) xor ge5_s6(3) xor c0_s6(3);
    c1_s6(3) <= (r5(13) and ge5_s6(3)) or (r5(13) and c0_s6(3)) or (ge5_s6(3) and c0_s6(3));
    t_s6(14) <= r5(14) xor c1_s6(3);
    c2_s6(3) <= r5(14) and c1_s6(3);
    t_s6(15) <= r5(15) xor c2_s6(3);

    r6 <= t_s6(14 downto 0) & bin(4);

    -------------------------------------------------------------------
    -- STAGE 7: consume bin(3)
    -------------------------------------------------------------------
    ge5_s7(0) <= r6(3)  or (r6(2)  and (r6(1)  or r6(0)));
    ge5_s7(1) <= r6(7)  or (r6(6)  and (r6(5)  or r6(4)));
    ge5_s7(2) <= r6(11) or (r6(10) and (r6(9)  or r6(8)));
    ge5_s7(3) <= r6(15) or (r6(14) and (r6(13) or r6(12)));

    -- nibble 0
    t_s7(0) <= r6(0) xor ge5_s7(0);
    c0_s7(0) <= r6(0) and ge5_s7(0);
    t_s7(1) <= r6(1) xor ge5_s7(0) xor c0_s7(0);
    c1_s7(0) <= (r6(1) and ge5_s7(0)) or (r6(1) and c0_s7(0)) or (ge5_s7(0) and c0_s7(0));
    t_s7(2) <= r6(2) xor c1_s7(0);
    c2_s7(0) <= r6(2) and c1_s7(0);
    t_s7(3) <= r6(3) xor c2_s7(0);

    -- nibble 1
    t_s7(4) <= r6(4) xor ge5_s7(1);
    c0_s7(1) <= r6(4) and ge5_s7(1);
    t_s7(5) <= r6(5) xor ge5_s7(1) xor c0_s7(1);
    c1_s7(1) <= (r6(5) and ge5_s7(1)) or (r6(5) and c0_s7(1)) or (ge5_s7(1) and c0_s7(1));
    t_s7(6) <= r6(6) xor c1_s7(1);
    c2_s7(1) <= r6(6) and c1_s7(1);
    t_s7(7) <= r6(7) xor c2_s7(1);

    -- nibble 2
    t_s7(8)  <= r6(8) xor ge5_s7(2);
    c0_s7(2) <= r6(8) and ge5_s7(2);
    t_s7(9)  <= r6(9) xor ge5_s7(2) xor c0_s7(2);
    c1_s7(2) <= (r6(9) and ge5_s7(2)) or (r6(9) and c0_s7(2)) or (ge5_s7(2) and c0_s7(2));
    t_s7(10) <= r6(10) xor c1_s7(2);
    c2_s7(2) <= r6(10) and c1_s7(2);
    t_s7(11) <= r6(11) xor c2_s7(2);

    -- nibble 3
    t_s7(12) <= r6(12) xor ge5_s7(3);
    c0_s7(3) <= r6(12) and ge5_s7(3);
    t_s7(13) <= r6(13) xor ge5_s7(3) xor c0_s7(3);
    c1_s7(3) <= (r6(13) and ge5_s7(3)) or (r6(13) and c0_s7(3)) or (ge5_s7(3) and c0_s7(3));
    t_s7(14) <= r6(14) xor c1_s7(3);
    c2_s7(3) <= r6(14) and c1_s7(3);
    t_s7(15) <= r6(15) xor c2_s7(3);

    r7 <= t_s7(14 downto 0) & bin(3);

    -------------------------------------------------------------------
    -- STAGE 8: consume bin(2)
    -------------------------------------------------------------------
    ge5_s8(0) <= r7(3)  or (r7(2)  and (r7(1)  or r7(0)));
    ge5_s8(1) <= r7(7)  or (r7(6)  and (r7(5)  or r7(4)));
    ge5_s8(2) <= r7(11) or (r7(10) and (r7(9)  or r7(8)));
    ge5_s8(3) <= r7(15) or (r7(14) and (r7(13) or r7(12)));

    -- nibble 0
    t_s8(0) <= r7(0) xor ge5_s8(0);
    c0_s8(0) <= r7(0) and ge5_s8(0);
    t_s8(1) <= r7(1) xor ge5_s8(0) xor c0_s8(0);
    c1_s8(0) <= (r7(1) and ge5_s8(0)) or (r7(1) and c0_s8(0)) or (ge5_s8(0) and c0_s8(0));
    t_s8(2) <= r7(2) xor c1_s8(0);
    c2_s8(0) <= r7(2) and c1_s8(0);
    t_s8(3) <= r7(3) xor c2_s8(0);

    -- nibble 1
    t_s8(4) <= r7(4) xor ge5_s8(1);
    c0_s8(1) <= r7(4) and ge5_s8(1);
    t_s8(5) <= r7(5) xor ge5_s8(1) xor c0_s8(1);
    c1_s8(1) <= (r7(5) and ge5_s8(1)) or (r7(5) and c0_s8(1)) or (ge5_s8(1) and c0_s8(1));
    t_s8(6) <= r7(6) xor c1_s8(1);
    c2_s8(1) <= r7(6) and c1_s8(1);
    t_s8(7) <= r7(7) xor c2_s8(1);

    -- nibble 2
    t_s8(8)  <= r7(8) xor ge5_s8(2);
    c0_s8(2) <= r7(8) and ge5_s8(2);
    t_s8(9)  <= r7(9) xor ge5_s8(2) xor c0_s8(2);
    c1_s8(2) <= (r7(9) and ge5_s8(2)) or (r7(9) and c0_s8(2)) or (ge5_s8(2) and c0_s8(2));
    t_s8(10) <= r7(10) xor c1_s8(2);
    c2_s8(2) <= r7(10) and c1_s8(2);
    t_s8(11) <= r7(11) xor c2_s8(2);

    -- nibble 3
    t_s8(12) <= r7(12) xor ge5_s8(3);
    c0_s8(3) <= r7(12) and ge5_s8(3);
    t_s8(13) <= r7(13) xor ge5_s8(3) xor c0_s8(3);
    c1_s8(3) <= (r7(13) and ge5_s8(3)) or (r7(13) and c0_s8(3)) or (ge5_s8(3) and c0_s8(3));
    t_s8(14) <= r7(14) xor c1_s8(3);
    c2_s8(3) <= r7(14) and c1_s8(3);
    t_s8(15) <= r7(15) xor c2_s8(3);

    r8 <= t_s8(14 downto 0) & bin(2);

    -------------------------------------------------------------------
    -- STAGE 9: consume bin(1)
    -------------------------------------------------------------------
    ge5_s9(0) <= r8(3)  or (r8(2)  and (r8(1)  or r8(0)));
    ge5_s9(1) <= r8(7)  or (r8(6)  and (r8(5)  or r8(4)));
    ge5_s9(2) <= r8(11) or (r8(10) and (r8(9)  or r8(8)));
    ge5_s9(3) <= r8(15) or (r8(14) and (r8(13) or r8(12)));

    -- nibble 0
    t_s9(0) <= r8(0) xor ge5_s9(0);
    c0_s9(0) <= r8(0) and ge5_s9(0);
    t_s9(1) <= r8(1) xor ge5_s9(0) xor c0_s9(0);
    c1_s9(0) <= (r8(1) and ge5_s9(0)) or (r8(1) and c0_s9(0)) or (ge5_s9(0) and c0_s9(0));
    t_s9(2) <= r8(2) xor c1_s9(0);
    c2_s9(0) <= r8(2) and c1_s9(0);
    t_s9(3) <= r8(3) xor c2_s9(0);

    -- nibble 1
    t_s9(4) <= r8(4) xor ge5_s9(1);
    c0_s9(1) <= r8(4) and ge5_s9(1);
    t_s9(5) <= r8(5) xor ge5_s9(1) xor c0_s9(1);
    c1_s9(1) <= (r8(5) and ge5_s9(1)) or (r8(5) and c0_s9(1)) or (ge5_s9(1) and c0_s9(1));
    t_s9(6) <= r8(6) xor c1_s9(1);
    c2_s9(1) <= r8(6) and c1_s9(1);
    t_s9(7) <= r8(7) xor c2_s9(1);

    -- nibble 2
    t_s9(8)  <= r8(8) xor ge5_s9(2);
    c0_s9(2) <= r8(8) and ge5_s9(2);
    t_s9(9)  <= r8(9) xor ge5_s9(2) xor c0_s9(2);
    c1_s9(2) <= (r8(9) and ge5_s9(2)) or (r8(9) and c0_s9(2)) or (ge5_s9(2) and c0_s9(2));
    t_s9(10) <= r8(10) xor c1_s9(2);
    c2_s9(2) <= r8(10) and c1_s9(2);
    t_s9(11) <= r8(11) xor c2_s9(2);

    -- nibble 3
    t_s9(12) <= r8(12) xor ge5_s9(3);
    c0_s9(3) <= r8(12) and ge5_s9(3);
    t_s9(13) <= r8(13) xor ge5_s9(3) xor c0_s9(3);
    c1_s9(3) <= (r8(13) and ge5_s9(3)) or (r8(13) and c0_s9(3)) or (ge5_s9(3) and c0_s9(3));
    t_s9(14) <= r8(14) xor c1_s9(3);
    c2_s9(3) <= r8(14) and c1_s9(3);
    t_s9(15) <= r8(15) xor c2_s9(3);

    r9 <= t_s9(14 downto 0) & bin(1);

    -------------------------------------------------------------------
    -- STAGE 10: consume bin(0)
    -------------------------------------------------------------------
    ge5_s10(0) <= r9(3)  or (r9(2)  and (r9(1)  or r9(0)));
    ge5_s10(1) <= r9(7)  or (r9(6)  and (r9(5)  or r9(4)));
    ge5_s10(2) <= r9(11) or (r9(10) and (r9(9)  or r9(8)));
    ge5_s10(3) <= r9(15) or (r9(14) and (r9(13) or r9(12)));

    -- nibble 0
    t_s10(0) <= r9(0) xor ge5_s10(0);
    c0_s10(0) <= r9(0) and ge5_s10(0);
    t_s10(1) <= r9(1) xor ge5_s10(0) xor c0_s10(0);
    c1_s10(0) <= (r9(1) and ge5_s10(0)) or (r9(1) and c0_s10(0)) or (ge5_s10(0) and c0_s10(0));
    t_s10(2) <= r9(2) xor c1_s10(0);
    c2_s10(0) <= r9(2) and c1_s10(0);
    t_s10(3) <= r9(3) xor c2_s10(0);

    -- nibble 1
    t_s10(4) <= r9(4) xor ge5_s10(1);
    c0_s10(1) <= r9(4) and ge5_s10(1);
    t_s10(5) <= r9(5) xor ge5_s10(1) xor c0_s10(1);
    c1_s10(1) <= (r9(5) and ge5_s10(1)) or (r9(5) and c0_s10(1)) or (ge5_s10(1) and c0_s10(1));
    t_s10(6) <= r9(6) xor c1_s10(1);
    c2_s10(1) <= r9(6) and c1_s10(1);
    t_s10(7) <= r9(7) xor c2_s10(1);

    -- nibble 2
    t_s10(8)  <= r9(8) xor ge5_s10(2);
    c0_s10(2) <= r9(8) and ge5_s10(2);
    t_s10(9)  <= r9(9) xor ge5_s10(2) xor c0_s10(2);
    c1_s10(2) <= (r9(9) and ge5_s10(2)) or (r9(9) and c0_s10(2)) or (ge5_s10(2) and c0_s10(2));
    t_s10(10) <= r9(10) xor c1_s10(2);
    c2_s10(2) <= r9(10) and c1_s10(2);
    t_s10(11) <= r9(11) xor c2_s10(2);

    -- nibble 3
    t_s10(12) <= r9(12) xor ge5_s10(3);
    c0_s10(3) <= r9(12) and ge5_s10(3);
    t_s10(13) <= r9(13) xor ge5_s10(3) xor c0_s10(3);
    c1_s10(3) <= (r9(13) and ge5_s10(3)) or (r9(13) and c0_s10(3)) or (ge5_s10(3) and c0_s10(3));
    t_s10(14) <= r9(14) xor c1_s10(3);
    c2_s10(3) <= r9(14) and c1_s10(3);
    t_s10(15) <= r9(15) xor c2_s10(3);

    r10 <= t_s10(14 downto 0) & bin(0);

    -------------------------------------------------------------------
    -- Saída final
    -------------------------------------------------------------------
    bcd <= r10;

end architecture expanded;
