--
-- VHDL Architecture elech505_lab2_lib.cs21_tb.arch
--
-- Created:
--          by - Labo.UNKNOWN (PC-000)
--          at - 09:58:23 19/04/2018
--
-- using Mentor Graphics HDL Designer(TM) 2013.1b (Build 2)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY cs21_tb IS
END ENTITY cs21_tb;

--
ARCHITECTURE arch OF cs21_tb IS
  component cs21 is
    port(
        PD_in : IN std_logic_vector (0 to 7);
        P_in : IN std_logic;
        SD_in : IN std_logic;
        rst : IN std_logic;
        clk : IN std_logic;
        result : OUT std_logic
    );
  end component;
  
  constant tbperiod : time := 100 ns;
  signal tbPD_in : std_logic_vector (0 to 7);
  signal tbP_in : std_logic;
  signal tbSD_in : std_logic;
  signal tbrst : std_logic;
  signal tbclk : std_logic;
  signal tbresult : std_logic;
  
BEGIN
  tbcs21 : cs21 port map (PD_in=>tbPD_in, P_in=>tbP_in, SD_in=>tbSD_in, rst=>tbrst, clk=>tbclk, result=>tbresult);
  
  stimuli : process
    variable ans : std_logic_vector(0 to 7) := "01101001";
    
  begin
      
    report "TEST parallel load";
    
    tbrst <= '1';
    tbclk <= '0';
    wait for tbperiod;
    
    for i in 0 to 8 loop
        tbrst <= '0';
        
        if(i = 0) then
            tbPD_in <= ans;
            tbP_in <= '1';
        else
            tbP_in <= '0';
            tbSD_in <= '0'; -- fill with zeros (decided arbitraly)
        end if;
        
        tbclk <= not tbclk;
        wait for tbperiod;
        
        if(i /= 0) then
            assert (tbresult = ans(i-1)) report "Not the result expected";
        end if;
        
        tbclk <= not tbclk;
        wait for tbperiod;
    end loop;
    
    report "TEST serial input";
    
    tbPD_in <= (others => '0');
    tbP_in <= '0';
    
    tbrst <= '1';
    tbclk <= '0';
    wait for tbperiod;
    
    -- values are inserted one by one
    for i in 0 to 7 loop
        tbrst <= '0';
        tbSD_in <= ans(i);
        tbclk <= not tbclk;
        wait for tbperiod;
        
        tbclk <= not tbclk;
        wait for tbperiod;
    end loop;
    
    -- output values are got one after the other
    for i in 0 to 7 loop
        tbP_in <= '0';
        tbSD_in <= '0'; -- fill with zeros (decided arbitraly)
        tbclk <= not tbclk;
        wait for tbperiod;
        
        tbclk <= not tbclk;
        wait for tbperiod;
        
        assert (tbresult = ans(i)) report "Not the result expected";
    end loop;
      
  end process;
  
END ARCHITECTURE arch;

