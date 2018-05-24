----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2018 10:39:50 PM
-- Design Name: 
-- Module Name: fsm1_tb - Behavioral
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
use ieee.numeric_std.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fsm2_tb is
end fsm2_tb;

architecture Behavioral of fsm2_tb is
    component fsm2 is
        port(
            clk : IN std_logic;
            rst : IN std_logic;
            ins : IN std_logic_vector (0 to 3);
            addr: IN std_logic_vector (0 to 3);
            vin : IN std_logic_vector (0 to 10);
            val : OUT std_logic;
            win : OUT std_logic;
            empty : OUT std_logic
        );
    end component;
    
    signal clktb : std_logic;
    signal rsttb : std_logic;
    signal instb : std_logic_vector(0 to 3);
    signal vintb : std_logic_vector(0 to 10);
    signal addrtb: std_logic_vector(0 to 3);
    signal valtb : std_logic;
    signal wintb : std_logic;
    signal emptytb : std_logic;
    
    -- set=000, idle=001, up=010, down=011, left=100, right=101
    
begin
    tbfsm2 : fsm2 port map(clk=>clktb, rst=>rsttb, ins=>instb, vin=>vintb, addr=>addrtb, val=>valtb, win=>wintb, empty=>emptytb);
    
    stimuli : process
    begin
    
report "Test placing particular elements";
        clktb <= '1';
        rsttb <= '1';
        instb <= "0110";
        vintb <= (others => '0');
        wait for 100ns;
        
        clktb <= not clktb;
        rsttb <= '0';
        wait for 100ns;
        
        for i in 0 to 5 loop
            clktb <= not clktb;
            rsttb <= '0';
            instb <= "0110";
            addrtb <= "1000";
            vintb <= "01000000000";
            wait for 100ns;
            
            clktb <= not clktb;
            rsttb <= '0';
            wait for 100ns;
            
            while (valtb /= '1') loop
                instb <= "0001";
                clktb <= not clktb;
                rsttb <= '0';
                wait for 100ns;
                
                clktb <= not clktb;
                rsttb <= '0';
                wait for 100ns;
            end loop;
            
            clktb <= not clktb;
            rsttb <= '0';
            wait for 100ns;
            
            clktb <= not clktb;
            rsttb <= '0';
            wait for 100ns;
        end loop;
        
        for i in 0 to 2 loop
            if(i = 0) then
                instb <= "1000";
            else
                instb <= "0001";
            end if;
            
            clktb <= not clktb;
            rsttb <= '0';
            wait for 100ns;
            
            clktb <= not clktb;
            rsttb <= '0';
            wait for 100ns;
        end loop;
    
-- test check wining 2048
--        report "Test placing particular elements";
--        clktb <= '1';
--        rsttb <= '1';
--        instb <= "110";
--        vintb <= (others => '0');
--        wait for 100ns;
        
--        clktb <= not clktb;
--        rsttb <= '0';
--        wait for 100ns;
        
--        for i in 0 to 1 loop
--            clktb <= not clktb;
--            rsttb <= '0';
--            instb <= "110";
--            addrtb <= "1000";
--            vintb <= "01000000000";
--            wait for 100ns;
            
--            clktb <= not clktb;
--            rsttb <= '0';
--            wait for 100ns;
            
--            while (valtb /= '1') loop
--                instb <= "001";
--                clktb <= not clktb;
--                rsttb <= '0';
--                wait for 100ns;
                
--                clktb <= not clktb;
--                rsttb <= '0';
--                wait for 100ns;
--            end loop;
            
--            clktb <= not clktb;
--            rsttb <= '0';
--            wait for 100ns;
            
--            clktb <= not clktb;
--            rsttb <= '0';
--            wait for 100ns;
--        end loop;
        
--        report "Test left motion!";
--        clktb <= not clktb;
--        rsttb <= '0';
--        instb <= "010";
--        wait for 100ns;
        
