----------------------------------------------------------------------------------
-- Company: INSA Lyon
-- Engineer: Titouan BOCQUET
-- 
-- Create Date: 12.12.2025 18:02:24
-- Module Name: tb_counter_dixieme_min_sec 
-- Target Devices: Artix 7
-- Description: 
-- TB testant les compteurs en cascade, on y retrouve toutes les entrées et sorties
-- pour vérifier leur fonctionnement.
--
-- Dependencies: IEEE.STD_LOGIC_1164.ALL 
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top_chrono is
end tb_top_chrono;

architecture Behavioral of tb_top_chrono is

    component COUNTER_DIXIEME_MIN_SEC
        Port (
            CLK     : in  STD_LOGIC;
            RESET  : in  STD_LOGIC;
            CE      : in  STD_LOGIC;
            LED_OUT : out STD_LOGIC_VECTOR (9 downto 0);
            OUT_UNIT_SEC : out STD_LOGIC_VECTOR (3 downto 0);
            OUT_DIZ_SEC  : out STD_LOGIC_VECTOR (3 downto 0);
            OUT_UNIT_MIN : out STD_LOGIC_VECTOR (3 downto 0);
            OUT_DIZ_MIN  : out STD_LOGIC_VECTOR (3 downto 0);
            TC : out std_logic
        );
    end component;

    -- Signaux internes
    signal CLK         : STD_LOGIC := '0';
    signal RESET      : STD_LOGIC := '0';
    signal CE          : STD_LOGIC := '1';
    signal LED_OUT     : STD_LOGIC_VECTOR (9 downto 0);
    signal OUT_UNIT_SEC : STD_LOGIC_VECTOR (3 downto 0);
    signal OUT_DIZ_SEC  : STD_LOGIC_VECTOR (3 downto 0);
    signal OUT_UNIT_MIN : STD_LOGIC_VECTOR (3 downto 0);
    signal OUT_DIZ_MIN  : STD_LOGIC_VECTOR (3 downto 0);
    signal TC          : STD_LOGIC;

    constant CLK_PERIOD : time := 100 ms;
    constant SIM_TIME   : time := 70000 ms;

begin

    
    UUT : COUNTER_DIXIEME_MIN_SEC
        port map (
            CLK     => CLK,
            RESET  => RESET,
            CE      => CE,
            LED_OUT => LED_OUT,
            OUT_UNIT_SEC => OUT_UNIT_SEC,
            OUT_DIZ_SEC  => OUT_DIZ_SEC,
            OUT_UNIT_MIN => OUT_UNIT_MIN,
            OUT_DIZ_MIN  => OUT_DIZ_MIN,
            TC => TC
        );

    -- Processus d'horloge
    clk_process : process
    begin
        while True loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- generateur de stimulis
    stim_proc : process
    begin
        RESET <= '1';
        CE <= '0';
        wait for 50 ns;

        RESET <= '0';
        wait for 50 ns;
        CE <= '1';

        wait for SIM_TIME;

        CE <= '0';
        wait;
    end process;

end Behavioral;

