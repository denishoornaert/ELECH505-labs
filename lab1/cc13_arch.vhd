--
-- VHDL Architecture elech505_lab1_lib.cc13.arch
--
-- Created:
--          by - Labo.UNKNOWN (PC-000)
--          at - 11:01:06 29/03/2018
--
-- using Mentor Graphics HDL Designer(TM) 2013.1b (Build 2)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY cc13 IS
    port(
      binary : IN std_logic_vector (0 to 2);
      gray : OUT std_logic_vector (0 to 2)
    );
END ENTITY cc13;

--
ARCHITECTURE arch OF cc13 IS
BEGIN
    with binary select
    gray <= "000" when "000",
            "001" when "001",
            "011" when "010",
            "010" when "011",
            "110" when "100",
            "111" when "101",
            "101" when "110",
            "100" when others;
END ARCHITECTURE arch;

