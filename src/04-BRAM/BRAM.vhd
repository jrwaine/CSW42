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
    
    signal read_data: std_logic_vector(7 downto 0);
    signal s_wr_en: std_logic;

    Component RAM_1_port is
        port(
            address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
            clock		: IN STD_LOGIC;
            data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            wren		: IN STD_LOGIC ;
            q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
        end component;
Begin
    ram: RAM_1_port
    port map(
        address => ADD,
        clock => CLK,
        data => WRITEDATA,
        wren=> s_wr_en,
        q=>read_data
    );

    process(CLK, RST, CS)
    begin
        -- What does RST does????
        if(RST = '1') then
            s_wr_en <= '0';
            READDATA <= "00000000";
        elsif(CS = '1') then
            s_wr_en <= WR_EN;
            if(rising_edge(CLK)) then
                if RD_EN = '1' then
                    READDATA <= read_data;
                else
                    READDATA <= "00000000";
                end if;
            end if;
        else
            s_wr_en <= '0';
        end if;
    end process;

End architecture;
