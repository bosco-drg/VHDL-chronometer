----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2025 15:46:35
-- Design Name: 
-- Module Name: tb_CLK_OUT_COUNT - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_clk_out_count is
end tb_clk_out_count;

architecture Behavioral of tb_clk_out_count is

    -- Composant à tester
    component CLK_OUT_COUNT
        Port (
            SEL_SPEED_CLK : in  STD_LOGIC;
            CLK_OUT       : out STD_LOGIC
        );
    end component;

    -- Signaux internes
    signal SEL_SPEED_CLK_int : STD_LOGIC := '0';
    signal CLK_OUT_int       : STD_LOGIC;

    -- Constantes pour simulation
    constant SIM_TIME : time := 500 ms;  -- durée totale de la simulation

begin


    UUT : CLK_OUT_COUNT
        port map (
            SEL_SPEED_CLK => SEL_SPEED_CLK_int,
            CLK_OUT       => CLK_OUT_int
        );


    -- Processus de stimulation : on change SEL_SPEED_CLK pendant la simulation
    stim_proc : process
    begin

        -- Vitesse lente
        SEL_SPEED_CLK_int <= '0';
        wait for 200 ms;

        -- Passe en mode rapide
        SEL_SPEED_CLK_int <= '1';
        
        wait for 200 ms;

        -- Retour au mode lent
        SEL_SPEED_CLK_int <= '0';
        wait for 100 ms;

        
        wait;
    end process;

end Behavioral;
