--
-- VHDL Architecture elech505_lab2_lib.cs21.arch
--
-- Created:
--          by - Labo.UNKNOWN (PC-000)
--          at - 09:37:38 19/04/2018
--
-- using Mentor Graphics HDL Designer(TM) 2013.1b (Build 2)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY cs21 IS
  port(
    PD_in : IN std_logic_vector (0 to 7);
    rst : IN std_logic;
    clk : IN std_logic;
    result : OUT std_logic_vector (0 to 7)
  );
END ENTITY cs21;

--
ARCHITECTURE arch OF cs21 IS
  signal reg : std_logic_vector (0 to 7);

BEGIN

  process (rst, clk)
  begin
    if (rst = '1') then
      reg <= (others => '0');
    elsif (rising_edge(clk)) then
      reg <= PD_in;
    end if;
    result(7) <= '0';
    result(0 to 6) <= reg(1 to 7);
  end process;

END ARCHITECTURE arch;
