----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2018 11:01:28 PM
-- Design Name: 
-- Module Name: controller_tb - Behavioral
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
use ieee.numeric_std.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity controller_tb is
end controller_tb;

architecture Behavioral of controller_tb is
    component controller is
        Port (
            clk    : IN  std_logic;
            rst    : IN  std_logic;
            userin : IN  std_logic;
            user   : IN  std_logic_vector (0 to 1); -- 0 left, 1 right, 2 up, 3 down
            ready  : OUT std_logic;
            result : OUT std_logic -- U in progress, 0 loose, 1 win
        );
    end component;
    
    signal clktb    : std_logic;
    signal rsttb    : std_logic;
    signal userintb : std_logic;
    signal usertb   : std_logic_vector (0 to 1);
    signal readytb  : std_logic;
    signal resulttb : std_logic;
    
begin
    controllertb : controller port map(clk=>clktb, rst=>rsttb, userin=>userintb, user=>usertb, ready=>readytb, result=>resulttb);

    process
    begin
        rsttb <= '1';
        clktb <= '1';
        userintb <= '0';
        usertb <= (others => '0');
        wait for 100ns;
        
        rsttb <= '0';
        clktb <= not clktb;
        wait for 100ns;
    
        infinite: loop
            rsttb <= '0';
            clktb <= not clktb;
            wait for 100ns;
            
            if(readytb = '1') then
                userintb <= '1';
                usertb <= usertb+'1';
            else
                userintb <= '0';
            end if;
            
            rsttb <= '0';
            clktb <= not clktb;
            wait for 100ns;
            
            exit infinite when (resulttb = '1' or resulttb = '0');
        end loop;
        
        -- Warning/reminder : print the opposite
        assert resulttb = '1' report "Lost";
        assert resulttb = '0' report "Won";
        
    end process;

end Behavioral;
