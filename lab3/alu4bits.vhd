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


entity alu4bits is
    Port (
        A    : IN  std_logic_vector (0 to 3);
        B    : IN  std_logic_vector (0 to 3);
        S    : IN  std_logic_vector (0 to 1);
        Cin  : IN  std_logic;
        M    : IN  std_logic;
        Dout : OUT std_logic_vector (0 to 3);
        Cout : OUT std_logic
    );
end alu4bits;

architecture arch of alu4bits is
    signal resultMTr : std_logic_vector (0 to 4);
    signal resultMFa : std_logic_vector (0 to 4);
    signal internalD : std_logic_vector (0 to 4);
    
begin
    
    with (S) select
        resultMFa <= ('0'&(A or B))   when "00",
                     ('0'&(A and B))  when "01",
                     ('0'&(A xor B))  when "10",
                     ('0'&(A xnor B)) when "11",
                     "11111"          when others;
    
    with (S&Cin) select
        resultMTr <= ('0'&A)                     when "000",
                     (('0'&A) + '1')             when "001",
                     (('0'&A) + ('0'&B))         when "010",
                     ((('0'&A) + ('0'&B)) + '1') when "011",
                     (('0'&A) + ('0'&(not(B))))  when "100",
                     (('0'&A) - B)               when "101",
                     (('0'&(not(A))) + ('0'&B))  when "110",
                     (B - ('0'&A))               when "111",
                     "11111" when others;
    
    with (M) select
        internalD <= resultMFa when '0',
                     resultMTr when others;
                  
    Dout <= internalD(1 to 4);
    Cout <= internalD(0);

end arch;

