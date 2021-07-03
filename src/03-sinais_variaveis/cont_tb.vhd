library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
entity cont_tb is
end entity;
------------------------------------------------------------------------

architecture a_cont_tb of cont_tb is
    signal CLK, RST: std_logic;
    signal cont_var, cont_sig: std_logic_vector(3 downto 0);

    component cont is
        port(
            CLK : in std_logic;
            RST:  in std_logic;
            -- Conta com variaveis
            cont_var: out std_logic_vector(3 downto 0);
            -- Conta com sinais
            cont_sig: out std_logic_vector(3 downto 0)
        );
    end component;
begin
    m_cont_tb: cont
    port map(
        CLK => CLK,
        RST  => RST,
        cont_var  => cont_var,
        cont_sig  => cont_sig);

    process -- clock process
    begin
        CLK <= '0';
        wait for 50 ns;
        CLK <= '1';
        wait for 50 ns;
    end process;

    process -- clock process
    begin
        RST <= '1';
        wait for 100 ns;
        RST <= '0';
        wait for 1000 ns;
        RST <= '1';
        wait for 300 ns;
        RST <= '0';
        wait for 9000 ns;
    end process;


end architecture;
