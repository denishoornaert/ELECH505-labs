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
    D_in : IN std_logic;
    rst : IN std_logic;
    clk : IN std_logic; --'signal' in the assignment statement
    D_out : OUT std_logic_vector (0 to 7);
    valid : OUT std_logic
  );
end cs22;

architecture Behavioral of cs22 is
    signal cnt : std_logic_vector (0 to 2);
    signal reg : std_logic_vector (0 to 7);
    
begin
    process (rst, clk)
    begin
        if(rst = '1') then
            reg <= (others => '0');
            cnt <= (others => '0');
        elsif(rising_edge(clk)) then
            cnt <= cnt+'1';
            case (cnt) is
                when ("000") => reg(0) <= D_in;
                when ("001") => reg(1) <= D_in;
                when ("010") => reg(2) <= D_in;
                when ("011") => reg(3) <= D_in;
                when ("100") => reg(4) <= D_in;
                when ("101") => reg(5) <= D_in;
                when ("110") => reg(6) <= D_in;
                when others => reg(7) <= D_in;
            end case;
            if(cnt = "111") then
                valid <= '1';
            else
                valid <= '0';
            end if;
        end if;
        D_out <= reg;
    end process;

end Behavioral;
