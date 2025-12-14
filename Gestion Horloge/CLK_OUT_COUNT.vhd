----------------------------------------------------------------------------------
-- Company: INSA Lyon
-- Engineer: Liam Morineau & Titouan Bocquet
-- 
-- Create Date: 14.12.2025 15:21:22
-- Module Name: CLK_OUT_COUNT - Behavioral
-- Target Devices: Artix 7
-- Description: Cette entité permet de générer une première horloge (CLK_OUT_COUNT) qui sert de base pour le 
--comptage des dixièmes de secondes et donc des secondes et des minutes (attention à ne pas créer 
--plusieurs horloges). Pour cela, vous devez créer un compteur qui permet générer un signal carré de 
--période 0,1s.
-- 
-- Dependencies: STD_LOGIC_1164
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CLK_OUT_COUNT is
    Port (
        SEL_SPEED_CLK : in  STD_LOGIC;  
        CLK_OUT       : out STD_LOGIC   
    );
end CLK_OUT_COUNT;

architecture Behavioral of CLK_OUT_COUNT is

    constant CLK_NORMAL_PERIOD : time := 100 ms;
    constant CLK_FAST_PERIOD : time := 0.1666666667 ms;

begin

    process
        variable temp_period : time;
    begin
        
        if SEL_SPEED_CLK = '1' then
            temp_period := CLK_FAST_PERIOD;
        else
            temp_period := CLK_NORMAL_PERIOD;
        end if;

        
        CLK_OUT <= '0';
        wait for temp_period / 2;
        CLK_OUT <= '1';
        wait for temp_period / 2;
    end process;

end Behavioral;


