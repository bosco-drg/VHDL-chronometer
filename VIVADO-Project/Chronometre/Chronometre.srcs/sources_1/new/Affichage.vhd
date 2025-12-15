library ieee;
use ieee.std_logic_1164.all;

entity Affichage is
    port (
        CLK   : in  std_logic;
        RESET     : in  std_logic;

        OUT_UNIT_SEC    : in  std_logic_vector(3 downto 0);
        OUT_DIZ_SEC    : in  std_logic_vector(3 downto 0);
        OUT_UNIT_MIN    : in  std_logic_vector(3 downto 0);
        OUT_DIZ_MIN     : in  std_logic_vector(3 downto 0);

        AFF       : out std_logic_vector(6 downto 0);
        ANODES    : out std_logic_vector(7 downto 0);
        
        DP_in        : in std_logic;
        DP_out       : out std_logic
    );
end entity Affichage;

architecture rtl of Affichage is

    signal sel      : std_logic_vector(1 downto 0);
    signal nibble   : std_logic_vector(3 downto 0);
    signal anodes_4 : std_logic_vector(3 downto 0);

begin

    U_CNT : entity work.Counter_2b
        port map (
            CLK   => CLK,
            RESET => RESET,
            OUTPUT     => sel
        );

    U_AN : entity work.Transcodeur_anodes
        port map (
            sel_anode  => sel,
            vect_anode => anodes_4,
            DP_in => DP_in,
            DP_out => DP_out
        );
        
        ANODES <= "1111" & anodes_4;

    U_MUX : entity work.Mux_4x1x4b
        port map (
            A   => OUT_UNIT_SEC,
            B   => OUT_DIZ_SEC,
            C   => OUT_UNIT_MIN,
            D   => OUT_DIZ_MIN,
            sel => sel,
            O   => nibble
           
        );

    U_7S : entity work.Transcodeur_7seg
        port map (
            entree => nibble,
            sortie => AFF
        );

end architecture rtl;

