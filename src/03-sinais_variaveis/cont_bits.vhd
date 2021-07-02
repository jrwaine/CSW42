library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
entity cont_bits is
    -- port(
    --     dado_in : in std_logic_vector(3 downto 0);
    --     hex   : out std_logic_vector(6 downto 0)
    -- );
end entity;
------------------------------------------------------------------------

architecture a_cont_bits of cont_bits is
    -- signal neg_hex : std_logic_vector(6 downto 0);
begin
    -- process (CLK)
    -- -- Only update in clock cycle
    -- begin
    --     if CLK' event and CLK = '1' then
    --         if EN_ZERAR = '1' and EN_CONT = '0' then
    --             RST <= '1';
    --         else
    --             RST <= '0';
    --         end if;
    --         -- Conta até 6000
    --         if log_DZ = "0110" then
    --             EN_CONT <= '0';
    --         elsif EN_INIT = '1' then
    --             EN_CONT <= not EN_CONT;
    --         end if;
    --     end if;
    -- end process;
end architecture;
