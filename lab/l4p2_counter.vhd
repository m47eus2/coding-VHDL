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
    signal from_counter : std_logic_vector(7 downto 0);
begin
    u1: entity work.mc_counter_8bit port map(sw(0),key(3),sw(1),from_counter);
    u2: entity work.mc_7seg_decoder_4bit port map(from_counter(3 downto 0), hex0);
    u3: entity work.mc_7seg_decoder_4bit port map(from_counter(7 downto 4), hex1);
    led(7 downto 0) <= from_counter;
end behavioral;

-- mc_counter_8bit

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mc_counter_8bit is
    port(enb,clk,clr : in std_logic;
        q : out std_logic_vector(7 downto 0));
end mc_counter_8bit;

architecture arch1 of mc_counter_8bit is
    signal q_temp : std_logic_vector(7 downto 0);
begin
    process(clk)
    begin
        if clk = '1' then
            if clr = '1' then
                q_temp <= std_logic_vector(to_unsigned(0,8));
            elsif enb = '1' then
                q_temp <= std_logic_vector(unsigned(q_temp) + to_unsigned(1,8));
            end if;
        end if;
    end process;
    q <= q_temp;
end arch1;

-- mc_7seg_decoder_4bit

library ieee;
use ieee.std_logic_1164.all;

entity mc_7seg_decoder_4bit is
    port(
        s : in std_logic_vector(3 downto 0);
        y : out std_logic_vector(6 downto 0)
    );
end mc_7seg_decoder_4bit;

architecture arch2 of mc_7seg_decoder_4bit is
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
end arch2;
