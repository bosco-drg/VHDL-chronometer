library ieee;
use ieee.std_logic_1164.all;

entity tb_Affichage is
end entity;

architecture sim of tb_Affichage is
    signal clk_aff : std_logic := '0';
    signal reset   : std_logic := '0';

    signal sec_u   : std_logic_vector(3 downto 0) := "0100"; -- 4
    signal sec_d   : std_logic_vector(3 downto 0) := "0011"; -- 3
    signal min_u   : std_logic_vector(3 downto 0) := "0010"; -- 2
    signal min_d   : std_logic_vector(3 downto 0) := "0001"; -- 1

    signal aff     : std_logic_vector(6 downto 0);
    signal anodes  : std_logic_vector(3 downto 0);

    constant TCLK : time := 10 ns;
begin
    -- DUT
    DUT : entity work.Affichage
        port map (
            CLK_AFF => clk_aff,
            RESET   => reset,
            SEC_U   => sec_u,
            SEC_D   => sec_d,
            MIN_U   => min_u,
            MIN_D   => min_d,
            AFF     => aff,
            ANODES  => anodes
        );

    -- Clock
    clk_aff <= not clk_aff after TCLK/2;

    -- Reset + changements de valeurs
    process
    begin
        reset <= '1';
        wait for 50 ns;
        reset <= '0';

        wait for 500 ns;

        -- Change à AF:09
        min_d <= "1010"; -- A
        min_u <= "1111"; -- F
        sec_d <= "0000"; -- 0
        sec_u <= "1001"; -- 9

        wait for 500 ns;

        assert false report "Fin simulation" severity failure;
    end process;
end architecture;
