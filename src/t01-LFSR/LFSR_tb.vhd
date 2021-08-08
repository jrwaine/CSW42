Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LFSR_tb is
end entity;

architecture a_LFSR_tb of LFSR_tb is
    signal gen_number: std_logic;
    signal clk: std_logic;
    signal seed: std_logic_vector(31 downto 0);
    signal random_number: std_logic_vector(31 downto 0);
    
    component LFSR is
        port(
            clk: in std_logic;
            gen_number: in std_logic;
            seed: in std_logic_vector(31 downto 0);
            random_val: out std_logic_vector(31 downto 0));
    end component;
begin
    m_lsfr_tb: LFSR
    port map(
        clk => clk,
        gen_number => gen_number,
        seed => seed,
        random_val => random_number);

    gen_clock: process
    begin
        clk <= '1';
        wait for 50 ns;
        clk <= '0';
        wait for 50 ns;
    end process gen_clock;

    gen_number_p: process
    begin
        gen_number <= '1';
        wait for 500 ns;
        gen_number <= '0';
        wait for 100 ns;
    end process gen_number_p;

    seed <= x"ABCDEF12";

end architecture;