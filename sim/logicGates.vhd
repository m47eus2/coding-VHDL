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

--
-- TOP ARCHITECTURE
--

architecture Behavioral of top is
    component mc_and
        port(a,b: in STD_LOGIC;
        z: out STD_LOGIC);
    end component;

    component mc_or
        port(a,b: in STD_LOGIC;
        z: out STD_LOGIC);
    end component; 

    signal p: STD_LOGIC;

begin
    u1: mc_or port map(a=>sw(0), b=>sw(1),z=>p);
    u2: mc_and port map(a=>sw(2), b=>p, z=>led(0));
    

    -- reszta LEDów wyłączona
    led(9 downto 1) <= (others => '0');

    -- wyłączamy wyświetlacze (active low)
    -- hex0 <= "1111111";
    -- hex1 <= "1111111";

end Behavioral;