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
    u1: entity work.mc_counter_8bit port map(sw(0),key(3),sw(1),led(7 downto 0));
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