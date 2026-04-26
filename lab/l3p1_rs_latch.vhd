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
    u1: entity work.mc_rs_latch port map(sw(2), sw(1), sw(0), led(0));
end behavioral;

-- mc_rs_latch

library ieee;
use ieee.std_logic_1164.all;

entity mc_rs_latch is
    port(
        clk, r, s : in std_logic;
        q : out std_logic
    );
end mc_rs_latch;

architecture arch1 of mc_rs_latch is
    signal rg, sg, qa, qb : std_logic;
begin
    rg <= r and clk;
    sg <= s and clk;
    qa <= not (rg or qb);
    qb <= not (sg or qa);
    q <= qa;
end arch1;

