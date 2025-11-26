library ieee;
use ieee.std_logic_1164.all;

entity Mux_4x1x4b_tb is
end entity Mux_4x1x4b_tb;

architecture behavior of Mux_4x1x4b_tb is

    -- Déclaration du composant à tester
    component Mux_4x1x4b
        port (
            A   : in  std_logic_vector(3 downto 0);
            B   : in  std_logic_vector(3 downto 0);
            C   : in  std_logic_vector(3 downto 0);
            D   : in  std_logic_vector(3 downto 0);
            sel : in  std_logic_vector(1 downto 0);
            O   : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Signaux de test
    signal A   : std_logic_vector(3 downto 0) := "0001"; -- 1
    signal B   : std_logic_vector(3 downto 0) := "0010"; -- 2
    signal C   : std_logic_vector(3 downto 0) := "0011"; -- 3
    signal D   : std_logic_vector(3 downto 0) := "0100"; -- 4
    signal sel : std_logic_vector(1 downto 0) := "00";
    signal O   : std_logic_vector(3 downto 0);

begin

    -- Instanciation du composant à tester
    uut: Mux_4x1x4b
        port map (
            A   => A,
            B   => B,
            C   => C,
            D   => D,
            sel => sel,
            O   => O
        );

    -- Processus de test
    stim_process: process
    begin
        -- Test 1 : Sélection A (sel = "00")
        sel <= "00";
        wait for 10 ns;
        assert O = "0001" report "Erreur : Sélection A (secondes unités)" severity error;
        
        -- Test 2 : Sélection B (sel = "01")
        sel <= "01";
        wait for 10 ns;
        assert O = "0010" report "Erreur : Sélection B (secondes dizaines)" severity error;
        
        -- Test 3 : Sélection C (sel = "10")
        sel <= "10";
        wait for 10 ns;
        assert O = "0011" report "Erreur : Sélection C (minutes unités)" severity error;
        
        -- Test 4 : Sélection D (sel = "11")
        sel <= "11";
        wait for 10 ns;
        assert O = "0100" report "Erreur : Sélection D (minutes dizaines)" severity error;
        
        -- Test 5 : Changement dynamique des entrées
        A <= "1001"; -- 9
        B <= "0101"; -- 5
        C <= "1010"; -- A
        D <= "1111"; -- F
        
        sel <= "00";
        wait for 10 ns;
        assert O = "1001" report "Erreur : Sélection A avec nouvelle valeur" severity error;
        
        sel <= "01";
        wait for 10 ns;
        assert O = "0101" report "Erreur : Sélection B avec nouvelle valeur" severity error;
        
        sel <= "10";
        wait for 10 ns;
        assert O = "1010" report "Erreur : Sélection C avec nouvelle valeur" severity error;
        
        sel <= "11";
        wait for 10 ns;
        assert O = "1111" report "Erreur : Sélection D avec nouvelle valeur" severity error;
        
        -- Test 6 : Cycle complet
        for i in 0 to 3 loop
            sel <= std_logic_vector(to_unsigned(i, 2));
            wait for 10 ns;
        end loop;
        
        report "Simulation terminée avec succès" severity note;
        wait;
    end process;

end architecture behavior;
