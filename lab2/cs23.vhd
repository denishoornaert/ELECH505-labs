----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2018 04:58:59 PM
-- Design Name: 
-- Module Name: cs23_tb - Behavioral
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
use ieee.std_logic_unsigned.all;


entity cs23 is
  port (
    D_in : IN std_logic;
    start : IN std_logic;
    rst : IN std_logic;
    clk : IN std_logic;
    D_out : OUT std_logic_vector (0 to 3);
    E : OUT std_logic
  );
end cs23;

architecture arch of cs23 is
    signal cnt : std_logic_vector (0 to 1);
    signal reg : std_logic_vector (0 to 3);
    
begin
    
    process (rst, clk)
    begin
        if(rst = '1') then
            -- pass
        elsif(rising_edge(clk)) then
        
            if(start = '1') then
                cnt <= "01";
                reg(0) <= D_in; -- 3 is the lsb offset
            else
                cnt <= cnt+'1';
                reg(0) <= D_in;
                reg(1 to 3) <= reg(0 to 2);
            end if;
            
            if(cnt = "11") then
                case (reg(2 to 2)&reg(1 to 1)&reg(0 to 0)&D_in) is
                    when("0000") => D_out <= "0000";
                    when("0001") => D_out <= "0001";
                    when("0011") => D_out <= "0010";
                    when("0010") => D_out <= "0011";
                    when("0110") => D_out <= "0100";
                    when("0111") => D_out <= "0101";
                    when("0101") => D_out <= "0110";
                    when("0100") => D_out <= "0111";
                    when("1100") => D_out <= "1000";
                    when("1000") => D_out <= "1001";
                    when others => D_out <= "1111";
                end case;
                case (reg(2 to 2)&reg(1 to 1)&reg(0 to 0)&D_in) is
                    when("0000") => E <= '0';
                    when("0001") => E <= '0';
                    when("0011") => E <= '0';
                    when("0010") => E <= '0';
                    when("0110") => E <= '0';
                    when("0111") => E <= '0';
                    when("0101") => E <= '0';
                    when("0100") => E <= '0'; 
                    when("1100") => E <= '0';
                    when("1000") => E <= '0';
                    when others => E <= '1';
                end case;
            end if;
        end if;
    end process;

end arch;

