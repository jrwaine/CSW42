library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BCD_7seg_tb is
end entity;

architecture a_BCD_7seg_tb of BCD_7seg_tb is
    component BCD_7seg is
        port(
            dado_in : in std_logic_vector(3 downto 0);
            hex   : out std_logic_vector(6 downto 0)
        );
    end component;
    signal s_dado_in: std_logic_vector(3 downto 0);
    signal s_hex: std_logic_vector(6 downto 0);

    begin
        uut: BCD_7seg port map (
                    dado_in=>s_dado_in,
                    hex=>s_hex);

        process begin
            s_dado_in <= "0000";
            wait for 50 ns;
            s_dado_in <= "0001";
            wait for 50 ns;
            s_dado_in <= "0010";
            wait for 50 ns;
            s_dado_in <= "0011";
            wait for 50 ns;
            s_dado_in <= "0100";
            wait for 50 ns;
            s_dado_in <= "0101";
            wait for 50 ns;
            s_dado_in <= "0110";
            wait for 50 ns;
            s_dado_in <= "0111";
            wait for 50 ns;
            s_dado_in <= "1000";
            wait for 50 ns;
            s_dado_in <= "1001";
            wait for 50 ns;
        end process;

end architecture;