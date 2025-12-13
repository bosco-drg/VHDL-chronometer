----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2025 16:39:05
-- Design Name: 
-- Module Name: counter_dixieme_min_sec - Behavioral
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

entity COUNTER_DIXIEME_MIN_SEC is
    Port (
        clk     : in  STD_LOGIC;
        ARESET  : in  STD_LOGIC;
        CE      : in  STD_LOGIC;
        LED_OUT : out STD_LOGIC_VECTOR (9 downto 0);
        OUT_UNIT_SEC : out STD_LOGIC_VECTOR (3 downto 0);
        OUT_DIZ_SEC : out STD_LOGIC_VECTOR (3 downto 0);
        OUT_UNIT_MIN : out STD_LOGIC_VECTOR (3 downto 0);
        OUT_DIZ_MIN : out STD_LOGIC_VECTOR (3 downto 0);
        TC : out std_logic
        
    );
end COUNTER_DIXIEME_MIN_SEC;

architecture Behavioral of COUNTER_DIXIEME_MIN_SEC is

    component counteurdixieme is
        Port (
            ARESET : in STD_LOGIC; 
            CE     : in STD_LOGIC; 
            TC_ds  : out STD_LOGIC; 
            Q      : out STD_LOGIC_VECTOR(9 downto 0); 
            clk    : in STD_LOGIC
        );
    end component;

    component Counter_Unit_4b_RE is
    Port (
        ARESET : in STD_LOGIC;
        --CE     : in STD_LOGIC;
        TC     : out STD_LOGIC;
        Q      : out STD_LOGIC_VECTOR (3 downto 0);
        clock  : in STD_LOGIC
    );
end component;


    component Counter_Diz_4b_RE is
        Port (
            ARESET : in STD_LOGIC;
            TC  : out STD_LOGIC;
            Q      : out STD_LOGIC_VECTOR (3 downto 0);
            clock   : in STD_LOGIC
        );
    end component;

    -- Signaux internes
    signal TC_ds_sig  : STD_LOGIC;
    signal TC_s_sig   : STD_LOGIC;
    signal TC_Dizs_sig  : STD_LOGIC;
    signal TC_min_sig : STD_LOGIC;

begin

    -- Compteur des dixièmes de secondes
    U0 : counteurdixieme 
        port map (
            ARESET => ARESET,
            CE     => CE,
            TC_ds  => TC_ds_sig,
            Q      => LED_OUT,   
            clk    => clk
        );

    -- Compteur des unités de secondes
    U1 : counter_unit_4b_RE 
        port map (
            ARESET => ARESET,
            --CE     => '1',
            TC   => TC_s_sig,
            Q      => OUT_UNIT_SEC,
            clock  => TC_ds_sig
        );

    -- Compteur des dizaines de secondes
    U2 : Counter_Diz_4b_RE
        port map (
            ARESET => ARESET,
            TC  => TC_dizs_sig,
            Q      => OUT_DIZ_SEC,
            clock   => TC_s_sig
        );
        
        -- Compteur des unités de minutes
    U3 : Counter_Unit_4b_RE
        port map (
            ARESET => ARESET,
            --CE     => '1',
            TC     => TC_min_sig,
            Q      => OUT_UNIT_MIN,
            clock  => TC_Dizs_sig
        );
    U4 : Counter_Diz_4b_RE
        port map (
            ARESET => ARESET,
            TC  => TC,
            Q      => OUT_DIZ_MIN,
            clock   => TC_min_sig
        );

end Behavioral;


