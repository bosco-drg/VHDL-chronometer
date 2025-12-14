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
        CLK_IN : in std_logic ;
        CLK_OUT_AFF       : out STD_LOGIC   
    );
end CLK_OUT_AFF;

architecture Behavioral of CLK_OUT_AFF is

    constant CLK_FREQ : integer := 1000;
    constant CLK_IN_FREQ  : integer := 100_000_000; --en Hz
    
    constant DIV : integer := CLK_IN_FREQ / (2 * CLK_FREQ);
    
    signal counter   : integer := 0;
    signal clk_state : std_logic := '0';

begin

   process (CLK_IN)
    begin
        if rising_edge(CLK_IN) then

            if counter = div - 1 then
                counter   <= 0;
                clk_state <= not clk_state;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    CLK_OUT_AFF <= clk_state;

end Behavioral;