----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2018 10:14:45 AM
-- Design Name: 
-- Module Name: rand_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rand is
    Port (
        iclk : IN std_logic;
        irst : IN std_logic;
        ires : OUT std_logic_vector (0 to 2)
    );
end rand;

architecture arch of rand is
    component lsfr_bit is
        port(
            rst      : in  std_logic;
            clk      : in  std_logic;
            seed     : in  std_logic_vector(0 to 3);
            rbit_out : out std_logic
        );
    end component;
    
    signal internalres : std_logic;
    signal internalrst : std_logic;
    signal internalclk : std_logic;
    signal internalseed: std_logic_vector(0 to 3);

begin
    ilsfr : lsfr_bit port map(clk=>internalclk, rst=>internalrst, seed=>internalseed, rbit_out=>internalres);

    process (iclk, irst)
    begin
        internalclk <= iclk;
        internalrst <= irst;
        if(irst = '1') then
            internalres <= '0';
            internalseed <= (others => '0');
        elsif(rising_edge(iclk)) then
            if(internalres = '0') then
                ires <= "100";
            else
                ires <= "010";
            end if;
        end if;
    end process;

end arch;
