----------------------------------------------------------------------------------
-- Company: INSA Lyon
-- Engineer: Titouan BOCQUET
-- 
-- Create Date: 12.11.2025 15:52:02
-- Module Name: counteurdixieme - Behavioral
-- Target Devices: Artix 7 
-- Description: Compteur spécifique pour les dixièmes de seconde 
-- 
-- 
-- Additional Comments:
-- sur front montant de clk
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counteurdixieme is
    Port ( 
        ARESET : in  STD_LOGIC;
        CE     : in  STD_LOGIC;
        TC_ds  : out STD_LOGIC;
        Q      : out STD_LOGIC_VECTOR (9 downto 0);
        clk    : in  STD_LOGIC;
        DP     : out std_logic 
    );
end counteurdixieme;

architecture Behavioral of counteurdixieme is

    signal Q_int : unsigned (9 downto 0) := "0000000001";

begin

    process (ARESET, clk)
    begin
        if ARESET = '1' then
            Q_int <= "0000000001";  
        elsif falling_edge(clk) then
            if CE = '1' then 
                if Q_INT = 512 then 
                    Q_INT <= "0000000001"; 
                else 
                    Q_INT <= shift_left(Q_INT, 1);
                end if;
            end if;
        end if;
        
    end process;
    DP <= '0' when Q_int <= 32 else '1';
    Q <= std_logic_vector(Q_int);
    TC_ds <= '1' when Q_int = "1000000000" else '0';
    

end Behavioral;
