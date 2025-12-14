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
            CLK_OUT_AFF       : out STD_LOGIC;
            CLK_IN : in std_logic 
        );
    end component;

    -- Signaux internes
    signal CLK_OUT_AFF_int       : STD_LOGIC;
    signal CLK_IN_int       : STD_LOGIC := '0';

    -- Constantes pour simulation
    constant SIM_TIME : time := 500 ms;  -- durée totale de la simulation

begin


    UUT : CLK_OUT_AFF
        port map (
            CLK_OUT_AFF       => CLK_OUT_AFF_int,
            CLK_IN        => CLK_IN_int
        );
        
    clk_proc : process
    begin 
        while True loop
            CLK_IN_int <= '0';
            wait for 5 ns;
            CLK_IN_int <= '1';
            wait for 5 ns;
        end loop;
    end process;


    -- Processus de stimulation : on change SEL_SPEED_CLK pendant la simulation
    stim_proc : process
    begin

        wait for SIM_TIME;
        wait;
    end process;

end Behavioral;

