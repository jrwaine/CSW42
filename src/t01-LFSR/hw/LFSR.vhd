Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity LFSR is
    PORT(
        clk: in std_logic;
        gen_number: in std_logic;
        seed: in std_logic_vector(31 downto 0);
        random_val: out std_logic_vector(31 downto 0));
end entity;

Architecture a_LFSR of LFSR is
    signal feedback: std_logic;
    signal curr_number, next_number: std_logic_vector(31 downto 0);
Begin
    Process (gen_number, clk)
    variable v_is_init : std_logic := '0';
    Begin
        if(rising_edge(clk) and gen_number = '1')  then
            -- Set seed only once
            if(v_is_init = '0') then
                curr_number <= (((seed(31) xor seed(21)) 
                        xor seed(1)) 
                    xor seed(0)) & seed(31 downto 1);
                v_is_init := '1';
            else
                curr_number <= next_number;
            end if;
        end if;
    End process;

    -- feedback polynomial x^32+x^22+x^2+x^1+1
    feedback <= 
        ((curr_number(31) xor curr_number(21)) 
            xor curr_number(1)) 
        xor curr_number(0);
    next_number <= feedback & curr_number(31 downto 1);

    random_val <= curr_number;
End architecture;