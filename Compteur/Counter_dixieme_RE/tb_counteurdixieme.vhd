----------------------------------------------------------------------------------
-- Company: INSA Lyon
-- Engineer: Titouan BOCQUET
-- 
-- Create Date: 12.11.2025 17:22:32
-- Module Name: tb_dizaine_sec - Behavioral
-- Target Devices: Artix 7 
-- Description: tb du compteur des dizièmes de secondes
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


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

    -- compteur
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

    
    stim_proc : process
    begin
        
        ARESET_int <= '1';
        CE_int <= '0';
        wait for 70 ns;

        ARESET_int <= '0';
        wait for 70 ns;

        
        CE_int <= '1';
        wait for 1400 ns;

        
        CE_int <= '0';
        wait for 50 ns;
        std.env.stop;  -- <-  sim se termine 
        wait;
    end process;

end Behavioral;
