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
        CLK_IN        : in  STD_LOGIC;
        SEL_SPEED_CLK : in  STD_LOGIC;
        CLK_OUT       : out STD_LOGIC
    );
end CLK_OUT_COUNT;

architecture Behavioral of CLK_OUT_COUNT is

    constant CLK_IN_FREQ      : integer := 100_000_000;
    constant CLK_NORMAL_FREQ  : integer := 10;        
    constant CLK_FAST_FREQ    : integer := 6000;      

    constant DIV_NORMAL : integer := CLK_IN_FREQ / (2 * CLK_NORMAL_FREQ);
    constant DIV_FAST   : integer := CLK_IN_FREQ / (2 * CLK_FAST_FREQ);

    signal counter   : integer := 0;
    signal clk_state : std_logic := '0';

begin

    process (CLK_IN)
        variable div_value : integer;
    begin
        if rising_edge(CLK_IN) then
            if SEL_SPEED_CLK = '1' then
                div_value := DIV_FAST;
            else
                div_value := DIV_NORMAL;
            end if;

            if counter = div_value - 1 then
                counter   <= 0;
                clk_state <= not clk_state;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    CLK_OUT <= clk_state;

end Behavioral;



