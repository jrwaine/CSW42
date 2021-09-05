Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity LFSR_interface is
    PORT(
        clk: in std_logic;
        rst: in std_logic;
        addr: in std_logic_vector(1 downto 0);
        write_data: in std_logic_vector(31 downto 0);
        read_data: out std_logic_vector(31 downto 0);
        wr_en: in std_logic;
        rd_en: in std_logic;
        cs: in std_logic
        -- Reg 0
        -- seed: in std_logic_vector(31 downto 0);
        -- Reg 1
        -- generate_random: in std_logic_vector(31 downto 0);
        -- random_number: out std_logic_vector(31 downto 0)
);
end entity;

Architecture a_LFSR_interface of LFSR_interface is

    signal generate_random: std_logic;
    signal seed: std_logic_vector(31 downto 0);
    signal random_number: std_logic_vector(31 downto 0);
    signal s_read_data: std_logic_vector(31 downto 0);
    signal s_generate_random: std_logic;
    component LFSR is
        port(
            clk: in std_logic;
            gen_number: in std_logic;
            seed: in std_logic_vector(31 downto 0);
            random_val: out std_logic_vector(31 downto 0));
    end component;
Begin

    m_lsfr: LFSR
    port map(
        clk => clk,
        gen_number => generate_random,
        seed => seed,
        random_val => random_number);

    s_read_data <= random_number when rd_en = '1' else (others => '0');
    -- Only generate when reading
    generate_random <= s_generate_random when rd_en = '1' and addr = "10" else '0';

    s_generate_random <= write_data(31) when addr = "01" and wr_en = '1' else 
        s_generate_random;
    
    seed <= write_data when addr = "00" and wr_en = '1' else seed;

    read_data <= s_read_data;

End architecture;