----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2018 10:57:38 AM
-- Design Name: 
-- Module Name: lsfr_tb - Behavioral
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

entity lsfr_tb is
end lsfr_tb;

architecture Behavioral of lsfr_tb is
    component lsfr_bit is
        port(
            rst      : in  std_logic;
            clk      : in  std_logic;
            seed     : in  std_logic_vector(0 to 3);
            rbit_out : out std_logic
        );
    end component;
    
    signal internalres : std_logic;
    signal internalrst : std_logic;
    signal internalclk : std_logic;
    signal internalseed: std_logic_vector(0 to 3);
    
begin
    ilsfr : lsfr_bit port map(clk=>internalclk, rst=>internalrst, rbit_out=>internalres, seed=>internalseed);

    stimuli : process
    begin
        internalseed <= (others => '0');
        internalclk <= '1';
        internalrst <= '1';
        wait for 100ns;
        internalclk <= not internalclk;
        internalrst <= '0';
        wait for 100ns;
        
        for i in 0 to 9 loop
            internalclk <= not internalclk;
            internalrst <= '0';
            wait for 100ns;
            internalclk <= not internalclk;
            internalrst <= '0';
            wait for 100ns;
        end loop;
    end process;

end Behavioral;
