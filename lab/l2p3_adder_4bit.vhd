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
    
u1: entity work.mc_adder_4bit port map(sw(7 downto 4), sw(3 downto 0), sw(8), led(3 downto 0), led(4));

end behavioral;

-- mc_full_adder

library ieee;
use ieee.std_logic_1164.all;

entity mc_full_adder is
    port(
        a,b,cin : in std_logic;
        s,cout : out std_logic
    );
    end mc_full_adder;

architecture arch1 of mc_full_adder is
begin
    s <= ((not cin) and (a xor b)) or (cin and not(a xor b));
    cout <= (a and b) or (cin and (a or b));
end arch1;

-- mc_adder_4bit

library ieee;
use ieee.std_logic_1164.all;

entity mc_adder_4bit is
    port(
        a,b : in std_logic_vector(3 downto 0);
        cin : in std_logic;
        s : out std_logic_vector(3 downto 0);
        cout : out std_logic
    );
    end mc_adder_4bit;

architecture arch2 of mc_adder_4bit is
    signal c1, c2, c3 : std_logic;
begin
    u1: entity work.mc_full_adder port map(a(0), b(0), cin, s(0), c1);
    u2: entity work.mc_full_adder port map(a(1), b(1), c1, s(1), c2);
    u3: entity work.mc_full_adder port map(a(2), b(2), c2, s(2), c3);
    u4: entity work.mc_full_adder port map(a(3), b(3), c3, s(3), cout);

end arch2;