--
-- VHDL Architecture elech505_lab1_lib.cc11_tb.arch
--
-- Created:
--          by - Denis Hoornaert
--          at - 10:02:54 29/03/2018
--
-- using Mentor Graphics HDL Designer(TM) 2013.1b (Build 2)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY cc11_tb IS
END ENTITY cc11_tb;

--
ARCHITECTURE arch OF cc11_tb IS
    component cc11 port (
      x : IN std_logic;
      y : IN std_logic;
      z : IN std_logic;
      d : OUT std_logic
    );
    end component;
    
    constant tbperiod : time := 100 ns;
    signal tbx : std_logic;
    signal tby : std_logic;
    signal tbz : std_logic;
    signal tbd : std_logic;
    
    type answers is array (0 to 7) of std_logic;
    
BEGIN
    tbcc11 : cc11 port map (x=>tbx, y=>tby, z=>tbz, d=>tbd);
    
    stimuli : process
    variable counter : integer := 0;
    -- The following answers have been obtained by using python
    variable ans : answers := ('0', '1', '0', '1', '0', '0', '1', '1');
    
    begin
      for loopx in std_logic range '0' to '1' loop
        tbx <= loopx;
        for loopy in std_logic range '0' to '1' loop
          tby <= loopy;
          for loopz in std_logic range '0' to '1' loop
            tbz <= loopz;
            wait for tbperiod;
            assert (tbd = ans(counter)) report "Computed answer differs from the one expected";
            counter := counter+1;
          end loop;
        end loop;
      end loop;
      counter := 0;
    end process;
END ARCHITECTURE arch;

