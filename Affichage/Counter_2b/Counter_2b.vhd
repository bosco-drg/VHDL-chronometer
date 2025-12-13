library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Counter_2b is
    port (
        CLK   : in  std_logic;
        RESET : in  std_logic;             -- actif à 1
        OUTPUT     : out std_logic_vector(1 downto 0)
    );
end entity Counter_2b;

architecture rtl of Counter_2b is
    signal cnt : unsigned(1 downto 0) := (others => '0');
begin

    process(CLK, RESET)
    begin
        if RESET = '1' then
            cnt <= (others => '0');
        elsif rising_edge(CLK) then
            cnt <= cnt + 1;
        end if;
    end process;

    OUTPUT <= std_logic_vector(cnt);

end architecture rtl;
