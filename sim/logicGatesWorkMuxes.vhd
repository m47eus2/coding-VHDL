library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port (
        clk500Hz : in STD_LOGIC;
        sw  : in STD_LOGIC_VECTOR(9 downto 0);
        key : in STD_LOGIC_VECTOR(3 downto 0);
        led : out STD_LOGIC_VECTOR(9 downto 0);
        hex0 : out STD_LOGIC_VECTOR(6 downto 0);
        hex1 : out STD_LOGIC_VECTOR(6 downto 0)
    );
end top;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mc_and is
    port(a, b : in STD_LOGIC;
        z : out STD_LOGIC);
end entity mc_and;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mc_or is
    port(a,b: in STD_LOGIC;
        z: out STD_LOGIC);
end entity mc_or;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mc_mux2 is
    port(a,b,addr: in STD_LOGIC;
        z: out STD_LOGIC);
end entity mc_mux2;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mc_mux4 is
    port(a,b,c,d,x,y: in STD_LOGIC;
        z: out STD_LOGIC);
end entity mc_mux4;

--
-- ARCHITECTURE
--

architecture arch1 of mc_and is
begin
    z <= a and b;
end architecture arch1;

architecture arch2 of mc_or is
begin
    z <= a or b;
end architecture arch2;

architecture arch3 of mc_mux2 is
begin
    with addr select
        z <= a when '0', b when others;
end architecture arch3;

architecture arch4 of mc_mux4 is
    signal xy: STD_LOGIC_VECTOR(0 to 1);
begin
    xy <= x&y; 
    with xy select
        z <= a when "00",
            b when "01",
            c when "10",
            d when others;
end architecture arch4;

--
-- TOP ARCHITECTURE
--

architecture Behavioral of top is
    signal p: STD_LOGIC;
begin
    --u1: entity work.mc_or port map(a=>sw(0), b=>sw(1),z=>p);
    --u2: entity work.mc_and port map(a=>sw(2), b=>p, z=>led(0));

    --u1: entity work.mc_mux2 port map(a=>sw(0), b=>sw(1), addr=>sw(2), z=>led(0));
    u1: entity work.mc_mux4 port map(sw(0),sw(1),sw(2),sw(3),sw(4),sw(5),led(0));
    

    -- reszta LEDów wyłączona
    led(9 downto 1) <= (others => '0');

    -- wyłączamy wyświetlacze (active low)
    -- hex0 <= "1111111";
    -- hex1 <= "1111111";

end Behavioral;