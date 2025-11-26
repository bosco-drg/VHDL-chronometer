library ieee;
use ieee.std_logic_1164.all;

entity Mux_4x1x4b is
    port (
        A   : in  std_logic_vector(3 downto 0); -- secondes unités
        B   : in  std_logic_vector(3 downto 0); -- secondes dizaines
        C   : in  std_logic_vector(3 downto 0); -- minutes unités
        D   : in  std_logic_vector(3 downto 0); -- minutes dizaines
        sel : in  std_logic_vector(1 downto 0);
        O   : out std_logic_vector(3 downto 0)
    );
end entity Mux_4x1x4b;

architecture rtl of Mux_4x1x4b is
begin
    with sel select
        O <= A when "00",
             B when "01",
             C when "10",
             D when others;   -- "11"
end architecture rtl;
