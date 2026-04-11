library IEEE;
use IEEE.std_logic_1164.all;

-- TOP

entity top is
    Port(
        clk500Hz : in STD_LOGIC;
        sw : in STD_LOGIC_VECTOR(9 downto 0);
        key : in STD_LOGIC_VECTOR(3 downto 0);
        led : out STD_LOGIC_VECTOR(9 downto 0);
        hex0 : out STD_LOGIC_VECTOR(6 downto 0);
        hex1 : out STD_LOGIC_VECTOR(6 downto 0)
    );
end top;

architecture behavioral of top is
    signal from_mux_1, from_mux_2 : std_logic_vector(2 downto 0);
begin
    u1: entity work.mc_mux6_bus3 port map("011","100","100","000","001","010",sw(2 downto 0),from_mux_1);
    u2: entity work.mc_mux6_bus3 port map("010","011","100","100","000","001",sw(2 downto 0),from_mux_2);
    u3: entity work.mc_7seg_3bit_decoder port map(from_mux_1, hex0);
    u4: entity work.mc_7seg_3bit_decoder port map(from_mux_2, hex1);


end behavioral;

library IEEE;
use IEEE.std_logic_1164.all;

-- mc_7seg_2bit_decoder

entity mc_7seg_2bit_decoder is
    port(
        s : in std_logic_vector(1 downto 0);
        y : out std_logic_vector(6 downto 0) 
    );
end mc_7seg_2bit_decoder;

architecture arch1 of mc_7seg_2bit_decoder is
begin
    with s select
        y <= "0100001" when "00",
        "0000110" when "01",
        "1111001" when "10",
        "1000000" when "11",
        "1111111" when others;
end architecture arch1;

library IEEE;
use IEEE.std_logic_1164.all;

-- mc_7seg_3bit_decoder

entity mc_7seg_3bit_decoder is
    port(
        s : in std_logic_vector(2 downto 0);
        y : out std_logic_vector(6 downto 0) 
    );
end mc_7seg_3bit_decoder;

architecture arch5 of mc_7seg_3bit_decoder is
begin
    with s select
        y <= "0100001" when "000",
        "0000110" when "001",
        "1111001" when "010",
        "1000000" when "011",
        "1111111" when others;
end architecture arch5;


library ieee;
use ieee.std_logic_1164.all;

-- mc_mux4

entity mc_mux4 is
    port(
        a,b,c,d : in std_logic;
        s : in std_logic_vector(1 downto 0);
        y : out std_logic
    );
end mc_mux4;

architecture arch2 of mc_mux4 is
begin
    with s select
        y <= a when "00",
        b when "01",
        c when "10",
        d when others;
end architecture arch2;

library ieee;
use ieee.std_logic_1164.all;

-- mc_mux4_bus2

entity mc_mux4_bus2 is
    port(
        a,b,c,d,s : in std_logic_vector(1 downto 0);
        y : out std_logic_vector(1 downto 0)
    );
end mc_mux4_bus2;

architecture arch3 of mc_mux4_bus2 is
begin
    u1: entity work.mc_mux4 port map(a(0),b(0),c(0),d(0),s,y(0));
    u2: entity work.mc_mux4 port map(a(1),b(1),c(1),d(1),s,y(1));
end architecture arch3;

library ieee;
use ieee.std_logic_1164.all;

-- mc_mux6_bus3

entity mc_mux6_bus3 is
    port(
        a,b,c,d,e,f,s : in std_logic_vector(2 downto 0);
        y : out std_logic_vector(2 downto 0)
    );
end mc_mux6_bus3;

architecture arch4 of mc_mux6_bus3 is
begin
    with s select
        y <= a when "000",
        b when "001",
        c when "010",
        d when "011",
        e when "100",
        f when others;
end architecture arch4;

