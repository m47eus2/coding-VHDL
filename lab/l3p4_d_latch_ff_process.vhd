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
    signal nsw1 : std_logic;
begin
    nsw1 <= not sw(1);
    u1: entity work.mc_d_latch port map(sw(0),sw(1),led(0));
    u2: entity work.mc_d_ff port map(sw(0),sw(1),led(1));
    u3: entity work.mc_d_ff port map(sw(0),nsw1,led(2));
end behavioral;

-- mc_d_latch

library ieee;
use ieee.std_logic_1164.all;

entity mc_d_latch is
    port(d, clk : in std_logic;
        q : out std_logic);
end mc_d_latch;

architecture arch1 of mc_d_latch is
begin
    process(d,clk)
    begin
        if clk='1' then
            q <= d;
        end if;
    end process;
end arch1;

-- mc_d_ff

library ieee;
use ieee.std_logic_1164.all;

entity mc_d_ff is
    port(d, clk : in std_logic;
        q : out std_logic);
end mc_d_ff;

architecture arch2 of mc_d_ff is
begin
    process(clk)
    begin
        if clk='1' then
            q <= d;
        end if;
    end process;
end arch2;
