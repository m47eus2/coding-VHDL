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
    -- u1: entity work.mc_t_ff port map(sw(0),key(3),sw(1),led(0));
    u1: entity work.mc_counter_4bit port map(sw(0),key(3),sw(1),led(3 downto 0));
end behavioral;

-- mc_t_ff

library ieee;
use ieee.std_logic_1164.all;

entity mc_t_ff is
    port(t,clk,clr : in std_logic;
        q : out std_logic);
end mc_t_ff;

architecture arch1 of mc_t_ff is
    signal q_temp : std_logic;
begin
    process(clk)
    begin
        if clk = '1' then
            if clr = '1' then 
                q_temp <= '0';
            elsif t = '1' then
                q_temp <= not q_temp;
            end if;
        end if;
    end process;
    q <= q_temp;
end arch1;

-- mc_counter_4bit

library ieee;
use ieee.std_logic_1164.all;

entity mc_counter_4bit is
    port(enb,clk,clr : in std_logic;
        q : out std_logic_vector(3 downto 0));
end mc_counter_4bit;

architecture arch2 of mc_counter_4bit is
    signal q_temp : std_logic_vector(3 downto 0);
    signal t1,t2,t3 : std_logic;
begin
    u1: entity work.mc_t_ff port map(enb,clk,clr,q_temp(0));
    u2: entity work.mc_t_ff port map(t1, clk,clr,q_temp(1));
    u3: entity work.mc_t_ff port map(t2, clk,clr,q_temp(2));
    u4: entity work.mc_t_ff port map(t3, clk,clr,q_temp(3));
    t1 <= enb and q_temp(0);
    t2 <= t1 and q_temp(1);
    t3 <= t2 and q_temp(2);
    q <= q_temp;
end arch2;