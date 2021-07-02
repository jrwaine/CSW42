library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
entity cont_3bits is
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
end entity;
------------------------------------------------------------------------

architecture a_cont_3bits of cont_3bits is
    signal s_cont_bit_sig : std_logic_vector(1 downto 0) := "00";
    signal s_cont_bit_var : std_logic_vector(1 downto 0);
    signal s_bit1, s_bit2, s_bit3 : unsigned(1 downto 0);
begin
--------------------- Conta 3 bits com signal --------------------------

    process (CLK)
    -- Only update in clock cycle
    begin
        if rising_edge(CLK) then
            cont_bit_sig <= s_cont_bit_sig;
        end if;
    end process;
    s_cont_bit_sig <= "00" when dado_in = "000" else 
                    "11" when dado_in = "111" else 
                    "01" when dado_in = "100" or dado_in = "010" or dado_in = "001" else
                    "10";
------------------------------------------------------------------------

--------------------- Conta 3 bits com variaveis -----------------------
    -- Variable cont
    process (CLK)
    variable v_cont_bit_var : unsigned(1 downto 0) := "00";
    -- Only update in clock cycle
    begin
        if rising_edge(CLK) then
            for i in dado_in'range loop
                if dado_in(i) = '1' then
                    v_cont_bit_var := v_cont_bit_var + 1;
                end if;
            end loop;
            s_cont_bit_var <= std_logic_vector(v_cont_bit_var);
        end if;
    end process;
    cont_bit_var <= s_cont_bit_var;
-----------------------------------------------------------------------

--------------------- Conta 3 bits somando 3 signals ------------------
    s_bit1 <= "0" & dado_in(0);
    s_bit2 <= "0" & dado_in(1);
    s_bit3 <= "0" & dado_in(2);
    -- Sum cont
    process (CLK)
    -- Only update in clock cycle
    begin
        if rising_edge(CLK) then
            cont_bit_sum <= std_logic_vector(s_bit1+s_bit2+s_bit3);
        end if;
    end process;
-----------------------------------------------------------------------


end architecture;
