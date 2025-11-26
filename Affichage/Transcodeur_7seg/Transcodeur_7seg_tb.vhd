library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Transcodeur_7seg_tb is
end entity Transcodeur_7seg_tb;

architecture behavior of Transcodeur_7seg_tb is

    -- Déclaration du composant à tester
    component Transcodeur_7seg
        port (
            A : in  std_logic_vector(3 downto 0);
            O : out std_logic_vector(6 downto 0)
        );
    end component;

    -- Signaux de test
    signal A : std_logic_vector(3 downto 0) := "0000";
    signal O : std_logic_vector(6 downto 0);

    -- Table de vérité pour les segments (actifs à 0)
    type segment_array is array (0 to 15) of std_logic_vector(6 downto 0);
    constant expected_segments : segment_array := (
        "1000000", -- 0
        "1111001", -- 1
        "0100100", -- 2
        "0110000", -- 3
        "0011001", -- 4
        "0010010", -- 5
        "0000010", -- 6
        "1111000", -- 7
        "0000000", -- 8
        "0010000", -- 9
        "0001000", -- A
        "0000011", -- b
        "1000110", -- C
        "0100001", -- d
        "0000110", -- E
        "0001110"  -- F
    );

begin

    -- Instanciation du composant à tester
    uut: Transcodeur_7seg
        port map (
            A => A,
            O => O
        );

    -- Processus de test
    stim_process: process
    begin
        -- Test de tous les chiffres et lettres hexadécimaux
        for i in 0 to 15 loop
            A <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
            
            assert O = expected_segments(i)
                report "Erreur : valeur " & integer'image(i) & 
                       " - Attendu: " & to_string(expected_segments(i)) &
                       " - Reçu: " & to_string(O)
                severity error;
                
            -- Vérification individuelle pour chaque chiffre/lettre
            case i is
                when 0 => assert O = "1000000" report "Erreur : Affichage de 0" severity error;
                when 1 => assert O = "1111001" report "Erreur : Affichage de 1" severity error;
                when 2 => assert O = "0100100" report "Erreur : Affichage de 2" severity error;
                when 3 => assert O = "0110000" report "Erreur : Affichage de 3" severity error;
                when 4 => assert O = "0011001" report "Erreur : Affichage de 4" severity error;
                when 5 => assert O = "0010010" report "Erreur : Affichage de 5" severity error;
                when 6 => assert O = "0000010" report "Erreur : Affichage de 6" severity error;
                when 7 => assert O = "1111000" report "Erreur : Affichage de 7" severity error;
                when 8 => assert O = "0000000" report "Erreur : Affichage de 8" severity error;
                when 9 => assert O = "0010000" report "Erreur : Affichage de 9" severity error;
                when 10 => assert O = "0001000" report "Erreur : Affichage de A" severity error;
                when 11 => assert O = "0000011" report "Erreur : Affichage de b" severity error;
                when 12 => assert O = "1000110" report "Erreur : Affichage de C" severity error;
                when 13 => assert O = "0100001" report "Erreur : Affichage de d" severity error;
                when 14 => assert O = "0000110" report "Erreur : Affichage de E" severity error;
                when 15 => assert O = "0001110" report "Erreur : Affichage de F" severity error;
                when others => null;
            end case;
        end loop;
        
        -- Test de quelques valeurs spécifiques importantes
        -- Vérification des chiffres décimaux (0-9) pour un chronomètre
        A <= "0000"; wait for 10 ns; -- 0
        A <= "0101"; wait for 10 ns; -- 5
        A <= "1001"; wait for 10 ns; -- 9
        
        report "Simulation terminée avec succès - Tous les segments testés" severity note;
        wait;
    end process;

end architecture behavior;
