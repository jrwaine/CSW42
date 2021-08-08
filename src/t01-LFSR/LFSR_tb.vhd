Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LFSR_tb is
end entity;

architecture a_LFSR_tb of LFSR_tb is
    signal gen_number: std_logic;
    signal seed: std_logic_vector(31 downto 0);
    signal random_number: std_logic_vector(31 downto 0);
    
    component LFSR is
        port(
            gen_number: in std_logic;
            seed: in std_logic_vector(31 downto 0);
            random_val: out std_logic_vector(31 downto 0));
    end component;
begin
    m_lsfr_tb: LFSR
    port map(
        gen_number => gen_number,
        seed => seed,
        random_val => random_number);

    gen_clock: process
    begin
        gen_number <= '1';
        wait for 50 ns;
        gen_number <= '0';
        wait for 50 ns;
    end process gen_clock;

    seed <= x"ABCDEF12";

end architecture;