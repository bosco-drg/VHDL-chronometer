library ieee;
use ieee.std_logic_1164.all;

entity Transcodeur_anodes is
    port (
        sel_anode  : in  std_logic_vector(1 downto 0);
        vect_anode : out std_logic_vector(3 downto 0)  -- AN3 AN2 AN1 AN0 (actifs à 0)
    );
end entity Transcodeur_anodes;

architecture rtl of Transcodeur_anodes is
begin
    -- 00 -> AN0, 01 -> AN1, 10 -> AN2, 11 -> AN3 (actifs à 0)
    with sel_anode select
        vect_anode <=
            "1110" when "00",  -- AN0 actif
            "1101" when "01",  -- AN1 actif
            "1011" when "10",  -- AN2 actif
            "0111" when others;-- AN3 actif
end architecture rtl;
