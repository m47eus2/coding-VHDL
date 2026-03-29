library IEEE;
use IEEE.std_logic_1164.all;

entity top is
    Port(
        clk500Hz : in STD_LOGIC;
        sw : in STD_LOGIC_VECTOR(9 downto 0);
        key : in STD_LOGIC_VECTOR(3 downto 0);
        led : out STD_LOGIC_VECTOR(9 downto 0);
        hex0 : out STD_LOGIC_VECTOR(6 downto 0);
        hex1 : out STD_LOGIC_VECTOR(6 downto 0)
    );
end top;

architecture Behavioral of top is
begin
    led <= sw;
end Behavioral;