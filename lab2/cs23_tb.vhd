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


entity cs23_tb is
end cs23_tb;

architecture arch of cs23_tb is
    component cs23 is
        port (
            D_in : IN std_logic;
            start : IN std_logic;
            rst : IN std_logic;
            clk : IN std_logic;
            D_out : OUT std_logic_vector (0 to 3);
            E : OUT std_logic
        );
    end component;
    
    constant tbperiod : time := 100 ns;
    signal tbD_in : std_logic;
    signal tbstart : std_logic;
    signal tbrst : std_logic;
    signal tbclk : std_logic;
    signal tbD_out : std_logic_vector (0 to 3);
    signal tbE : std_logic;
    
    type outputs is array (0 to 15) of std_logic_vector (0 to 3);
    type grayCodes is array (0 to 15) of std_logic_vector (0 to 3);
    type errors is array (0 to 15) of std_logic;
    
begin
    tbcs23 : cs23 port map(D_In=>tbD_in, start=>tbstart, rst=>tbrst, clk=>tbclk, D_out=>tbD_out, E=>tbE);
    
    stimuli : process
    variable output : outputs :=   ("0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111", "1000", "1001", "1111", "1111", "1111", "1111", "1111", "1111");
    variable input  : grayCodes := ("0000", "0001", "0011", "0010", "0110", "0111", "0101", "0100", "1100", "1000", "1001", "1010", "1011", "1101", "1110", "1111");
    variable error  : errors :=    ('0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '1', '1', '1', '1',  '1');
    
    begin
        tbD_in <= '0';
        tbrst <= '1';
        tbclk <= '0';
        wait for tbperiod;
        
        for i in 0 to 15 loop
            tbrst <= '0';
            tbclk <= not tbclk;
            tbstart <= '1';
            tbD_in <= input(i)(0);
            wait for tbperiod;
            
            for j in 1 to 3 loop
                tbstart <= '0';
                tbclk <= not tbclk;
                wait for tbperiod;
                tbD_in <= input(i)(j);
                tbclk <= not tbclk;
                wait for tbperiod;
            end loop;
            
            tbclk <= not tbclk;
            wait for tbperiod;
            assert (tbD_out = output(i)) report "Unexpected output (D_out)";
            assert (tbE = error(i)) report "Unexpected output (E)";
        end loop;
    end process;

end arch;
