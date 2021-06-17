library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
entity BCD_7seg is
    port(
        dado_in : in std_logic_vector(3 downto 0);
        hex   : out std_logic_vector(6 downto 0)
    );
end entity;
------------------------------------------------------------------------

architecture a_BCD_7seg of BCD_7seg is

begin
    -- abcdefg
    hex <= "1111110" when dado_in = "0000" else
        "0110000" when dado_in = "0001" else
        "1101101" when dado_in = "0010" else
        "1111001" when dado_in = "0011" else
        "0110011" when dado_in = "0100" else
        "1011011" when dado_in = "0101" else
        "1011111" when dado_in = "0110" else
        "1110000" when dado_in = "0111" else
        "1111111" when dado_in = "1000" else
        "1111011" when dado_in = "1001" else
        "0000000";

end architecture;
