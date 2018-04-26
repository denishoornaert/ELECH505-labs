----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2018 04:59:32 PM
-- Design Name: 
-- Module Name: cs22_tb - Behavioral
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


entity cs22_tb is
end cs22_tb;

architecture arch of cs22_tb is
    component cs22 is
        port (
            D_in : IN std_logic;
            rst : IN std_logic;
            clk : IN std_logic; --'signal' in the assignment statement
            D_out : OUT std_logic_vector (0 to 7);
            valid : OUT std_logic
        );
    end component;
    
    constant tbperiod : time := 100 ns;
    signal tbD_in : std_logic;
    signal tbrst : std_logic;
    signal tbclk : std_logic;
    signal tbD_out : std_logic_vector (0 to 7);
    signal tbvalid : std_logic;
    
    type answers is array (0 to 4) of std_logic_vector (0  to 7);

begin
    tbcs22 : cs22 port map (D_in=>tbD_in, rst=>tbrst, clk=>tbclk, D_out=>tbD_out, valid=>tbvalid);

    stimuli : process
        variable ans : answers := ("00000010", "00100000", "10101100", "10011000", "11110100");
        
    begin
        tbD_in <= '0';
        tbrst <= '1';
        tbclk <= '0';
        wait for tbperiod;
        
        for i in 0 to 4 loop
            for j in 0 to 7 loop
                tbrst <= '0';
                tbclk <= not tbclk;
                tbD_in <= ans(i)(j);
                wait for tbperiod;
                
                tbclk <= not tbclk;
                wait for tbperiod;
            end loop;
            assert (tbD_out = ans(i)) report "Serial differs from parallel";
            assert (tbvalid = '1') report "valid should be equal to 1";
        end loop;
    end process;

end arch;
