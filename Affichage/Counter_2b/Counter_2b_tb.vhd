library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Counter_2b_tb is
end entity Counter_2b_tb;

architecture behavior of Counter_2b_tb is

    -- Déclaration du composant à tester
    component Counter_2b
        port (
            CLK   : in  std_logic;
            RESET : in  std_logic;
            Q     : out std_logic_vector(1 downto 0)
        );
    end component;

    -- Signaux de test
    signal CLK   : std_logic := '0';
    signal RESET : std_logic := '0';
    signal Q     : std_logic_vector(1 downto 0);

    -- Période d'horloge
    constant CLK_period : time := 10 ns;

    -- Signal pour arrêter la simulation
    signal sim_done : boolean := false;

begin

    -- Instanciation du composant à tester
    uut: Counter_2b
        port map (
            CLK   => CLK,
            RESET => RESET,
            Q     => Q
        );

    -- Génération de l'horloge
    clk_process: process
    begin
        while not sim_done loop
            CLK <= '0';
            wait for CLK_period/2;
            CLK <= '1';
            wait for CLK_period/2;
        end loop;
        wait;
    end process;

    -- Processus de test
    stim_process: process
    begin
        -- Test 1 : Reset
        RESET <= '1';
        wait for CLK_period*2;
        assert Q = "00" report "Erreur : Reset non fonctionnel" severity error;
        
        -- Test 2 : Comptage normal
        RESET <= '0';
        wait for CLK_period;
        assert Q = "01" report "Erreur : Comptage de 0 à 1" severity error;
        
        wait for CLK_period;
        assert Q = "10" report "Erreur : Comptage de 1 à 2" severity error;
        
        wait for CLK_period;
        assert Q = "11" report "Erreur : Comptage de 2 à 3" severity error;
        
        wait for CLK_period;
        assert Q = "00" report "Erreur : Comptage de 3 à 0 (débordement)" severity error;
        
        wait for CLK_period;
        assert Q = "01" report "Erreur : Comptage après débordement" severity error;
        
        -- Test 3 : Reset pendant le comptage
        wait for CLK_period;
        RESET <= '1';
        wait for CLK_period;
        assert Q = "00" report "Erreur : Reset pendant comptage" severity error;
        
        RESET <= '0';
        wait for CLK_period*4;
        
        report "Simulation terminée avec succès" severity note;
        sim_done <= true;
        wait;
    end process;

end architecture behavior;
