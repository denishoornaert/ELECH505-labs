--
-- VHDL Architecture elech505_lab1_lib.cc12_tb.arch
--
-- Created:
--          by - Denis Hoornaert
--          at - 11:22:44 29/03/2018
--
-- using Mentor Graphics HDL Designer(TM) 2013.1b (Build 2)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY cc12_tb IS
END cc12_tb;

--
ARCHITECTURE arch OF cc12_tb IS
    component cc12 port (
      a : IN std_logic;
      b : IN std_logic;
      c : IN std_logic;
      d : IN std_logic;
      e : IN std_logic;
      o1 : OUT std_logic;
      o2 : OUT std_logic;
      o3 : OUT std_logic
    );
    end component;
    
    constant tbperiod : time := 100 ns;
    signal tba : std_logic;
    signal tbb : std_logic;
    signal tbc : std_logic;
    signal tbd : std_logic;
    signal tbe : std_logic;
    signal tbo1 : std_logic;
    signal tbo2 : std_logic;
    signal tbo3 : std_logic;
    
    type triplet is array (0 to 2) of std_logic;
    type answers is array (0 to 31) of triplet;
    
BEGIN
    tbcc12 : cc12 port map (a=>tba, b=>tbb, c=>tbc, d=>tbd, e=>tbe, o1=>tbo1, o2=>tbo2, o3=>tbo3);
      
    stimuli : process
    variable counter : integer := 0;
    -- The following answers have been obtained by using python
    variable ans : answers := (("000"), ("001"), ("010"), ("011"), ("100"), ("101"), ("110"), ("111"), ("000"), ("001"), ("010"), ("011"), ("100"), ("101"), ("110"), ("111"), ("000"), ("000"), ("000"), ("000"), ("000"), ("000"), ("000"), ("000"), ("111"), ("111"), ("111"), ("111"), ("111"), ("111"), ("111"), ("111"));
    
    begin
      for loopa in std_logic range '0' to '1' loop
        tba <= loopa;
        for loopb in std_logic range '0' to '1' loop
          tbb <= loopb;
          for loopc in std_logic range '0' to '1' loop
            tbc <= loopc;
            for loopd in std_logic range '0' to '1' loop
              tbd <= loopd;
              for loope in std_logic range '0' to '1' loop
                tbe <= loope;
                wait for tbperiod;
                assert ((tbo1 = ans(counter)(0)) and (tbo2 = ans(counter)(1)) and (tbo3 = ans(counter)(2))) report "Computed answer differs from the one expected";
                counter := counter+1;
              end loop;
            end loop;
          end loop;
        end loop;
      end loop;
      counter := 0;
    end process;
END ARCHITECTURE arch;

