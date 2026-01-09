library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_Chronometre is
end entity;

architecture sim of tb_Chronometre is

    signal CLK           : std_logic := '0';
    signal SEL_SPEED_CLK : std_logic := '0';
    signal START_STOP    : std_logic := '0';
    signal RESET         : std_logic := '0';

    signal LED_OUT : std_logic_vector(9 downto 0);
    signal AFF     : std_logic_vector(6 downto 0);
    signal ANODES  : std_logic_vector(3 downto 0);
    signal TC      : std_logic;

    constant CLK_PERIOD : time := 10 ns;


    procedure wait_change_vec(
        signal s      : in  std_logic_vector;
        constant tmax : in  time;
        constant step : in  time;
        constant name : in  string
    ) is
        variable t    : time := 0 ns;
        variable s0   : std_logic_vector(s'range);
    begin
        s0 := s;
        while (t < tmax) loop
            wait for step;
            t := t + step;
            if s /= s0 then
                return;
            end if;
        end loop;

        assert false
            report "TIMEOUT: " & name & " n'a pas change en " & time'image(tmax)
            severity failure;
    end procedure;

    procedure expect_stable_vec(
        signal s      : in  std_logic_vector;
        constant tdur : in  time;
        constant step : in  time;
        constant name : in  string
    ) is
        variable t  : time := 0 ns;
        variable s0 : std_logic_vector(s'range);
    begin
        s0 := s;
        while (t < tdur) loop
            wait for step;
            t := t + step;
            assert s = s0
                report "ERREUR: " & name & " a change alors qu'il devait rester stable (pendant " & time'image(tdur) & ")"
                severity failure;
        end loop;
    end procedure;

begin

    clk_gen : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD/2;
            CLK <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;

    uut : entity work.Chronometre
        port map (
            CLK           => CLK,
            SEL_SPEED_CLK => SEL_SPEED_CLK,
            START_STOP    => START_STOP,
            RESET         => RESET,
            LED_OUT       => LED_OUT,
            AFF           => AFF,
            ANODES        => ANODES,
            TC            => TC
        );

    stim : process
        variable led0 : std_logic_vector(9 downto 0);
        variable led1 : std_logic_vector(9 downto 0);
    begin
        SEL_SPEED_CLK <= '0';
        START_STOP    <= '0';
        RESET         <= '0';

        wait for 100 ns;
        RESET <= '1';
        wait for 200 ns;
        RESET <= '0';
        wait for 200 ns;

        report "TEST 1: STOP -> LED_OUT doit rester stable" severity note;
        led0 := LED_OUT;
        expect_stable_vec(LED_OUT, 5 ms, 50 us, "LED_OUT en STOP");

        report "TEST 2: FAST + START -> LED_OUT doit changer rapidement" severity note;
        SEL_SPEED_CLK <= '1';
        START_STOP    <= '1';
        wait for 200 us;
        led0 := LED_OUT;

        wait_change_vec(LED_OUT, 20 ms, 50 us, "LED_OUT (FAST)");

        report "TEST 3: repasser en STOP -> LED_OUT doit se figer" severity note;
        START_STOP <= '0';
        wait for 200 us;
        expect_stable_vec(LED_OUT, 5 ms, 50 us, "LED_OUT après STOP");

        report "TEST 4: NORMAL + START -> LED_OUT doit changer (attente longue)" severity note;
        SEL_SPEED_CLK <= '0';
        START_STOP    <= '1';
        wait for 200 us;
        led0 := LED_OUT;

        wait_change_vec(LED_OUT, 250 ms, 1 ms, "LED_OUT (NORMAL)");

        report "TEST 5: RESET pendant fonctionnement" severity note;
        led1 := LED_OUT;
        RESET <= '1';
        wait for 300 ns;
        RESET <= '0';
        wait for 2 ms;

        assert LED_OUT /= led1
            report "RESET n'a pas eu d'effet visible sur LED_OUT"
            severity warning;

        report "FIN TB: Tous les tests principaux sont passes." severity note;
        wait;
    end process;

end architecture;
