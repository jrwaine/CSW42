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
signal GND, VCC: std_logic; 
signal rst, clk: std_logic;
signal READDATA, WRITEDATA : std_logic_vector(7 downto 0);
signal ADD : std_logic_vector(9 downto 0);
TYPE state_type is (idle_st0,idle_st1, write_st0, write_st1, read_st0, read_st1);
signal state : state_type; 
signal INTERVAL_0, INTERVAL_1, counter, address : integer;
signal CS, WR_EN, RD_EN    : std_logic; 

begin  

INTERVAL_0 <= 10;
INTERVAL_1 <= 15;

GND <= '0';
VCC <= '1';

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
--	   READDATA   <= (others => '0');
--	   WRITEDATA  <= (others => '0');
--	   WR_EN      <= '0';
--	   RD_EN      <= '0'; 
--	   CS         <= '0';
--	   ADD        <= (others => '0');
       counter    <= 0;		
       state      <= idle_st0;
    Elsif CLK' event and CLK = '1' then
        counter <= counter + 1;
        case state is
            when idle_st0 => 
                if counter = INTERVAL_0 then 
                    state <= write_st0;
                    counter <= 0;
                end if;	
            when write_st0 => 
                state <= write_st1;
                counter <= 0;
            when write_st1 => 
                state <= idle_st1;
                counter <= 0;
            when idle_st1 => 
                if counter = INTERVAL_1 then 
                    state <= read_st0;
                    counter <= 0;
                end if;	
            when read_st0 => 
                state <= read_st1;
                counter <= 0;
            when read_st1 => 
                --if counter = INTERVAL_1 then 
                    state <= idle_st0;
                    counter <= 0;
                --end if;	
                address  <= address + 1;
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
                WRITEDATA  <= x"55";
                WR_EN      <= '1';
                RD_EN      <= '0'; 
                CS         <= '1';
                ADD        <= std_logic_vector(to_unsigned(address, ADD'length));
            when write_st1 => 
                WRITEDATA  <= x"55";
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

