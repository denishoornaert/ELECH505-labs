--
-- VHDL Architecture elech505_lab1_lib.cc11.arch
--
-- Created:
--          by - Denis Hoornaert
--          at - 09:53:36 29/03/2018
--
-- using Mentor Graphics HDL Designer(TM) 2013.1b (Build 2)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY cc11 IS
    port(
      x : IN std_logic;
      y : IN std_logic;
      z : IN std_logic;
      d : OUT std_logic
    );
END ENTITY cc11;

--
ARCHITECTURE arch OF cc11 IS
BEGIN
    d <= (x and y)or ((not x) and z) or (y and z);
END ARCHITECTURE arch;

