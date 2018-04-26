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
    signal isRecieving : std_logic;
    signal inputBuffer : std_logic_vector (0 to 3);
    signal inputBufferCnt : std_logic_vector (0 to 1);
    signal outputBuffer : std_logic_vector (0 to 3);

begin
    process (rst, clk)
    begin
        if(rst = '1') then
            isRecieving <= '0';
            inputBuffer <= (others => '0');
            inputBufferCnt <= (others => '0');
        elsif(rising_edge(clk)) then
            if(inputBufferCnt = "11") then
                case (inputBuffer) is
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
                case (inputBuffer) is
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
            elsif(start = '1' and inputBufferCnt = "00") then
                isRecieving <= '1';
                inputBufferCnt <= inputBufferCnt+'1';
                inputBuffer(0) <= D_in;
            else
                case (inputBufferCnt) is
                    when ("01") => inputBuffer(1) <= D_in;
                    when ("10") => inputBuffer(2) <= D_in;
                    when others => inputBuffer(3) <= D_in;
                end case;
                inputBufferCnt <= inputBufferCnt+'1';
                if(inputBufferCnt = "11") then
                    isRecieving <= '0';
                end if;                
            end if;
        end if;
        --D_out <= outputBuffer;
    end process;

end arch;
