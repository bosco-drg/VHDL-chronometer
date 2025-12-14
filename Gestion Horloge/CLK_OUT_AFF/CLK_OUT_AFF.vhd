----------------------------------------------------------------------------------
-- Company: INSA Lyon
-- Engineer: Liam Morineau & Titouan Bocquet
-- 
-- Create Date: 14.12.2025 16:03:37
-- Design Name: 
-- Module Name: CLK_OUT_AFF - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity CLK_OUT_AFF is
    Port (
        CLK_OUT_AFF       : out STD_LOGIC   
    );
end CLK_OUT_AFF;

architecture Behavioral of CLK_OUT_AFF is

    constant CLK_PERIOD : time := 1 ms;

begin

    process
    begin
        
        CLK_OUT_AFF <= '0';
        wait for CLK_PERIOD / 2;
        CLK_OUT_AFF <= '1';
        wait for CLK_PERIOD / 2;
    end process;

end Behavioral;