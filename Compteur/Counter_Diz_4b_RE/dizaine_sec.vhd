

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Counter_Diz_4b_RE is
    Port ( ARESET : in STD_LOGIC;
           TC : out STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0);
           clock : in STD_LOGIC);
end Counter_Diz_4b_RE;

architecture Behavioral of Counter_Diz_4b_RE is

signal Q_int : unsigned (3 downto 0) := (others => '0');

begin
process (ARESET, clock)
begin
    if ARESET ='1' then
        Q_INT <= (others => '0');
    elsif falling_edge (clock) then 
		if Q_INT = 5 then
			Q_INT <= (others => '0');
		else 
			Q_INT <= Q_INT +1;
		end if;
    end if;

end process;

    Q <= std_logic_vector (Q_INT);
    TC <= '1' when Q_INT = 5 else '0';

end Behavioral;


