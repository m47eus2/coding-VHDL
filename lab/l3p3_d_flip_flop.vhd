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

-- mc_d_ff

library ieee;
use ieee.std_logic_1164.all;

entity mc_d_ff is
    port(d, clk : in std_logic;
        q : out std_logic
    );
end mc_d_ff;

architecture arch2 of mc_d_ff is
    signal qm, nclk : std_logic;
begin
    nclk <= not clk;
    u1: entity work.mc_d_latch port map(d, nclk, qm);
    u2: entity work.mc_d_latch port map(qm, clk, q);
end arch2;
