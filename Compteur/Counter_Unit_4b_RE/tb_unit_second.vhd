library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_counter_4b_RE_unit_sec is
end tb_counter_4b_RE_unit_sec;

architecture Behavioral of tb_counter_4b_RE_unit_sec is

    component counter_4b_RE_unit_sec is
        Port (
            ARESET : in  STD_LOGIC;
            TC_ds    : in  STD_LOGIC;
            Q      : out STD_LOGIC_VECTOR (3 downto 0);
            CE     : in  STD_LOGIC;
            TC_s  : out STD_LOGIC
        );
    end component;
    signal ARESET_int : std_logic := '1';
    signal CE_int     : std_logic := '0';
    signal TC_s_int  : std_logic := '0';
    signal TC_ds_int    : std_logic := '0';
    signal Q_vect     : STD_LOGIC_VECTOR (3 downto 0);

begin

    uut : counter_4b_RE_unit_sec
        port map (
            ARESET => ARESET_int,
            TC_ds    => TC_ds_int,
            Q      => Q_vect,
            CE     => CE_int,
            TC_s  => TC_s_int
        );

    TC_ds_gen : process
    begin
        while true loop
            TC_ds_int <= '0';
            wait for 10 ns;
            TC_ds_int <= '1';
            wait for 10 ns;
        end loop;
    end process;

    stim_proc : process
    begin
        ARESET_int <= '1';
        CE_int <= '0';
        wait for 100 ns;

        ARESET_int <= '0';
        wait for 100 ns;

        CE_int <= '1';
        wait for 2000 ns;

        CE_int <= '0';
        wait for 50 ns;
        std.env.stop;
        wait;
    end process;

end Behavioral;

