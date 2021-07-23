library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BRAM is
    port(RST       : in  std_logic;        
        CLK       : in  std_logic;        
        READDATA  : out std_logic_vector(7 downto 0);
        WRITEDATA : in  std_logic_vector(7 downto 0);
        WR_EN     : in std_logic;           
        RD_EN     : in std_logic;            
        CS        : in std_logic;           -- Chip select
        ADD       : in std_logic_vector (9 downto 0) -- address
        );
end entity;


Architecture X of BRAM is
    -- RAM of 2^10 addresses with 2^8 bits each
    type mem is array(9 downto 0) of std_logic_vector(7 downto 0);
    signal ram_block: mem;
    signal ADD_int: integer range 0 to 1023;
Begin
    ADD_int <= to_integer(unsigned(ADD));

    process(CLK, RST, CS)
    begin
        if(CS = '0') then
            -- What does RST does????
            if(RST = '1') then
                ram_block(ADD_int) <= "00000000";
            elsif(rising_edge(CLK)) then
                if WR_EN = '1' then
                    ram_block(ADD_int) <= WRITEDATA;
                end if;
                if RD_EN = '1' then
                    READDATA <= ram_block(ADD_int);
                end if;
            end if;
        end if;
    end process;

End architecture;
