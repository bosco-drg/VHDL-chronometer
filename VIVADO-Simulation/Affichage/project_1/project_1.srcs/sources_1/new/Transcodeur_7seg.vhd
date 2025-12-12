library ieee;
use ieee.std_logic_1164.all;

entity Transcodeur_7seg is
    port (
        A : in  std_logic_vector(3 downto 0); -- valeur hexadécimale
        O : out std_logic_vector(6 downto 0)  -- g f e d c b a (actifs à 0)
    );
end entity Transcodeur_7seg;

architecture rtl of Transcodeur_7seg is
begin
    with A select
        O <=
            "1000000" when "0000", -- 0
            "1111001" when "0001", -- 1
            "0100100" when "0010", -- 2
            "0110000" when "0011", -- 3
            "0011001" when "0100", -- 4
            "0010010" when "0101", -- 5
            "0000010" when "0110", -- 6
            "1111000" when "0111", -- 7
            "0000000" when "1000", -- 8
            "0010000" when "1001", -- 9
            "0001000" when "1010", -- A
            "0000011" when "1011", -- b
            "1000110" when "1100", -- C
            "0100001" when "1101", -- d
            "0000110" when "1110", -- E
            "0001110" when others; -- F
end architecture rtl;
