library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
entity cont is
    port(
        CLK : in std_logic;
        RST:  in std_logic;
        -- Conta com variaveis
        cont_var: out std_logic_vector(3 downto 0);
        -- Conta com sinais
        cont_sig: out std_logic_vector(3 downto 0)
    );
end entity;
------------------------------------------------------------------------

architecture a_cont of cont is
    signal s_cont_sig: unsigned(3 downto 0) := "0000";
    signal s_cont_var: unsigned(3 downto 0) := "0000";

begin
------------------------ Conta com signal -----------------------------
    process (CLK, RST)
    begin
        if RST = '1' then
            s_cont_sig <= "0000";
        elsif rising_edge(CLK) then
            s_cont_sig <= s_cont_sig+1;
        end if;
    end process;
    cont_sig <= std_logic_vector(s_cont_sig);
------------------------------------------------------------------------

------------------------- Conta com variaveis --------------------------
    -- Variable cont
    process (CLK, RST)
    variable v_cont_var : unsigned(3 downto 0) := "0000";
    -- Only update in clock cycle
    begin
        if RST = '1' then
            v_cont_var := "0000";
        elsif rising_edge(CLK) then
            v_cont_var := v_cont_var+1;
        end if;
        s_cont_var <= v_cont_var;
    end process;
    cont_var <= std_logic_vector(s_cont_var);
-----------------------------------------------------------------------

end architecture;
