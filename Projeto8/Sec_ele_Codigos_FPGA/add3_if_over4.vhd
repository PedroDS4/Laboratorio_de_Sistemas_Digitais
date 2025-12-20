library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Componente que adiciona 3 a um nibble BCD se ele for maior que 4
entity add3_if_over4 is
    port (
        bcd_in  : in  std_logic_vector(3 downto 0); -- Nibble BCD de entrada
        bcd_out : out std_logic_vector(3 downto 0)  -- Nibble BCD de saída (corrigido se necessário)
    );
end entity add3_if_over4;

architecture BooleanLogic of add3_if_over4 is
    -- Sinal para indicar se a entrada é maior que 4 (>= 5)
    signal is_over_4 : std_logic;

    -- Sinais para calcular (entrada + 3) usando lógica booleana
    signal sum3_0, sum3_1, sum3_2, sum3_3 : std_logic;
    signal c0, c1, c2 : std_logic; -- Carries internos do somador

begin
    -- Lógica para verificar se bcd_in >= 5 (0101)
    -- Condição: bcd_in(3) OR (bcd_in(2) AND bcd_in(1)) OR (bcd_in(2) AND bcd_in(0))
    is_over_4 <= bcd_in(3) or (bcd_in(2) and (bcd_in(1) or bcd_in(0)));

    -- Lógica Booleana para Somador Completo: Calcular BCD_IN + "0011"
    -- Bit 0: bcd_in(0) + 1 (+ carry_in 0)
    sum3_0 <= bcd_in(0) xor '1';         -- Soma = A xor B xor Cin (Cin=0)
    c0     <= bcd_in(0) and '1';         -- Carry = (A and B) or (A and Cin) or (B and Cin)

    -- Bit 1: bcd_in(1) + 1 + c0
    sum3_1 <= bcd_in(1) xor '1' xor c0;
    c1     <= (bcd_in(1) and '1') or (bcd_in(1) and c0) or ('1' and c0);

    -- Bit 2: bcd_in(2) + 0 + c1
    sum3_2 <= bcd_in(2) xor '0' xor c1;  -- Simplifica para: bcd_in(2) xor c1
    c2     <= (bcd_in(2) and '0') or (bcd_in(2) and c1) or ('0' and c1); -- Simplifica para: bcd_in(2) and c1

    -- Bit 3: bcd_in(3) + 0 + c2
    sum3_3 <= bcd_in(3) xor '0' xor c2;  -- Simplifica para: bcd_in(3) xor c2
    -- Carry out do bit 3 não é necessário para o resultado de 4 bits

    -- Lógica MUX usando álgebra booleana:
    -- Se (is_over_4 = '1') então saída = sum3, senão saída = bcd_in
    -- Equivale a: (bcd_in AND (NOT is_over_4)) OR (sum3 AND is_over_4)
    bcd_out(0) <= (bcd_in(0) and not is_over_4) or (sum3_0 and is_over_4);
    bcd_out(1) <= (bcd_in(1) and not is_over_4) or (sum3_1 and is_over_4);
    bcd_out(2) <= (bcd_in(2) and not is_over_4) or (sum3_2 and is_over_4);
    bcd_out(3) <= (bcd_in(3) and not is_over_4) or (sum3_3 and is_over_4);

end architecture BooleanLogic;
