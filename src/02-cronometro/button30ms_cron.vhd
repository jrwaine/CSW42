library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity button30ms_cron is
    PORT(
            CLK_CS: in std_logic;   -- clock com frequência de 1 centesimo de segundo
            BUTTON:  in std_logic;  -- estado do botão
            EN: out std_logic       -- botao esta habilitado ou nao (pressionado por mais de 30 ms)
            );
end entity;

architecture a_button30ms_cron of button30ms_cron is
    signal EN_UN, CLR_UN: std_logic; -- unidade
    signal EN_BUTTON: std_logic;
    signal RST_CONT: std_logic;
    signal unidade: unsigned(3 downto 0);

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
    cont_10_un: cont4_completo
        port map(
            RST => RST_CONT,
            CLK => CLK_CS,
            Q   => unidade,
            EN  => EN_UN,
            CLR => CLR_UN,
            LD  => '0',
            LOAD => (others => '0')
        );

    -- Conta enquanto o botao estiver apertado e unidade nao for 4
    EN_UN <= '1' when BUTTON = '1' and (not (unidade = "0100")) else '0'; 
    -- Reseta contador se botao nao esta pressionado
    RST_CONT <= not BUTTON;
    -- Considera habilitado em 3 apenas
    EN_BUTTON <= '1' when unidade = "0011"
            else '0';
    CLR_UN <= RST_CONT;

    EN <= EN_BUTTON;
end architecture;