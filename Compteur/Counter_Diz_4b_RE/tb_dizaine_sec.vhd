
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_counter_4b_RE_dizaine_sec is
end tb_counter_4b_RE_dizaine_sec;

architecture Behavioral of tb_counter_4b_RE_dizaine_sec is

    component counter_4b_RE_dizaine_sec is
        Port (
            ARESET : in  STD_LOGIC;
            TC_Ds  : out STD_LOGIC;
            Q      : out STD_LOGIC_VECTOR (3 downto 0);
            TC_s   : in  STD_LOGIC
        );
    end component;
    signal ARESET_int : std_logic := '1';
    signal TC_Ds_int  : std_logic := '0';
    signal TC_s_int   : std_logic := '0';
    signal Q_vect     : STD_LOGIC_VECTOR (3 downto 0);

    constant CLK_PERIOD : time := 10 ns; 

begin

    uut : counter_4b_RE_dizaine_sec
        port map (
            ARESET => ARESET_int,
            TC_Ds  => TC_Ds_int,
            Q      => Q_vect,
            TC_s   => TC_s_int
        );

    TC_s_gen : process
    begin
        TC_s_int <= '0';
        wait for CLK_PERIOD / 2;
        TC_s_int <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    stim_proc : process
    begin
        ARESET_int <= '1';
        wait for 100 ns;

        ARESET_int <= '0';
        wait for 200 ns; 

        ARESET_int <= '1';
        wait for 30 ns;
        ARESET_int <= '0';
        wait for 100 ns;

        assert false report "Fin de la simulation (Normal)" severity failure;
    end process;

end Behavioral;
