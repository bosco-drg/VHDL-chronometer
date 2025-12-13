library ieee;
use ieee.std_logic_1164.all;

entity Affichage is
    port (
        CLK   : in  std_logic;  -- horloge dédiée au multiplexage affichage
        RESET     : in  std_logic;  -- actif à 1

        OUT_UNIT_SEC    : in  std_logic_vector(3 downto 0);
        OUT_DIZ_SEC    : in  std_logic_vector(3 downto 0);
        OUT_UNIT_MIN    : in  std_logic_vector(3 downto 0);
        OUT_DIZ_MIN     : in  std_logic_vector(3 downto 0);

        AFF       : out std_logic_vector(6 downto 0); -- g f e d c b a (actifs à 0)
        ANODES    : out std_logic_vector(3 downto 0)  -- AN3 AN2 AN1 AN0 (actifs à 0)
    );
end entity Affichage;

architecture rtl of Affichage is

    signal sel      : std_logic_vector(1 downto 0);
    signal nibble   : std_logic_vector(3 downto 0);

begin

    -- Compteur 2 bits : sélection du digit
    U_CNT : entity work.Counter_2b
        port map (
            CLK   => CLK,
            RESET => RESET,
            OUTPUT     => sel
        );

    -- Transcodage des anodes (one-hot actif à 0)
    U_AN : entity work.Transcodeur_anodes
        port map (
            sel_anode  => sel,
            vect_anode => ANODES
        );

    -- Mux 4x1 : choisit la donnée à afficher selon sel
    U_MUX : entity work.Mux_4x1x4b
        port map (
            A   => OUT_UNIT_SEC,
            B   => OUT_DIZ_SEC,
            C   => OUT_UNIT_MIN,
            D   => OUT_DIZ_MIN,
            sel => sel,
            O   => nibble
        );

    -- Transcodeur 7 segments (actif à 0)
    U_7S : entity work.Transcodeur_7seg
        port map (
            entree => nibble,
            sortie => AFF
        );

end architecture rtl;
