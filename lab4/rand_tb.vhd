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

entity rand_tb is
end rand_tb;

architecture Behavioral of rand_tb is
    component rand is
        port(
            iclk : IN std_logic;
            irst : IN std_logic;
            ires : OUT std_logic_vector (0 to 2)
        );
    end component;
    
    signal iclktb : std_logic;
    signal irsttb : std_logic;
    signal irestb : std_logic_vector(0 to 2);
    
begin
    randtb : rand port map(iclk=>iclktb, irst=>irsttb, ires=>irestb);
    
    stimuli : process
    begin
        iclktb <= '1';
        irsttb <= '1';
        wait for 100ns;
        iclktb <= not iclktb;
        irsttb <= '0';
        wait for 100ns;
        
        for i in 0 to 9 loop
            iclktb <= not iclktb;
            irsttb <= '0';
            wait for 100ns;
            iclktb <= not iclktb;
            irsttb <= '0';
            wait for 100ns;
        end loop;
    end process;

end Behavioral;
