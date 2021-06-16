Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity cont4_tb is
end entity;
architecture nome_qualquer of cont4_tb is
component cont4 is
	PORT(RST: in std_logic;
	     CLK: in std_logic;
		  Q: out unsigned(3 downto 0);
		  EN: in std_logic;
		  CLR: in std_logic;
		  LD:  in std_logic;
		  LOAD: in unsigned (3 downto 0));
end component;  

    signal CLK, EN, RST, CLR, LD: std_logic;
    signal LOAD, Q: unsigned(3 downto 0);
begin
     DUT: cont4
	port map
	     (CLK => CLK,
		  RST => RST,
		  Q => Q,
                    EN => EN,
                    CLR=> CLR,
                    LD  => LD,
                    LOAD => LOAD);

	process begin -- clock process
		CLK <= '0';
		wait for 15 ns;
		CLK <= '1';
		wait for 15 ns;
	end process;
	
	process begin -- load process
		LD <= '1';
		wait for 30 ns;
		LD <= '0';
		wait for 1500 ns;
	end process;

	process begin -- clear process
		CLR <= '0';
		wait for 500 ns;
		CLR <= '1';
		wait for 30 ns;
	end process;

	process begin -- enable process
		EN <= '1';
		-- disable enable after 1000 ns
		wait for 1000 ns;
		EN <= '0';
		wait for 30 ns;
		EN <= '1';
		wait for 500 ns;
	end process;
	
	process begin -- reset process
		RST <= '0';
		-- reset after 1500 ns
		wait for 1500 ns;
		RST <= '1';
		wait for 30 ns;
	end process;

	LOAD <= "0001";

end architecture;