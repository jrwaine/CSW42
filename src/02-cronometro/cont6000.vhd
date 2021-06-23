library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cont6000 is
    PORT(   RST: in std_logic;
            CLK: in std_logic;
            EN:  in std_logic;
            DS:  out unsigned(3 downto 0);
            CS:  out unsigned(3 downto 0);
            UN:  out unsigned(3 downto 0);
            DZ:  out unsigned(3 downto 0));
end entity;

architecture a_cont6000 of cont6000 is

    signal EN_DZ, CLR_DZ: std_logic; -- dezena
    signal EN_UN, CLR_UN: std_logic; -- unidade
    signal EN_DS, CLR_DS: std_logic; -- decimo
    signal EN_CS, CLR_CS: std_logic; -- centesimo
    signal EN_GLOBAL: std_logic;     -- desativado quando contador deu 60:00
    signal dezena, unidade, decimo, centesimo: unsigned(3 downto 0);
    signal GND: std_logic;

component cont4_completo is
    PORT(RST: in std_logic;
        CLK: in std_logic;
        Q: out unsigned(3 downto 0);
        EN: in std_logic;
        CLR: in std_logic;
        LD:  in std_logic;
        LOAD: in unsigned (3 downto 0));
end component;

begin
    cont_10_dz: cont4_completo
        port map(
            RST => RST,
            CLK => CLK,
            Q   => dezena,
            EN  => EN_DZ,
            CLR => CLR_DZ,
            LD  => GND,
            LOAD => (others => '0')
        );
    cont_10_un: cont4_completo
        port map(
            RST => RST,
            CLK => CLK,
            Q   => unidade,
            EN  => EN_UN,
            CLR => CLR_UN,
            LD  => GND,
            LOAD => (others => '0')
        );
    cont_10_ds: cont4_completo
        port map(
            RST => RST,
            CLK => CLK,
            Q   => decimo,
            EN  => EN_DS,
            CLR => CLR_DS,
            LD  => GND,
            LOAD => (others => '0')
        );
    cont_10_cs: cont4_completo
        port map(
            RST => RST,
            CLK => CLK,
            Q   => centesimo,
            EN  => EN_CS,
            CLR => CLR_CS,
            LD  => GND,
            LOAD => (others => '0')
        );

    GND <= '0';

    EN_CS <= EN_GLOBAL;
    CLR_CS <= '1' when centesimo = "1001" else '0';

    EN_DS <= CLR_CS and EN_GLOBAL; 
    CLR_DS <= '1' when decimo = "1001" else '0';

    EN_UN <= CLR_DS and EN_GLOBAL;
    CLR_UN <= '1' when unidade = "1001" else '0';

    EN_DZ <= CLR_UN and EN_GLOBAL; 
    CLR_DZ <= '1' when dezena = "1001" else '0';

    -- Conta atÃ© 6000
    EN_GLOBAL <= '0' when dezena = "0110" else 
                 EN;

    CS <= centesimo;
    DS <= decimo;
    UN <= unidade;
    DZ <= dezena;

end architecture;