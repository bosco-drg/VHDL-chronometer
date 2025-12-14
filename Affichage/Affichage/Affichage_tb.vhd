library ieee;
use ieee.std_logic_1164.all;

entity tb_Affichage is
end entity;

architecture sim of tb_Affichage is
    signal clk_aff : std_logic := '0';
    signal reset   : std_logic := '0';

    signal out_unit_sec   : std_logic_vector(3 downto 0) := "0100";
    signal out_diz_sec   : std_logic_vector(3 downto 0) := "0011";
    signal out_unit_min   : std_logic_vector(3 downto 0) := "0010";
    signal out_diz_min   : std_logic_vector(3 downto 0) := "0001";

    signal aff     : std_logic_vector(6 downto 0);
    signal anodes  : std_logic_vector(3 downto 0);

    constant TCLK : time := 10 ns;
begin
    DUT : entity work.Affichage
        port map (
            CLK         => clk_aff,
            RESET       => reset,
            OUT_UNIT_SEC => out_unit_sec,
            OUT_DIZ_SEC  => out_diz_sec,
            OUT_UNIT_MIN => out_unit_min,
            OUT_DIZ_MIN  => out_diz_min,
            AFF         => aff,
            ANODES      => anodes
        );

    clk_aff <= not clk_aff after TCLK/2;

    process
    begin
        reset <= '1';
        wait for 50 ns;
        reset <= '0';

        wait for 500 ns;

        out_diz_min <= "1010";
        out_unit_min <= "1111";
        out_diz_sec <= "0000";
        out_unit_sec <= "1001";

        wait for 500 ns;

        assert false report "Fin simulation" severity failure;
    end process;
end architecture;

