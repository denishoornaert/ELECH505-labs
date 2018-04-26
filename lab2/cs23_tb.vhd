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
    
    type inputs is array (0 to 1) of std_logic_vector (0 to 3);
    type ograys is array (0 to 1) of std_logic_vector (0 to 3);
    type errors is array (0 to 1) of std_logic;
    
begin
    tbcs23 : cs23 port map(D_In=>tbD_in, start=>tbstart, rst=>tbrst, clk=>tbclk, D_out=>tbD_out, E=>tbE);
    
    stimuli : process
    variable inp : inputs := ("0001", "1010");
    variable gra : ograys := ("0001", "1111");
    variable err : errors := ('0', '1');
    
    begin
        tbD_in <= '0';
        tbrst <= '1';
        tbclk <= '0';
        wait for tbperiod;
        
        for i in 0 to 1 loop
            tbrst <= '0';
            tbclk <= not tbclk;
            tbstart <= '1';
            tbD_in <= inp(i)(0);
            wait for tbperiod;
            for j in 1 to 3 loop
                tbstart <= '0';
                tbclk <= not tbclk;
                wait for tbperiod;
                tbD_in <= inp(i)(j);
                tbclk <= not tbclk;
                wait for tbperiod;
            end loop;
            tbclk <= not tbclk;
            wait for tbperiod;
            assert (tbD_out = gra(i)) report "Unexpected output (D_out)";
            assert (tbE = err(i)) report "Unexpected output (E)";
        end loop;
    end process;

end arch;
