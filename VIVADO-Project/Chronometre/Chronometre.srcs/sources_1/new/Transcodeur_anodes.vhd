----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2025 08:36:10
-- Design Name: 
-- Module Name: Transcodeur_anodes - Behavioral
-- Project Name: 
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

library ieee;
use ieee.std_logic_1164.all;

entity Transcodeur_anodes is
    port (
        sel_anode  : in  std_logic_vector(1 downto 0);
        vect_anode : out std_logic_vector(3 downto 0)
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
end architecture rtl;