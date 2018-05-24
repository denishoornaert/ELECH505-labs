----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2018 10:14:45 AM
-- Design Name: 
-- Module Name: rand_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity randuint_tb is
end randuint_tb;

architecture Behavioral of randuint_tb is
    component randuint is
        port(
            clk : IN std_logic;
            rst : IN std_logic;
            val : IN std_logic;
            res : OUT std_logic_vector(0 to 3)
        );
    end component;
    
    signal clktb : std_logic;
    signal rsttb : std_logic;
    signal valtb : std_logic;
    signal restb : std_logic_vector(0 to 3);
    
begin
    randuinttb : randuint port map(clk=>clktb, rst=>rsttb, val=>valtb, res=>restb);
    
    stimuli : process
    begin
        valtb <= '1';
        clktb <= '1';
        rsttb <= '1';
        wait for 100ns;
        clktb <= not clktb;
        rsttb <= '0';
        wait for 100ns;
        
        for i in 0 to 9 loop
            clktb <= not clktb;
            rsttb <= '0';
            wait for 100ns;
            clktb <= not clktb;
            rsttb <= '0';
            wait for 100ns;
        end loop;
    end process;

end Behavioral;
