library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Transcodeur_anodes_tb is
end entity Transcodeur_anodes_tb;

architecture behavior of Transcodeur_anodes_tb is

    -- Déclaration du composant à tester
    component Transcodeur_anodes
        port (
            sel_anode  : in  std_logic_vector(1 downto 0);
            vect_anode : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Signaux de test
    signal sel_anode  : std_logic_vector(1 downto 0) := "00";
    signal vect_anode : std_logic_vector(3 downto 0);

    -- Table de vérité pour les anodes (actives à 0)
    type anode_array is array (0 to 3) of std_logic_vector(3 downto 0);
    constant expected_anodes : anode_array := (
        "1110", -- AN0 actif  -> secondes unités
        "1101", -- AN1 actif  -> secondes dizaines
        "1011", -- AN2 actif  -> minutes unités
        "0111"  -- AN3 actif  -> minutes dizaines
    );

begin

    -- Instanciation du composant à tester
    uut: Transcodeur_anodes
        port map (
            sel_anode  => sel_anode,
            vect_anode => vect_anode
        );

    -- Processus de test
    stim_process: process
    begin
        -- Test 1 : Sélection AN0 (secondes unités)
        sel_anode <= "00";
        wait for 10 ns;
        assert vect_anode = "1110" 
            report "Erreur : AN0 (secondes unités) - Attendu: 1110 - Reçu: " & to_string(vect_anode)
            severity error;
        assert vect_anode(0) = '0' report "Erreur : AN0 devrait être actif" severity error;
        
        -- Test 2 : Sélection AN1 (secondes dizaines)
        sel_anode <= "01";
        wait for 10 ns;
        assert vect_anode = "1101"
            report "Erreur : AN1 (secondes dizaines) - Attendu: 1101 - Reçu: " & to_string(vect_anode)
            severity error;
        assert vect_anode(1) = '0' report "Erreur : AN1 devrait être actif" severity error;
        
        -- Test 3 : Sélection AN2 (minutes unités)
        sel_anode <= "10";
        wait for 10 ns;
        assert vect_anode = "1011"
            report "Erreur : AN2 (minutes unités) - Attendu: 1011 - Reçu: " & to_string(vect_anode)
            severity error;
        assert vect_anode(2) = '0' report "Erreur : AN2 devrait être actif" severity error;
        
        -- Test 4 : Sélection AN3 (minutes dizaines)
        sel_anode <= "11";
        wait for 10 ns;
        assert vect_anode = "0111"
            report "Erreur : AN3 (minutes dizaines) - Attendu: 0111 - Reçu: " & to_string(vect_anode)
            severity error;
        assert vect_anode(3) = '0' report "Erreur : AN3 devrait être actif" severity error;
        
        -- Test 5 : Cycle complet (simulation du multiplexage)
        for i in 0 to 3 loop
            sel_anode <= std_logic_vector(to_unsigned(i, 2));
            wait for 10 ns;
            assert vect_anode = expected_anodes(i)
                report "Erreur : Cycle complet position " & integer'image(i)
                severity error;
        end loop;
        
        -- Test 6 : Plusieurs cycles rapides (simulation multiplexage réel)
        for cycle in 0 to 4 loop
            for i in 0 to 3 loop
                sel_anode <= std_logic_vector(to_unsigned(i, 2));
                wait for 5 ns;
            end loop;
        end loop;
        
        -- Test 7 : Vérification qu'une seule anode est active à la fois
        for i in 0 to 3 loop
            sel_anode <= std_logic_vector(to_unsigned(i, 2));
            wait for 10 ns;
            -- Compter le nombre de bits à '0' (anodes actives)
            assert (to_integer(unsigned(not vect_anode)) = 1)
                report "Erreur : Une seule anode devrait être active à la fois"
                severity error;
        end loop;
        
        report "Simulation terminée avec succès - Tous les transcodages d'anodes testés" severity note;
        wait;
    end process;

end architecture behavior;
