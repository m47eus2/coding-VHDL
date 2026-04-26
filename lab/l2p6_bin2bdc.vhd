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
    signal dig1, dig2 : std_logic_vector(3 downto 0);
begin
    u1 : entity work.mc_bin2dec_6bit port map (sw(5 downto 0), dig1, dig2);
    u2 : entity work.mc_7seg_decoder port map(dig1, hex0);
    u3 : entity work.mc_7seg_decoder port map(dig2, hex1);
end behavioral;

-- mc_bin2dec_6bit

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mc_bin2dec_6bit is
    port(
        a : in std_logic_vector(5 downto 0);
        s0, s1 : out std_logic_vector(3 downto 0)
    );
end mc_bin2dec_6bit;

architecture arch1 of mc_bin2dec_6bit is
begin
    process(a)
        variable a_int : integer range 0 to 63;
        variable z0 : integer range 0 to 63;
        variable c1 : integer range 0 to 7;
    begin
        a_int := to_integer(unsigned(a));
        if a_int > 59 then
            z0 := 60;
            c1 := 6;
        elsif a_int > 49 then
            z0 := 50;
            c1 := 5;
        elsif a_int > 39 then
            z0 := 40;
            c1 := 4;
        elsif a_int > 29 then
            z0 := 30;
            c1 := 3;
        elsif a_int > 19 then
            z0 := 20;
            c1 := 2;
        elsif a_int > 9 then
            z0 := 10;
            c1 := 1;
        else
            z0 := 0;
            c1 := 0;
        end if;
        s0 <= std_logic_vector(to_unsigned(a_int - z0, 4));
        s1 <= std_logic_vector(to_unsigned(c1, 4));
    end process;
end arch1;

-- mc_7seg_decoder

library ieee;
use ieee.std_logic_1164.all;

entity mc_7seg_decoder is
    port(
        s : in std_logic_vector(3 downto 0);
        y : out std_logic_vector(6 downto 0)
    );
end mc_7seg_decoder;

architecture arch2 of mc_7seg_decoder is
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
        "0010000" when others;
end arch2;