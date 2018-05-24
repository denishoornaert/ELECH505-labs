----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2018 10:19:06 PM
-- Design Name: 
-- Module Name: fsm1 - Behavioral
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

entity fsm1 is
    Port (
        clk      : IN  std_logic;
        rst      : IN  std_logic;
        dime     : IN  std_logic;
        nickel   : IN  std_logic;
        dispense : OUT std_logic
    );
end fsm1;

architecture arch of fsm1 is
    type states is (idle, s5, s10, s15, ok);
    
    signal status : states;
    
begin
    process (clk, rst)    
    begin
        if(rst = '1') then
            status <= idle;
            dispense <= '0';
        elsif(rising_edge(clk)) then
            case (status) is
                when (idle) =>
                    if(dime = '1') then
                        status <= s5;
                    elsif(nickel = '1') then
                        status <= s10;
                    end if;
                when (s5) =>
                    if(dime = '1') then
                        status <= s10;
                    elsif(nickel = '1') then
                        status <= s15;
                    end if;
                when (s10) =>
                    if(dime = '1') then
                        status <= s15;
                    elsif(nickel = '1') then
                        status <= ok;
                    end if;
                when (s15) =>
                    if(dime = '1') then
                        status <= ok;
                    elsif(nickel = '1') then
                        status <= ok;
                    end if;
                when (ok) => status <= idle;
                when others => null;
            end case;
            if(status = ok)then
                dispense <= '1';
            end if;
        end if;
    end process;

end arch;
