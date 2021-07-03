library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
entity cont_3bits_tb is
end entity;
------------------------------------------------------------------------

architecture a_cont_3bits_tb of cont_3bits_tb is
    signal CLK: std_logic;
    signal dado: std_logic_vector(2 downto 0);
    signal cont_bit_var: std_logic_vector(1 downto 0);
    signal cont_bit_sig: std_logic_vector(1 downto 0);
    signal cont_bit_sum: std_logic_vector(1 downto 0);

    component cont_3bits is
        port(
            CLK : in std_logic;
            -- Dado de entrada
            dado_in : in std_logic_vector(2 downto 0);
            -- Conta 3 bits com variaveis
            cont_bit_var: out std_logic_vector(1 downto 0);
            -- Conta 3 bits com variaveis
            cont_bit_sig: out std_logic_vector(1 downto 0);
            -- Conta 3 bits com soma de 3 sinais
            cont_bit_sum: out std_logic_vector(1 downto 0)
        );
    end component;

begin

    cont_3b_tb: cont_3bits
        port map(
            CLK => CLK,
            dado_in  => dado,
            cont_bit_var  => cont_bit_var,
            cont_bit_sig  => cont_bit_sig,
            cont_bit_sum  => cont_bit_sum);

    process -- clock process
    begin
        CLK <= '0';
        wait for 50 ns;
        CLK <= '1';
        wait for 50 ns;
    end process;

    process -- dado process
    begin
        wait for 25 ns;
        dado <= "000";
        wait for 50 ns;
        dado <= "001";
        wait for 50 ns;
        dado <= "110";
        wait for 50 ns;
        dado <= "111";
        wait for 50 ns;
        dado <= "010";
        wait for 25 ns;
    end process;

end architecture;
