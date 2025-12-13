----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2025 17:22:32
-- Design Name: 
-- Module Name: tb_dizaine_sec - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_counter_4b_RE_dizaine_sec is
-- L'entité de testbench est toujours vide
end tb_counter_4b_RE_dizaine_sec;

architecture Behavioral of tb_counter_4b_RE_dizaine_sec is

    -- Le nom du composant DOIT être celui de votre fichier source
    component counter_4b_RE_dizaine_sec is
        Port (
            ARESET : in  STD_LOGIC;
            TC_Ds  : out STD_LOGIC;
            Q      : out STD_LOGIC_VECTOR (3 downto 0); -- 4 bits
            TC_s   : in  STD_LOGIC
        );
    end component;
            
    signal ARESET_int : std_logic := '1';
    signal TC_Ds_int  : std_logic := '0';
    signal TC_s_int   : std_logic := '0';
    signal Q_vect     : STD_LOGIC_VECTOR (3 downto 0); --  4 bits ici aussi

    -- Constante pour la période (facilite les modifs)
    constant CLK_PERIOD : time := 10 ns; -- 7ns high + 7ns low

begin

    -- Instanciation du DUT (Device Under Test)
    uut : counter_4b_RE_dizaine_sec
        port map (
            ARESET => ARESET_int,
            TC_Ds  => TC_Ds_int,
            Q      => Q_vect,
            TC_s   => TC_s_int
        );

    -- Process de génération d'horloge
    TC_s_gen : process
    begin
        TC_s_int <= '0';
        wait for CLK_PERIOD / 2;
        TC_s_int <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Process de stimulation
    stim_proc : process
    begin
        -- 1. Initialisation
        ARESET_int <= '1'; -- Reset actif
        wait for 100 ns;

        -- 2. Relâchement du Reset : Le compteur démarre
        ARESET_int <= '0';
        
        -- 3. Attente pour voir le compteur tourner
        -- Il faut au moins 10 coups d'horloge pour voir TC_Ds passer à 1
        wait for 200 ns; 

        -- 4. Test du Reset pendant le fonctionnement
        ARESET_int <= '1';
        wait for 30 ns;
        ARESET_int <= '0';
        
        wait for 100 ns;

        -- 5. Fin de simulation
        assert false report "Fin de la simulation (Normal)" severity failure;
    end process;

end Behavioral;