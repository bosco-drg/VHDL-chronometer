library ieee;
use ieee.std_logic_1164.all;

-- =============================================================
-- Chronometre.vhd : entité de plus haut niveau
-- =============================================================

entity Chronometre is
    port (
        CLK           : in  std_logic;  -- horloge carte (100 MHz)
        SEL_SPEED_CLK : in  std_logic;  -- switch accélération du comptage
        START_STOP    : in  std_logic;  -- switch start/stop (enable)
        RESET         : in  std_logic;  -- bouton reset (actif à '1')

        LED_OUT : out std_logic_vector(9 downto 0); -- chenillard dixièmes
        AFF     : out std_logic_vector(6 downto 0); -- segments CA..CG (actifs bas)
        ANODES  : out std_logic_vector(3 downto 0); -- AN0..AN3 (actifs bas)
        TC      : out std_logic                -- terminal count (59:59.9)
    );
end entity Chronometre;

architecture rtl of Chronometre is

    -- Horloges internes
    signal clk_count : std_logic;
    signal clk_aff   : std_logic;

    -- Valeurs comptées
    signal unit_sec : std_logic_vector(3 downto 0);
    signal diz_sec  : std_logic_vector(3 downto 0);
    signal unit_min : std_logic_vector(3 downto 0);
    signal diz_min  : std_logic_vector(3 downto 0);

    -- LED internes (pour éviter lecture sur un port out)
    signal led_out_i : std_logic_vector(9 downto 0);

    -- TC cascade (issu du dernier compteur) + TC "instant fin" conforme au sujet
    signal tc_cascade : std_logic;
    signal tc_end     : std_logic;

begin

    -- -----------------------
    -- Génération horloges
    -- -----------------------
    U_CLK_COUNT : entity work.CLK_OUT_COUNT
        port map (
            CLK_IN        => CLK,
            SEL_SPEED_CLK => SEL_SPEED_CLK,
            CLK_OUT       => clk_count
        );

    U_CLK_AFF : entity work.CLK_OUT_AFF
        port map (
            CLK_IN      => CLK,
            CLK_OUT_AFF => clk_aff
        );

    -- -----------------------
    -- Comptage
    -- -----------------------
    U_COUNT : entity work.COUNTER_DIXIEME_MIN_SEC
        port map (
            CLK          => clk_count,
            RESET        => RESET,
            CE           => START_STOP,
            LED_OUT      => led_out_i,
            OUT_UNIT_SEC => unit_sec,
            OUT_DIZ_SEC  => diz_sec,
            OUT_UNIT_MIN => unit_min,
            OUT_DIZ_MIN  => diz_min,
            TC           => tc_cascade
        );

    -- TC demandé : fin à 59 min 59 sec 9/10e sec
    -- (détection de l'état terminal via les sorties accessibles)
    tc_end <= '1' when (diz_min = "0101" and unit_min = "1001" and
                        diz_sec = "0101" and unit_sec = "1001" and
                        led_out_i(9) = '1')
              else '0';

    TC <= tc_end;

    -- Propagation vers la sortie
    LED_OUT <= led_out_i;

    -- -----------------------
    -- Affichage 7 segments
    -- -----------------------
    U_AFF : entity work.Affichage
        port map (
            CLK          => clk_aff,
            RESET        => RESET,
            OUT_UNIT_SEC => unit_sec,
            OUT_DIZ_SEC  => diz_sec,
            OUT_UNIT_MIN => unit_min,
            OUT_DIZ_MIN  => diz_min,
            AFF          => AFF,
            ANODES       => ANODES
        );

end architecture rtl;

