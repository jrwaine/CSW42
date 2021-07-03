library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity clock_divider is
    port ( clk: in std_logic;
    clock_out: out std_logic);
end entity;

architecture a_clock_divider of clock_divider is

    signal count: integer:=1;
    signal tmp : std_logic := '0';
 
begin

    process(clk)
    begin
    if(clk'event and clk='1') then
        count <=count+1;
        if (count = 5000000) then
        -- if (count = 50) then
                tmp <= NOT tmp;
            count <= 1;
        end if;
    end if;
    clock_out <= tmp;
    end process;

end architecture;