----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2018 04:40:11 PM
-- Design Name: 
-- Module Name: cs22 - Behavioral
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
--USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity cs22 is
  port (
    SD_in : IN std_logic;
    rst : IN std_logic;
    clk : IN std_logic; --'signal' in the assignment statement
    D_out : OUT std_logic_vector (0 to 7);
    valid : OUT std_logic
  );
end cs22;

architecture Behavioral of cs22 is
    signal cnt : std_logic_vector (0 to 2); -- number of bits received and stored in the register
    signal reg : std_logic_vector (0 to 7);
    
begin
    process (rst, clk)
    begin
        if(rst = '1') then
            reg <= (others => '0');
            cnt <= (others => '0');
        elsif(rising_edge(clk)) then
            cnt <= cnt+'1';
            reg(7) <= SD_in;
            reg(0 to 6) <= reg(1 to 7);
            if(cnt = "111") then
                valid <= '1';
                D_out(7) <= SD_in;
                D_out(0 to 6) <= reg(1 to 7);
            else
                valid <= '0';
                D_out <= (others => '0');
            end if;
        end if;
    end process;

end Behavioral;
