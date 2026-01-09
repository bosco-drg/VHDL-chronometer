library ieee;
use ieee.std_logic_1164.all;

entity Transcodeur_anodes is
    port (
        sel_anode  : in  std_logic_vector(1 downto 0);
        vect_anode : out std_logic_vector(3 downto 0);
        DP_in        : in std_logic;
        DP_out       : out std_logic
    );
end entity Transcodeur_anodes;

architecture rtl of Transcodeur_anodes is
begin
    with sel_anode select
        vect_anode <=
            "1110" when "00",
            "1101" when "01",
            "1011" when "10",
            "0111" when others;
        DP_out <= DP_in when sel_anode = "10" else '1';
end architecture rtl;