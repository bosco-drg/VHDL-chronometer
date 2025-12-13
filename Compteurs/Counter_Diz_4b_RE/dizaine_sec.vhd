----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.11.2025 15:52:02
-- Design Name: 
-- Module Name: counter_4b_RE_dizaine_sec - Behavioral
-- Project Name: Unit seconde
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_4b_RE_dizaine_sec is
    Port ( ARESET : in STD_LOGIC;
           --CE : in STD_LOGIC;
           TC_Ds : out STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0);
           TC_s : in STD_LOGIC);
end counter_4b_RE_dizaine_sec;

architecture Behavioral of counter_4b_RE_dizaine_sec is

signal Q_int : unsigned (3 downto 0) := (others => '0');

begin
process (ARESET, TC_s)--liste de sensibilite , dè que siugnaux se modifient ==> entre dans le process et faisons modifs 
begin
    
    if ARESET ='1' then
        Q_INT <= (others => '0');
    elsif rising_edge (TC_s) then 
		if Q_INT = 5 then
			Q_INT <= (others => '0');
		else 
			Q_INT <= Q_INT +1;
		end if;
    end if;
    

end process;

    Q <= std_logic_vector (Q_INT);
    TC_Ds <= '1' when Q_INT = 5 else '0';

end Behavioral;

