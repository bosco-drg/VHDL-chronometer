library ieee;
use ieee.std_logic_1164.all;

entity Chronometre is
    port (
        CLK           : in  std_logic;
        SEL_SPEED_CLK : in  std_logic;
        START_STOP    : in  std_logic;
        RESET         : in  std_logic;

        LED_OUT : out std_logic_vector(9 downto 0);
        AFF     : out std_logic_vector(6 downto 0);
        ANODES  : out std_logic_vector(7 downto 0);
        TC      : out std_logic;
        DP_out  : out std_logic
    );
end entity Chronometre;

architecture rtl of Chronometre is

    signal clk_count : std_logic;
    signal clk_aff   : std_logic;

    signal unit_sec : std_logic_vector(3 downto 0);
    signal diz_sec  : std_logic_vector(3 downto 0);
    signal unit_min : std_logic_vector(3 downto 0);
    signal diz_min  : std_logic_vector(3 downto 0);

    signal led_out_i : std_logic_vector(9 downto 0);

    signal tc_cascade : std_logic;
    signal tc_end     : std_logic;
    signal dp_blink         : std_logic;

begin

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
            TC           => tc_cascade,
            DP           => dp_blink
        );

    tc_end <= '1' when (diz_min = "0101" and unit_min = "1001" and
                        diz_sec = "0101" and unit_sec = "1001" and
                        led_out_i(9) = '1')
              else '0';

    TC <= tc_end;

    LED_OUT <= led_out_i;

    U_AFF : entity work.Affichage
        port map (
            CLK          => clk_aff,
            RESET        => RESET,
            OUT_UNIT_SEC => unit_sec,
            OUT_DIZ_SEC  => diz_sec,
            OUT_UNIT_MIN => unit_min,
            OUT_DIZ_MIN  => diz_min,
            AFF          => AFF,
            ANODES       => ANODES,
            DP_in           => dp_blink,
            DP_out => DP_out
        );

end architecture rtl;

