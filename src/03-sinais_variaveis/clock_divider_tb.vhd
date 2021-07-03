library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity clock_divider_tb is
end entity;

architecture a_clock_divider_tb of clock_divider_tb is
    signal clk, clock_out: std_logic;

    component clock_divider is
        port ( clk: in std_logic;
        clock_out: out std_logic);
    end component;
begin

    m_clk_div: clock_divider
        port map(
            clk => clk,
            clock_out => clock_out
        );

    process begin
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
    end process;

end architecture;