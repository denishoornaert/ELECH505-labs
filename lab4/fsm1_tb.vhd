----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2018 10:39:50 PM
-- Design Name: 
-- Module Name: fsm1_tb - Behavioral
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

entity fsm1_tb is
end fsm1_tb;

architecture Behavioral of fsm1_tb is
    component fsm1 is
        port(
            clk      : IN  std_logic;
            rst      : IN  std_logic;
            dime     : IN  std_logic;
            nickel   : IN  std_logic;
            dispense : OUT std_logic
        );
    end component;
    
    signal clktb      : std_logic;
    signal rsttb      : std_logic;
    signal dimetb     : std_logic;
    signal nickeltb   : std_logic;
    signal dispensetb : std_logic;
    
begin
    tbfsm1 : fsm1 port map(clk=>clktb, rst=>rsttb, dime=>dimetb, nickel=>nickeltb, dispense=>dispensetb);
    
    stimuli : process
    begin
        report "Vending machine on !";
        -- set up
        dimetb <= '0';
        nickeltb <= '0';
        rsttb <= '1';
        clktb <= '1';
        wait for 100 ns;
        
        -- synchronize the clock due to the set up
        rsttb <= '0';
        clktb <= not clktb;
        wait for 100 ns;
        
        -- insertion of 4xdimes + a last clock cycle
        dimetb <= '1';
        for i in 0 to 4 loop
            -- rising edge
            clktb <= not clktb;
            wait for 100 ns;
            -- falling edge
            clktb <= not clktb;
            wait for 100 ns;
        end loop;
        
        -- expect dispense to be at true
        assert (dispensetb = '1') report "Issue !";
        
    end process;

end Behavioral;
