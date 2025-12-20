library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BCD4 is
    port (
        BIN    : in  std_logic_vector(7 downto 0); 
        BCD_C  : out std_logic_vector(3 downto 0);
        BCD_D  : out std_logic_vector(3 downto 0);
        BCD_U  : out std_logic_vector(3 downto 0) 
    );
end entity BCD4;

architecture Behavioral_Generate of BCD4 is

    component add3_if_over4 is
        port (
            bcd_in  : in  std_logic_vector(3 downto 0);
            bcd_out : out std_logic_vector(3 downto 0)
        );
    end component add3_if_over4;

    constant N_BITS     : integer := 8;
    -- 12 bits para BCD (C, D, U) + 8 bits para o Binário = 20 bits
    constant REG_WIDTH  : integer := 12 + N_BITS; 

    type t_stage_vector is array (0 to N_BITS) of std_logic_vector(REG_WIDTH - 1 downto 0);
    signal stages : t_stage_vector;

begin

    -- Inicializa o primeiro estágio com o valor binário à direita e zeros à esquerda
    stages(0) <= std_logic_vector(resize(unsigned(BIN), REG_WIDTH));

    gen_stages : for i in 0 to N_BITS - 1 generate
        signal c_corrected, d_corrected, u_corrected : std_logic_vector(3 downto 0);
        signal corrected_stage : std_logic_vector(REG_WIDTH - 1 downto 0);
    begin
        -- Mapeamento dos blocos de 4 bits para correção
        -- Centena: bits 19 a 16 | Dezena: 15 a 12 | Unidade: 11 a 8 | Binário: 7 a 0
        corr_C: add3_if_over4 port map ( bcd_in => stages(i)(19 downto 16), bcd_out => c_corrected );
        corr_D: add3_if_over4 port map ( bcd_in => stages(i)(15 downto 12), bcd_out => d_corrected );
        corr_U: add3_if_over4 port map ( bcd_in => stages(i)(11 downto 8),  bcd_out => u_corrected );

        -- Remonta o registrador (20 bits total)
        corrected_stage <= c_corrected & d_corrected & u_corrected & stages(i)(7 downto 0);

        -- Deslocamento à esquerda para o próximo estágio
        stages(i+1) <= std_logic_vector(unsigned(corrected_stage) sll 1);
    end generate gen_stages;

    -- Saídas finais (pegamos do último estágio após todos os shifts)
    -- Importante: No último shift, o valor "anda" uma casa, então os índices mudam
    BCD_C <= stages(N_BITS)(19 downto 16);
    BCD_D <= stages(N_BITS)(15 downto 12);
    BCD_U <= stages(N_BITS)(11 downto 8);

end architecture Behavioral_Generate;
