--
-- VHDL Architecture elech505_lab1_lib.cc13_tb.arch
--
-- Created:
--          by - Denis Hoornaert
--          at - 12:19:39 29/03/2018
--
-- using Mentor Graphics HDL Designer(TM) 2013.1b (Build 2)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY cc13_tb IS
END ENTITY cc13_tb;

--
ARCHITECTURE arch OF cc13_tb IS
    component cc13 port(
      binary : IN std_logic_vector (0 to 2);
      gray : OUT std_logic_vector (0 to 2)
    );
    end component;
  
    constant tbperiod : time := 100 ns;
    signal tbbinary : std_logic_vector (0 to 2);
    signal tbgray : std_logic_vector (0 to 2);
    
    type answers is array (0 to 7) of std_logic_vector(0 to 2);
  
BEGIN
    tbcc13 : cc13 port map (binary=>tbbinary, gray=>tbgray);
    
    stimuli : process
    variable counter : integer := 0;
    variable ans : answers := ("000", "001", "011", "010", "110", "111", "101", "100");
    
    begin
      for a in std_logic range '0' to '1' loop
        for b in std_logic range '0' to '1' loop
          for c in std_logic range '0' to '1' loop
            tbbinary <= a&b&c;
            wait for tbperiod;
            assert (tbgray = ans(counter)) report "Computed answer differs from the one expected";
            counter := counter+1;
          end loop;
        end loop;
      end loop;
      counter := 0;
    end process;
END ARCHITECTURE arch;

