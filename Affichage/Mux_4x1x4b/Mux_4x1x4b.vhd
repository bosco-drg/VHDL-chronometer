library ieee;
use ieee.std_logic_1164.all;

entity Mux_4x1x4b is
    port (
        A   : in  std_logic_vector(3 downto 0);
        B   : in  std_logic_vector(3 downto 0);
        C   : in  std_logic_vector(3 downto 0);
        D   : in  std_logic_vector(3 downto 0);
        sel : in  std_logic_vector(1 downto 0);
        O   : out std_logic_vector(3 downto 0)
    );
end entity Mux_4x1x4b;

architecture rtl of Mux_4x1x4b is
begin
    with sel select
        O <=
            A when "00",
            B when "01",
            C when "10",
            D when others;
end architecture rtl;

