library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cont6000_7seg_tb is
end entity;

architecture a_cont6000_7seg_tb of cont6000_7seg_tb is

    signal CLK, RST, EN: std_logic;
    signal hex_DS, hex_CS, hex_UN, hex_DZ: std_logic_vector(6 downto 0);

component cont6000_7seg is
    port(
        CLK     : in std_logic;
        RST     : in std_logic;
        EN      : in std_logic;       
        hex_DS  : out std_logic_vector(6 downto 0);
        hex_CS  : out std_logic_vector(6 downto 0);
        hex_UN  : out std_logic_vector(6 downto 0);
        hex_DZ  : out std_logic_vector(6 downto 0)
    );
end component;

begin
    cron_60_7seg: cont6000_7seg
        port map(
            RST => RST,
            CLK => CLK,
            EN  => EN,
            hex_DS  => hex_DS,
            hex_CS  => hex_CS,
            hex_UN  => hex_UN,
            hex_DZ  => hex_DZ);

    EN <= '1';
    RST <= '1';

    process begin -- clock
        CLK <= '0';
        wait for 50 ms;
        CLK <= '1';
        wait for 50 ms;
    end process;

    process begin -- reset
        RST <= '1';
        wait for 50 ns;
        RST <= '0';
        wait for 10000000 ms;
    end process;

end architecture;