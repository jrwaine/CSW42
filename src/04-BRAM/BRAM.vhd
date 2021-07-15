Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity BRAM is
    PORT(RST       : in  std_logic;        
        CLK       : in  std_logic;        
        READDATA  : out std_logic_vector(7 downto 0);
        WRITEDATA : in  std_logic_vector(7 downto 0);
        WR_EN     : in std_logic;           
        RD_EN     : in std_logic;            
        CS        : in std_logic;           
        ADD       : in std_logic_vector (9 downto 0) -- address
        );
end entity;


Architecture X of BRAM is
signal VDD, GND : std_logic;
Begin

VDD <= '1';
GND <= '0';


End architecture;
