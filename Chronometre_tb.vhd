library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_Chronometre is
end entity;

architecture sim of tb_Chronometre is

    -- UUT ports
    signal CLK           : std_logic := '0';
    signal SEL_SPEED_CLK : std_logic := '0';
    signal START_STOP    : std_logic := '0';
    signal RESET         : std_logic := '0';

    signal LED_OUT : std_logic_vector(9 downto 0);
    signal AFF     : std_logic_vector(6 downto 0);
    signal ANODES  : std_logic_vector(3 downto 0);
    signal TC      : std_logic;

    constant CLK_PERIOD : time := 10 ns; -- 100 MHz

    -- util : compte le nombre de '1' dans un vecteur
    function ones_count(v : std_logic_vector) return integer is
        variable c : integer := 0;
    begin
        for i in v'range loop
            if v(i) = '1' then
                c := c + 1;
            end if;
        end loop;
        return c;
    end function;

    -- util : vrai si le vecteur ne contient ni U ni X
    function no_ux(v : std_logic_vector) return boolean is
    begin
        for i in v'range loop
            if (v(i) /= '0') and (v(i) /= '1') then
                return false;
            end if;
        end loop;
        return true;
    end function;

begin

    -- Clock generator
    clk_gen : process
    begin
        while true loop
            CLK <= '0';
            wait for CLK_PERIOD/2;
            CLK <= '1';
            wait for CLK_PERIOD/2;
        end loop;
    end process;

    -- Instantiate UUT
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

    -- Basic ANODES mux sanity checks (actif bas, 1 seul digit activé)
    mux_check : process
        variable an : std_logic_vector(3 downto 0);
    begin
        wait for 1 us; -- laisser le temps d'initialiser
        while true loop
            an := ANODES;

            assert no_ux(an)
                report "ANODES contient U/X -> probleme d'init ou de reset"
                severity error;

            -- ANODES doit être l'un de : 1110,1101,1011,0111 (un seul 0)
            assert (an = "1110") or (an = "1101") or (an = "1011") or (an = "0111")
                report "ANODES n'est pas one-hot actif bas (attendu 1110/1101/1011/0111). Valeur=" &
                       std_logic'image(an(3)) & std_logic'image(an(2)) & std_logic'image(an(1)) & std_logic'image(an(0))
                severity error;

            assert no_ux(AFF)
                report "AFF contient U/X -> probleme de transcodeur/mux"
                severity error;

            wait for 200 us; -- échantillonnage régulier
        end loop;
    end process;

    -- Main stimulus + assertions fonctionnelles
    stim : process
        variable led0, led1 : std_logic_vector(9 downto 0);
    begin
        -- Etat initial
        SEL_SPEED_CLK <= '0';
        START_STOP    <= '0';
        RESET         <= '0';

        wait for 200 ns;

        -- RESET
        RESET <= '1';
        wait for 200 ns;
        RESET <= '0';
        wait for 500 ns;

        -- Check LED_OUT "one-hot" après reset (ton chenillard démarre généralement avec 1 LED allumée)
        assert ones_count(LED_OUT) = 1
            report "Apres RESET, LED_OUT n'est pas one-hot (attendu 1 seul '1')."
            severity warning;

        -- Mode accéléré + start
        SEL_SPEED_CLK <= '1';
        START_STOP    <= '1';

        led0 := LED_OUT;
        wait for 10 ms;  -- en fast, tu dois voir bouger les dixièmes (LED_OUT shift)
        led1 := LED_OUT;

        assert led1 /= led0
            report "En mode FAST et START_STOP=1, LED_OUT ne change pas -> comptage semble bloqué."
            severity error;

        -- Pause
        START_STOP <= '0';
        led0 := LED_OUT;
        wait for 10 ms;
        led1 := LED_OUT;

        assert led1 = led0
            report "START_STOP=0 mais LED_OUT change quand meme -> pause non fonctionnelle."
            severity error;

        -- Reprise
        START_STOP <= '1';
        led0 := LED_OUT;
        wait for 10 ms;
        led1 := LED_OUT;

        assert led1 /= led0
            report "Reprise START_STOP=1 mais LED_OUT ne change pas -> reprise non fonctionnelle."
            severity error;

        -- Optionnel : petit test mode normal (plus lent)
        SEL_SPEED_CLK <= '0';
        led0 := LED_OUT;
        wait for 120 ms; -- en normal (10 Hz), tu peux voir au moins 1-2 steps
        led1 := LED_OUT;

        assert led1 /= led0
            report "En mode NORMAL, LED_OUT n'a pas change sur 120ms (possible si diviseur diffère)."
            severity warning;

        report "TB terminé : tests de base OK (reset/start-stop/speed/mux)."
            severity note;

        wait;
    end process;

end architecture;
