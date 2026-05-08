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
    u1: entity work.mc_d_latch port map(sw(0), sw(1), led(0));
end behavioral;

-- mc_d_latch

library ieee;
use ieee.std_logic_1164.all;

entity mc_d_latch is
    port(d, clk : in std_logic;
        q : out std_logic);
end mc_d_latch;

architecture arch1 of mc_d_latch is
    signal sg,rg,qa,qb : std_logic;
    ATTRIBUTE KEEP : BOOLEAN;
    ATTRIBUTE KEEP OF sg,rg,qa,qb : SIGNAL IS TRUE;
begin
    sg <= not(d and clk);
    rg <= not((not d) and clk);
    qa <= not(sg and qb);
    qb <= not(rg and qa);
    q <= qa;
end arch1;
