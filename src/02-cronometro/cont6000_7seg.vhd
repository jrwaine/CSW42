library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cont6000_7seg is  -- Contador atÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â© 6000 com saida para 7 segmentos
    port(
        CLK     : in std_logic;
        ZERAR   : in std_logic;
        INICIAR : in std_logic;
        hex_DS  : out std_logic_vector(6 downto 0); -- decimo
        hex_CS  : out std_logic_vector(6 downto 0); -- centesimo
        hex_UN  : out std_logic_vector(6 downto 0); -- unidade
        hex_DZ  : out std_logic_vector(6 downto 0)  -- dezena
    );
    end entity;

architecture a_cont6000_7seg of cont6000_7seg is

    signal RST: std_logic := '1';
    signal EN: std_logic := '0';
    signal aux_EN: std_logic;
    signal DS, CS, UN, DZ: unsigned(3 downto 0);
    signal log_DS, log_CS, log_UN, log_DZ: std_logic_vector(3 downto 0);
    -- signal hex_DS, hex_CS, hex_UN, hex_DZ: std_logic_vector(6 downto 0);

component cont6000 is
    PORT(   RST: in std_logic;
            CLK: in std_logic;
            EN:  in std_logic;
            DS:  out unsigned(3 downto 0);
            CS:  out unsigned(3 downto 0);
            UN:  out unsigned(3 downto 0);
            DZ:  out unsigned(3 downto 0));
end component;

component BCD_7seg is
    port(
        dado_in : in std_logic_vector(3 downto 0);
        hex   : out std_logic_vector(6 downto 0)
    );
end component;

begin
    cron_60: cont6000
        port map(
            RST => RST,
            CLK => CLK,
            EN  => EN,
            CS  => CS,
            DS  => DS,
            UN  => UN,
            DZ  => DZ);
    
    bcd_cs: BCD_7seg
        port map(
            dado_in => log_CS,
            hex     => hex_CS
        );
    bcd_ds: BCD_7seg
        port map(
            dado_in => log_DS,
            hex     => hex_DS
        );
    bcd_un: BCD_7seg
        port map(
            dado_in => log_UN,
            hex     => hex_UN
        );
    bcd_dz: BCD_7seg
        port map(
            dado_in => log_DZ,
            hex     => hex_DZ
        );

    log_CS <= std_logic_vector(CS);
    log_DS <= std_logic_vector(DS);
    log_UN <= std_logic_vector(UN);
    log_DZ <= std_logic_vector(DZ);

    process(INICIAR, CLK) -- Iniciar contagem
    begin
        if(rising_edge(INICIAR)) then
            if aux_EN = '0' or aux_EN = '1' then
                aux_EN <= (not aux_EN);
            else
                aux_EN <= '1';
            end if;
        end if;
    end process;

    process(ZERAR, EN) -- Logica reset
    begin
       if ZERAR = '1' and EN = '0' then
           RST <= '1';
       else 
           RST <= '0';
       end if;
    end process;


    EN <= aux_EN when not (log_DZ = "0110") else '0'; 

end architecture;