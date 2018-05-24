----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2018 09:22:39 PM
-- Design Name: 
-- Module Name: ALU - arch
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ppalu4bits is
    Port (
        clk  : IN  std_logic;
        rst  : IN  std_logic;
        A    : IN  std_logic_vector (0 to 3);
        B    : IN  std_logic_vector (0 to 3);
        S    : IN  std_logic_vector (0 to 1);
        Cin  : IN  std_logic;
        M    : IN  std_logic;
        Dout : OUT std_logic_vector (0 to 3);
        Cout : OUT std_logic
    );
end ppalu4bits;

architecture arch of ppalu4bits is
    signal temporaryResult : std_logic_vector (0 to 4);
    signal temporaryOpcode : std_logic_vector (0 to 3);
    signal temporaryA      : std_logic_vector (0 to 3);
    signal temporaryB      : std_logic_vector (0 to 3);
    
begin

    process (rst, clk)
    begin
        if(rst = '1') then
            Dout <= (others => '0');
            Cout <= '0';
            temporaryResult <= (others => '0');
            temporaryOpcode <= (others => '0');
            temporaryA <= (others => '0');
            temporaryB <= (others => '0');
        elsif(rising_edge(clk)) then
            -- FETCH
            temporaryOpcode <= M&S&Cin;
            temporaryA <= A;
            temporaryB <= B;
            -- DECODE
            if(temporaryOpcode(0) = '0') then
                case (temporaryOpcode(1 to 2)) is
                    when("00") => temporaryResult <= '0'&(temporaryA or temporaryB);
                    when("01") => temporaryResult <= '0'&(temporaryA and temporaryB);
                    when("10") => temporaryResult <= '0'&(temporaryA xor temporaryB);    
                    when("11") => temporaryResult <= '0'&(temporaryA xnor temporaryB);
                    when others => temporaryResult <= "11111"; 
                end case;
            else
                case (temporaryOpcode(1 to 3)) is
                    when("000") => temporaryResult <= '0'&temporaryA;
                    when("001") => temporaryResult <= ('0'&temporaryA) + '1';
                    when("010") => temporaryResult <= ('0'&temporaryA) + ('0'&temporaryB);
                    when("011") => temporaryResult <= (('0'&temporaryA) + ('0'&temporaryB)) + '1';
                    when("100") => temporaryResult <= ('0'&temporaryA) + ('0'&(not(temporaryB)));
                    when("101") => temporaryResult <= ('0'&temporaryA) - temporaryB;
                    when("110") => temporaryResult <= ('0'&(not(temporaryA))) + ('0'&temporaryB);
                    when("111") => temporaryResult <= temporaryB - ('0'&temporaryA);
                    when others => temporaryResult <= "11111";
                end case;
            end if;
            -- EXECUTE (well not really :P)
            Dout <= temporaryResult(1 to 4);
            Cout <= temporaryResult(0);
        end if;
    end process;

end arch;
