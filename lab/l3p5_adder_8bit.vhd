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
    signal from_register, from_mux : std_logic_vector(7 downto 0);
    signal from_adder : std_logic_vector(8 downto 0);
    signal numa, numb, numsum : std_logic_vector(6 downto 0);
begin
    u1: entity work.mc_register_8bit port map(sw(7 downto 0), key(0), from_register);
    u2: entity work.mc_adder_8bit port map(sw(7 downto 0), from_register, from_adder);
    u3: entity work.mc_mux4_8bit port map(sw(7 downto 0), from_register, from_adder(7 downto 0), from_adder(7 downto 0), sw(9 downto 8), from_mux);
    u4: entity work.mc_7seg_decoder_4bit port map(from_mux(3 downto 0), hex0);
    u5: entity work.mc_7seg_decoder_4bit port map(from_mux(7 downto 4), hex1);
end behavioral;

-- mc_7seg_decoder_4bit

library ieee;
use ieee.std_logic_1164.all;

entity mc_7seg_decoder_4bit is
    port(
        s : in std_logic_vector(3 downto 0);
        y : out std_logic_vector(6 downto 0)
    );
end mc_7seg_decoder_4bit;

architecture arch1 of mc_7seg_decoder_4bit is
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
        "0001000" when "1010",
        "0000011" when "1011",
        "1000110" when "1100",
        "0100001" when "1101",
        "0000110" when "1110",
        "0001110" when "1111",
        "1111111" when others;
end arch1;

-- mc_mux4_8bit

library ieee;
use ieee.std_logic_1164.all;

entity mc_mux4_8bit is
    port(a,b,c,d : in std_logic_vector(7 downto 0);
        s : in std_logic_vector(1 downto 0);
        y : out std_logic_vector(7 downto 0));
end mc_mux4_8bit;

architecture arch2 of mc_mux4_8bit is
begin
    with s select
        y <= a when "00",
        b when "01",
        c when "10",
        d when others;
end arch2;

-- mc_d_ff

library ieee;
use ieee.std_logic_1164.all;

entity mc_d_ff is
    port(d, clk : in std_logic;
        q : out std_logic);
end mc_d_ff;

architecture arch3 of mc_d_ff is
begin
    process(clk)
    begin
        if clk='1' then
            q <= d;
        end if;
    end process;
end arch3;

-- mc_register_8bit

library ieee;
use ieee.std_logic_1164.all;

entity mc_register_8bit is
    port(d : in std_logic_vector(7 downto 0);
        clk : in std_logic;
        q : out std_logic_vector(7 downto 0));
end mc_register_8bit;

architecture arch4 of mc_register_8bit is
begin
    u1: entity work.mc_d_ff port map(d(0), clk, q(0));
    u2: entity work.mc_d_ff port map(d(1), clk, q(1));
    u3: entity work.mc_d_ff port map(d(2), clk, q(2));
    u4: entity work.mc_d_ff port map(d(3), clk, q(3));
    u5: entity work.mc_d_ff port map(d(4), clk, q(4));
    u6: entity work.mc_d_ff port map(d(5), clk, q(5));
    u7: entity work.mc_d_ff port map(d(6), clk, q(6));
    u8: entity work.mc_d_ff port map(d(7), clk, q(7));
end arch4;

-- mc_adder_8bit

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mc_adder_8bit is
    port(a, b : in std_logic_vector(7 downto 0);
        sum : out std_logic_vector(8 downto 0));
end mc_adder_8bit;

architecture arch5 of mc_adder_8bit is
begin
    process(a,b)
        variable sum_int : integer range 0 to 511;
    begin
        sum <= std_logic_vector(('0' & unsigned(a)) + ('0' & unsigned(b)));
    end process;
end arch5;
