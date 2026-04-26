library ieee;
use ieee.std_logic_1164.all;

-- TOP

entity top is
    Port(
        clk500Hz : in std_logic;
        sw : in std_logic_vector(9 downto 0);
        key : in std_logic_vector(3 downto 0);
        led : out std_logic_vector(9 downto 0);
        hex0 : out std_logic_vector(6 downto 0);
        hex1 : out std_logic_vector(6 downto 0)
    );
end top;

architecture behavioral of top is
begin
    u1: entity work.mc_adder port map(sw(3 downto 0), led(4 downto 0));
end behavioral;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mc_adder is
    port(
        a : in std_logic_vector(3 downto 0);
        b : out std_logic_vector(4 downto 0)
    );
end mc_adder;

architecture arch1 of mc_adder is
begin
    process(a)
        variable a_i : integer range 0 to 255;
        variable b_i : integer range 0 to 255;
    begin
        a_i := to_integer(unsigned(a));
        b_i := a_i + 1;
        b <= std_logic_vector(to_unsigned(b_i,5));
    end process;
end arch1;