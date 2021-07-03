library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
entity cont_w_divider is
    port(
        CLK : in std_logic;
        CLK_DIV: out std_logic;
        RST:  in std_logic;
        RST_VAL: out std_logic;
        cont_var: out std_logic_vector(3 downto 0);
        cont_sig: out std_logic_vector(3 downto 0)
    );
end entity;
------------------------------------------------------------------------

architecture a_cont_w_divider of cont_w_divider is
    signal s_CLK_DIV: std_logic;

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

    component clock_divider is
        port ( clk: in std_logic;
        clock_out: out std_logic);
    end component;

begin
    m_cont: cont
    port map(
        CLK => s_CLK_DIV,
        RST  => RST,
        cont_var  => cont_var,
        cont_sig  => cont_sig);

    m_clk_div: clock_divider
    port map(
        clk => CLK,
        clock_out  => s_CLK_DIV);

    CLK_DIV <= s_CLK_DIV;
    RST_VAL <= RST;
end architecture;