--        clktb <= not clktb;
--        rsttb <= '0';
--        wait for 100ns;
        
--        for i in 0 to 3 loop
--            clktb <= not clktb;
--            rsttb <= '0';
--            instb <= "001";
--            wait for 100ns;
            
--            clktb <= not clktb;
--            rsttb <= '0';
--            wait for 100ns;
--        end loop;
        
--        clktb <= not clktb;
--        rsttb <= '0';
--        instb <= "111";
--        wait for 100ns;
        
--        clktb <= not clktb;
--        rsttb <= '0';
--        wait for 100ns;
        
--        clktb <= not clktb;
--        rsttb <= '0';
--        instb <= "001";
--        wait for 100ns;
        
--        clktb <= not clktb;
--        rsttb <= '0';
--        wait for 100ns;
        
--        assert (wintb = '1') report "Win should be equal to 1";
        
        
-- Test multiple movements
--        report "Test placing elements";
--        clktb <= '1';
--        rsttb <= '1';
--        instb <= "000";
--        vintb <= (others => '0');
--        wait for 100ns;
        
--        clktb <= not clktb;
--        rsttb <= '0';
--        wait for 100ns;
        
--        for i in 0 to 15 loop
--            instb <= "001";
--            clktb <= not clktb;
--            rsttb <= '0';
--            case(i) is
--                when 0|1|2|3|7|11|15 => vintb <= "00000000000";
--                when 4|5|8|9 => vintb <= "00000000100";
--                when 6|10|12|13 => vintb <= "00000001000";
--                when 14 => vintb <=       "00000010000";
--                when others => null;
--            end case;
--            wait for 100ns;
            
--            clktb <= not clktb;
--            rsttb <= '0';
--            wait for 100ns;
--        end loop;
        
--        report "Test left motion!";
--        clktb <= not clktb;
--        rsttb <= '0';
--        instb <= "010";
--        wait for 100ns;
        
--        clktb <= not clktb;
--        rsttb <= '0';
--        wait for 100ns;
        
--        for i in 0 to 3 loop
--            clktb <= not clktb;
--            rsttb <= '0';
--            instb <= "001";
--            wait for 100ns;
            
--            clktb <= not clktb;
--            rsttb <= '0';
--            wait for 100ns;
--        end loop;
        
--        report "Test down motion!";
--        clktb <= not clktb;
--        rsttb <= '0';
--        instb <= "101";
--        wait for 100ns;
        
--        clktb <= not clktb;
--        rsttb <= '0';
--        wait for 100ns;
        
--        for i in 0 to 3 loop
--            clktb <= not clktb;
--            rsttb <= '0';
--            instb <= "001";
--            wait for 100ns;
            
--            clktb <= not clktb;
--            rsttb <= '0';
--            wait for 100ns;
--        end loop;
        
--        report "Test left motion!";
--        clktb <= not clktb;
--        rsttb <= '0';
--        instb <= "010";
--        wait for 100ns;
        
--        clktb <= not clktb;
--        rsttb <= '0';
--        wait for 100ns;
        
--        for i in 0 to 3 loop
--            clktb <= not clktb;
--            rsttb <= '0';
--            instb <= "001";
--            wait for 100ns;
            
--            clktb <= not clktb;
--            rsttb <= '0';
--            wait for 100ns;
--        end loop;
        
--        report "Test down motion!";
--        clktb <= not clktb;
--        rsttb <= '0';
--        instb <= "101";
--        wait for 100ns;
        
--        clktb <= not clktb;
--        rsttb <= '0';
--        wait for 100ns;
        
--        for i in 0 to 3 loop
--            clktb <= not clktb;
--            rsttb <= '0';
--            instb <= "001";
--            wait for 100ns;
            
--            clktb <= not clktb;
--            rsttb <= '0';
--            wait for 100ns;
--        end loop;
        
        report "end";
        
    end process;

end Behavioral;
