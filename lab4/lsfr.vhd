library ieee;
use ieee.std_logic_1164.all;

 entity lsfr_bit is
   port (
     rst      : in  std_logic;
     clk      : in  std_logic;
     seed     : in  std_logic_vector(0 to 3);
     rbit_out : out std_logic
   );
 end entity;

 architecture arch of lsfr_bit is
   signal internallfsr       : std_logic_vector (3 downto 0);
   signal feedback   : std_logic;

 begin

    -- option for LFSR size 4
    feedback <= not(internallfsr(3) xor internallfsr(2));  
    
    process (clk) 
    begin
        if (rst = '1') then
            internallfsr <= seed;
        elsif (rising_edge(clk)) then
            internallfsr <= internallfsr(2 downto 0) & feedback;
        end if;
    end process;

   rbit_out <= internallfsr(3);
  
 end arch;