library ieee;
use ieee.std_logic_1164.all;

entity top is
    port(
        clk500Hz : in std_logic;
        sw : in std_logic_vector(9 downto 0);
        key : in std_logic_vector(3 downto 0);
        led : out std_logic_vector(9 downto 0);
        hex0 : out std_logic_vector(6 downto 0);
        hex1 : out std_logic_vector(6 downto 0)
    );
end top;

library ieee;
use ieee.std_logic_1164.all;

entity mc_mux2 is
    port(
        a,b,s : in std_logic;
        y : out std_logic
    );
end mc_mux2;

library ieee;
use ieee.std_logic_1164.all;

entity mc_mux2_bus4 is
    port(
        a,b : in std_logic_vector(3 downto 0);
        s : in std_logic;
        y : out std_logic_vector(3 downto 0)
    );
end mc_mux2_bus4;

--
-- ARCHITECTURE
--

architecture behavioral of top is
begin
    u1: entity work.mc_mux2_bus4 port map(
        a => sw(3 downto 0),
        b => sw(7 downto 4),
        s => sw(8),
        y => led(3 downto 0)
    );
end behavioral;

architecture arch1 of mc_mux2 is
begin
    with s select
        y <= a when '0', b when others;
end architecture arch1;

architecture arch2 of mc_mux2_bus4 is
begin
    u1: entity work.mc_mux2 port map(a(0), b(0), s, y(0));
    u2: entity work.mc_mux2 port map(a(1), b(1), s, y(1));
    u3: entity work.mc_mux2 port map(a(2), b(2), s, y(2));
    u4: entity work.mc_mux2 port map(a(3), b(3), s, y(3));
end architecture arch2;