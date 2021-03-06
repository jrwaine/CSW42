Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity BRAM_tb is
end entity;

Architecture X of BRAM_tb is

component BRAM is
    PORT(RST       : in  std_logic;        
        CLK       : in  std_logic;        
        READDATA  : out std_logic_vector(7 downto 0);
        WRITEDATA : in  std_logic_vector(7 downto 0);
        WR_EN     : in std_logic;           
        RD_EN     : in std_logic;            
        CS        : in std_logic;           
        ADD       : in std_logic_vector (9 downto 0)
        );
end component; 
signal rst, clk: std_logic;
signal READDATA, WRITEDATA : std_logic_vector(7 downto 0);
signal ADD : std_logic_vector(9 downto 0);
TYPE state_type is (idle_st0,idle_st1, write_st0, write_st1, read_st0, read_st1);
signal state : state_type; 
signal counter, address : integer := 0;
signal INTERVAL_RD_WR : integer := 10;
signal CS, WR_EN, RD_EN    : std_logic; 

signal plus : std_logic_vector(7 downto 0) := x"2b";
signal minus : std_logic_vector(7 downto 0) := x"2d";
signal space : std_logic_vector(7 downto 0) := x"20";

type my_name_type is array(30 downto 0) of std_logic_vector(7 downto 0);
signal my_name: my_name_type := (
    0 => x"57", -- W
    1 => x"61", -- a
    2 => x"69", -- i
    3 => x"6E", -- n
    4 => x"65", -- e
    5 => space, 
    6 => x"4F", -- O
    7 => x"6C", -- l
    8 => x"69", -- i
    9 => x"76", -- v
    10 => x"65", -- e
    11 => x"69", -- i
    12 => x"72", -- r
    13 => x"61", -- a
    14 => space, 
    15 => x"4A", -- J
    16 => x"75", -- u
    17 => x"6E", -- n
    18 => x"69", -- i
    19 => x"6F", -- o
    20 => x"72", -- r
    21 => space, 
    22 => plus, 
    23 => plus, 
    24 => plus, 
    25 => minus,
    26 => minus, 
    27 => plus, 
    28 => plus, 
    29 => plus, 
    30 => space
    );
    signal counter_name : integer := 0;
    signal name_size : integer := 31;

begin  

gera_rst:process 
begin 
    rst <= '1';
    wait for 15 ns;
    rst <= '0';
    wait;
end process;

gera_clk:process 
begin 
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
end process;

DUT:BRAM
    port map
       (RST       => rst      ,
        CLK       => clk      ,
        READDATA  => READDATA , 
        WRITEDATA => WRITEDATA, 
        WR_EN     => WR_EN    , 
        RD_EN     => RD_EN    , 
        CS        => CS       , 
        ADD       => ADD       
        );

gera_data_we_rd_add_cs : process (RST, CLK)
begin
    If RST = '1' then
       state      <= idle_st0;
    Elsif CLK' event and CLK = '1' then
        counter <= counter + 1;
        case state is
            when idle_st0 => 
                if counter = INTERVAL_RD_WR then 
                    state <= write_st0;
                    counter <= 0;
                end if;
            when write_st0 => 
                state <= write_st1;
            when write_st1 => 
                if( counter_name = name_size - 1) then
                    counter_name <= 0;
                else
                    counter_name <= counter_name + 1;
                end if;
                address  <= address + 1;
                if(address >= 1024) then
                    address <= 0;
                    state <= idle_st1;
                else
                    state <= idle_st0;
                end if;
                counter <= 0;
            when idle_st1 => 
                state <= read_st0;
                counter <= 0;
            when read_st0 => 
                state <= read_st1;
                if counter = INTERVAL_RD_WR then 
                    state <= read_st0;
                    counter <= 0;
                end if;
            when read_st1 => 
                address  <= address + 1;
                if(address >= 1024) then
                    address <= 0;
                end if;
                state <= idle_st1;
                counter <= 0;
        end case;
    end if;

End process;

process(state)
begin
        case state is
            when idle_st0 => 
--              READDATA   <= (others => '0');
                WRITEDATA  <= x"00";
                WR_EN      <= '0';
                RD_EN      <= '0'; 
                CS         <= '0';
                ADD        <= (others => '0');
            when write_st0 => 
                WRITEDATA  <= my_name(counter_name);
                WR_EN      <= '1';
                RD_EN      <= '0'; 
                CS         <= '1';
                ADD        <= std_logic_vector(to_unsigned(address, ADD'length));
            when write_st1 => 
                WRITEDATA  <= my_name(counter_name);
                WR_EN      <= '0';
                RD_EN      <= '0'; 
                CS         <= '0';
                ADD        <= std_logic_vector(to_unsigned(address, ADD'length));
            when idle_st1 => 
                WRITEDATA  <= (others => '0');
                WR_EN      <= '0';
                RD_EN      <= '0'; 
                CS         <= '0';
                ADD        <= (others => '0');
            when read_st0 => 
                WRITEDATA  <= x"00";
                WR_EN      <= '0';
                RD_EN      <= '1'; 
                CS         <= '1';
                ADD        <= std_logic_vector(to_unsigned(address, ADD'length));
            when read_st1 => 
                WRITEDATA  <= x"00";
                WR_EN      <= '0';
                RD_EN      <= '0'; 
                CS         <= '0';
                ADD        <= std_logic_vector(to_unsigned(address, ADD'length));
        end case;    	
end process;	

End architecture;

