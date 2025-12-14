----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2025 16:08:23
-- Design Name: 
-- Module Name: tb_CLK_OUT_AFF - Behavioral
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

entity tb_CLK_OUT_AFF is
end tb_CLK_OUT_AFF;

architecture Behavioral of tb_CLK_OUT_AFF is

    -- Composant à tester
    component CLK_OUT_AFF
        Port (
            CLK_OUT_AFF       : out STD_LOGIC
        );
    end component;

    -- Signaux internes
    signal CLK_OUT_AFF_int       : STD_LOGIC;

    -- Constantes pour simulation
    constant SIM_TIME : time := 500 ms;  -- durée totale de la simulation

begin


    UUT : CLK_OUT_AFF
        port map (
            CLK_OUT_AFF       => CLK_OUT_AFF_int
        );


    -- Processus de stimulation : on change SEL_SPEED_CLK pendant la simulation
    stim_proc : process
    begin

        wait for SIM_TIME;
        wait;
    end process;

end Behavioral;

