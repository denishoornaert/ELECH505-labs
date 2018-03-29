--
-- VHDL Architecture elech505_lab1_lib.cc12.arch
--
-- Created:
--          by - Labo.UNKNOWN (PC-000)
--          at - 10:46:16 29/03/2018
--
-- using Mentor Graphics HDL Designer(TM) 2013.1b (Build 2)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY cc12 IS
    port(
      a : IN std_logic;
      b : IN std_logic;
      c : IN std_logic;
      d : IN std_logic;
      e : IN std_logic;
      o1 : OUT std_logic;
      o2 : OUT std_logic;
      o3 : OUT std_logic
    );
END ENTITY cc12;

--
ARCHITECTURE arch OF cc12 IS
    component cc11 port (
      x : IN std_logic;
      y : IN std_logic;
      z : IN std_logic;
      d : OUT std_logic
    );
    end component;
    
BEGIN
    block1 : cc11 port map (x=>a, y=>b, z=>c, d=>o1);
    block2 : cc11 port map (x=>a, y=>b, z=>d, d=>o2);
    block3 : cc11 port map (x=>a, y=>b, z=>e, d=>o3);
END ARCHITECTURE arch;

