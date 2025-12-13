library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_counteurdixieme is
end tb_counteurdixieme;

architecture Behavioral of tb_counteurdixieme is

    component counteurdixieme is
        Port (
            ARESET : in  STD_LOGIC;
            clk    : in  STD_LOGIC;
            Q      : out STD_LOGIC_VECTOR (9 downto 0);
            CE     : in  STD_LOGIC;
            TC_ds  : out STD_LOGIC
        );
    end component;
           
    signal ARESET_int : std_logic := '1';
    signal CE_int     : std_logic := '0';
    signal TC_ds_int  : std_logic := '0';
    signal clk_int    : std_logic := '0';
    signal Q_vect     : STD_LOGIC_VECTOR (9 downto 0);

begin

    -- Instanciation du compteur
    uut : counteurdixieme
        port map (
            ARESET => ARESET_int,
            clk    => clk_int,
            Q      => Q_vect,
            CE     => CE_int,
            TC_ds  => TC_ds_int
        );

    -- Process de génération d'horloge
    clk_gen : process
    begin
        while true loop
            clk_int <= '0';
            wait for 7 ns;
            clk_int <= '1';
            wait for 7 ns;
        end loop;
    end process;

    -- Process de stimulation
    stim_proc : process
    begin
        -- Reset actif pendant 100 ns
        ARESET_int <= '1';
        CE_int <= '0';
        wait for 70 ns;

        ARESET_int <= '0';
        wait for 70 ns;

        -- Activation du comptage
        CE_int <= '1';
        wait for 1400 ns; -- durée de comptage

        -- Stop simulation proprement
        CE_int <= '0';
        wait for 50 ns;
        std.env.stop;  -- <- indispensable pour que la sim se termine proprement
        wait;
    end process;

end Behavioral;
