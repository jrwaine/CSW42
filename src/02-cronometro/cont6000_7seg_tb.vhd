library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cont6000_7seg_tb is
end entity;

architecture a_cont6000_7seg_tb of cont6000_7seg_tb is

    signal CLK, ZERAR, INICIAR: std_logic;
    signal hex_DS, hex_CS, hex_UN, hex_DZ: std_logic_vector(6 downto 0);

component cont6000_7seg is
    port(
        CLK     : in std_logic;
        ZERAR   : in std_logic;
        INICIAR : in std_logic;
        hex_DS  : out std_logic_vector(6 downto 0);
        hex_CS  : out std_logic_vector(6 downto 0);
        hex_UN  : out std_logic_vector(6 downto 0);
        hex_DZ  : out std_logic_vector(6 downto 0)
    );
end component;

begin
    cron_60_7seg: cont6000_7seg
        port map(
            ZERAR => ZERAR,
            CLK => CLK,
            INICIAR  => INICIAR,
            hex_DS  => hex_DS,
            hex_CS  => hex_CS,
            hex_UN  => hex_UN,
            hex_DZ  => hex_DZ);

    process begin -- clock
        CLK <= '0';
        wait for 5 ns;
        CLK <= '1';
        wait for 5 ns;
    end process;

    process begin -- Zerar
        ZERAR <= '0';
        wait for 70000 ns;
        ZERAR <= '1';
        wait for 1 ns;
    end process;

    process begin -- Iniciar
    INICIAR <= '0';
    wait for 30 ns;
    INICIAR <= '1'; -- acionar
    wait for 30 ns;
    INICIAR <= '0';
    wait for 30 ns;
    INICIAR <= '1'; -- pausar
    wait for 30 ns;
    INICIAR <= '0';
    wait for 30 ns;
    INICIAR <= '1'; -- resumir
    wait for 30 ns;
    INICIAR <= '0';
    wait for 70000 ns;

end process;

end architecture;