library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top_chrono is
end tb_top_chrono;

architecture Behavioral of tb_top_chrono is

    component top_chrono
        Port (
            ARESET : in  STD_LOGIC;
            CE     : in  STD_LOGIC;
            CLK    : in  STD_LOGIC;
            Q_DIX  : out STD_LOGIC_VECTOR (9 downto 0);
            Q_SEC  : out STD_LOGIC_VECTOR (3 downto 0);
            TC_SEC : out STD_LOGIC
        );
    end component;

    signal ARESET : STD_LOGIC := '0';
    signal CE     : STD_LOGIC := '1';
    signal CLK    : STD_LOGIC := '0';
    signal Q_DIX  : STD_LOGIC_VECTOR (9 downto 0);
    signal Q_SEC  : STD_LOGIC_VECTOR (3 downto 0);
    signal TC_SEC : STD_LOGIC;

    constant CLK_PERIOD : time := 10 ns;
    constant SIM_TIME   : time := 3 ms;

begin

    UUT : top_chrono
        port map (
            ARESET => ARESET,
            CE     => CE,
            CLK    => CLK,
            Q_DIX  => Q_DIX,
            Q_SEC  => Q_SEC,
            TC_SEC => TC_SEC
        );

    clk_process : process
    begin
        while now < SIM_TIME loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    stim_proc : process
    begin
        ARESET <= '1';
        CE <= '0';
        wait for 50 ns;

        ARESET <= '0';
        CE <= '1';

        wait for SIM_TIME;

        CE <= '0';

        wait;
    end process;

end Behavioral;

