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
    signal from_adder : std_logic_vector(4 downto 0);
begin
    
u1: entity work.mc_adder_4bit port map(sw(7 downto 4), sw(3 downto 0), sw(8), from_adder(3 downto 0), from_adder(4));
u2: entity work.mc_7seg_4bit_decoder port map(from_adder, hex0, hex1);

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

-- mc_7seg_decoder

library ieee;
use ieee.std_logic_1164.all;

entity mc_7seg_decoder is
    port(
        s : in std_logic_vector(3 downto 0);
        y : out std_logic_vector(6 downto 0)
    );
end mc_7seg_decoder;

architecture arch3 of mc_7seg_decoder is
begin
    with s select
        y <= "1000000" when "0000",
        "1111001" when "0001",
        "0100100" when "0010",
        "0110000" when "0011",
        "0011001" when "0100",
        "0010010" when "0101",
        "0000010" when "0110",
        "1111000" when "0111",
        "0000000" when "1000",
        "0010000" when "1001",
        "1111111" when others;
end arch3;

-- mc_comparator

library ieee;
use ieee.std_logic_1164.all;

entity mc_comparator_4bit is
    port(
        s : in std_logic_vector(4 downto 0);
        y : out std_logic
    );
end mc_comparator_4bit;

architecture arch4 of mc_comparator_4bit is
begin
    y <= s(4) or (s(3) and (s(2) or s(1)));
end arch4;

-- mc_mux2_bus4

library ieee;
use ieee.std_logic_1164.all;

entity mc_mux2_bus4 is
    port(
        a,b : in std_logic_vector(3 downto 0);
        s : in std_logic;
        y : out std_logic_vector(3 downto 0)
    );
    end mc_mux2_bus4;

architecture arch5 of mc_mux2_bus4 is
begin
    with s select
        y <= a when '0',
        b when others;
end arch5;

-- mc_circuit_a

library ieee;
use ieee.std_logic_1164.all;

entity mc_circuit_a is
    port(
        s : in std_logic_vector(4 downto 0);
        y : out std_logic_vector(3 downto 0)
    );
    end mc_circuit_a;

architecture arch6 of mc_circuit_a is
begin
    with s select
        y <= "0000" when "01010",
        "0001" when "01011",
        "0010" when "01100",
        "0011" when "01101",
        "0100" when "01110",
        "0101" when "01111",
        "0110" when "10000",
        "0111" when "10001",
        "1000" when "10010",
        "1001" when others;
end arch6;

-- mc_7seg_4bit_decoder

library ieee;
use ieee.std_logic_1164.all;

entity mc_7seg_4bit_decoder is
    port(
        s : in std_logic_vector(4 downto 0);
        h0 : out std_logic_vector(6 downto 0);
        h1 : out std_logic_vector(6 downto 0)
    );
    end mc_7seg_4bit_decoder;

architecture arch7 of mc_7seg_4bit_decoder is
    signal from_comp : std_logic;
    signal from_circuit_a, from_mux, for_hex_1 : std_logic_vector(3 downto 0);
begin
    -- Hex0
    u1: entity work.mc_comparator_4bit port map(s, from_comp);
    u2: entity work.mc_circuit_a port map(s, from_circuit_a);

    u3: entity work.mc_mux2_bus4 port map(s(3 downto 0), from_circuit_a, from_comp, from_mux);

    u4: entity work.mc_7seg_decoder port map(from_mux, h0);

    --Hex1
    u5: entity work.mc_mux2_bus4 port map("0000","0001",from_comp,for_hex_1);
    u6: entity work.mc_7seg_decoder port map(for_hex_1, h1);
end arch7;