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

library IEEE;
use IEEE.std_logic_1164.all;

entity mc_7seg_2bit_decoder is
    port(
        s : in std_logic_vector(1 downto 0);
        y : out std_logic_vector(6 downto 0) 
    );
end mc_7seg_2bit_decoder;

--
-- ARCHITECTURE
--

architecture behavioral of top is
begin
    u1: entity work.mc_7seg_2bit_decoder port map(
        s => sw(1 downto 0),
        y => hex0
    );
end behavioral;

architecture arch1 of mc_7seg_2bit_decoder is
begin
    with s select
        y <= "0100001" when "00",
        "0000110" when "01",
        "1111001" when "10",
        "1000000" when "11",
        "1111111" when others;
end architecture arch1;