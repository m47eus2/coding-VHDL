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
    signal from_hsc : std_logic_vector(8 downto 0);
    signal for_lsc : std_logic;
    signal from_lsc : std_logic_vector(1 downto 0);
    signal for_hex0, for_hex1 : std_logic_vector(3 downto 0);
begin
    -- HighSpeed
    u1: entity work.mc_counter_500 port map(sw(0), clk500Hz, sw(1), from_hsc);
    led(0) <= from_hsc(8);
    for_lsc <= not(from_hsc(8) or from_hsc(7) or from_hsc(6) or from_hsc(5)
    or from_hsc(4) or from_hsc(3) or from_hsc(2) or from_hsc(1)
    or from_hsc(0));

    -- LowSpeed
    u2: entity work.mc_counter_2bit port map(sw(0),for_lsc,sw(1),from_lsc);

    -- hex0
    u3: entity work.mc_mux4_4 port map("1110","0001","0000","1101",from_lsc, for_hex0);
    u4: entity work.mc_7seg_decoder_4bit port map(for_hex0, hex0);

    -- hex1
    u5: entity work.mc_mux4_4 port map("1101","1110","0001","0000",from_lsc, for_hex1);
    u6: entity work.mc_7seg_decoder_4bit port map(for_hex1, hex1);

    
end behavioral;


-- mc_counter_500

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mc_counter_500 is
    port(enb,clk,clr : in std_logic;
        q : out std_logic_vector(8 downto 0));
end mc_counter_500;

architecture arch1 of mc_counter_500 is
    signal q_temp : std_logic_vector(8 downto 0);
begin
    process(clk)
    begin
        if clk = '1' then
            if clr = '1' then
                q_temp <= std_logic_vector(to_unsigned(0,9));
            elsif enb = '1' then
                if unsigned(q_temp) < 499 then
                    q_temp <= std_logic_vector(unsigned(q_temp) + to_unsigned(1,9));
                else 
                    q_temp <= std_logic_vector(to_unsigned(0,9));
                end if;
            end if;
        end if;
    end process;
    q <= q_temp;
end arch1;

-- mc_counter_2bit

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mc_counter_2bit is
    port(enb,clk,clr : in std_logic;
        q : out std_logic_vector(1 downto 0));
end mc_counter_2bit;

architecture arch2 of mc_counter_2bit is
    signal q_temp : std_logic_vector(1 downto 0);
begin
    process(clk)
    begin
        if clk = '1' then
            if clr = '1' then
                q_temp <= std_logic_vector(to_unsigned(0,2));
            elsif enb = '1' then
                q_temp <= std_logic_vector(unsigned(q_temp) + to_unsigned(1,2));
            end if;
        end if;
    end process;
    q <= q_temp;
end arch2;

-- mc_7seg_decoder_4bit

library ieee;
use ieee.std_logic_1164.all;

entity mc_7seg_decoder_4bit is
    port(
        s : in std_logic_vector(3 downto 0);
        y : out std_logic_vector(6 downto 0)
    );
end mc_7seg_decoder_4bit;

architecture arch3 of mc_7seg_decoder_4bit is
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
end arch3;

-- mc_mux4_2

library ieee;
use ieee.std_logic_1164.all;

entity mc_mux4_4 is
    port(a,b,c,d : in std_logic_vector(3 downto 0);
        s : in std_logic_vector(1 downto 0);
        q : out std_logic_vector(3 downto 0));
end mc_mux4_4;

architecture arch4 of mc_mux4_4 is
begin
    with s select q <= a when "00",
    b when "01",
    c when "10",
    d when others;
end arch4;