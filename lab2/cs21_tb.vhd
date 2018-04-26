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

ENTITY cs21_tb IS
END ENTITY cs21_tb;

--
ARCHITECTURE arch OF cs21_tb IS
  component cs21 is
    port(
      PD_in : IN std_logic_vector (0 to 7);
      rst : IN std_logic;
      clk : IN std_logic;
      result : OUT std_logic_vector (0 to 7)
    );
  end component;
  
  constant tbperiod : time := 100 ns;
  signal tbPD_in : std_logic_vector (0 to 7);
  signal tbrst : std_logic;
  signal tbclk : std_logic;
  signal tbresult : std_logic_vector (0 to 7);
  
  type answers is array (0 to 4) of std_logic_vector (0  to 7);
  
BEGIN
  tbcs21 : cs21 port map (PD_in=>tbPD_in, rst=>tbrst, clk=>tbclk, result=>tbresult);
  
  stimuli : process
    variable ans : answers := ("00000010", "00100000", "10101100", "10011000", "11110100");
    variable inp : answers := ("00000001", "00010000", "01010110", "11001100", "11111010");
    
  begin
      
      tbPD_in <= (others => '0');
      tbrst <= '1';
      tbclk <= '0';
      wait for tbperiod;
      
      for i in 0 to 4 loop
          tbrst <= '0';
          tbclk <= not tbclk;
          tbPD_in <= inp(i);
          wait for tbperiod;
          
          tbclk <= not tbclk;
          wait for tbperiod;
          
          assert (tbresult = ans(i)) report "Not the result expected";
      end loop;
      
  end process;
  
END ARCHITECTURE arch;

