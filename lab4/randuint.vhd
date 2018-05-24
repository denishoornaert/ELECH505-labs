----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2018 09:21:27 PM
-- Design Name: 
-- Module Name: randuint - Behavioral
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

entity randuint is
    Port (
        clk : IN std_logic;
        rst : IN std_logic;
        val : IN std_logic;
        res : OUT std_logic_vector(0 to 3)
    );
end randuint;

architecture arch of randuint is
    component lsfr_bit is
        port(
            rst      : in  std_logic;
            clk      : in  std_logic;
            seed     : in  std_logic_vector(0 to 3);
            rbit_out : out std_logic
        );
    end component;
    
    constant maxsize : integer := 3;
    signal bits : std_logic_vector(0 to maxsize);
    signal iclk : std_logic;
    signal irst : std_logic;
    signal iseed: std_logic_vector(0 to 3);
    
    type list is array (0 to 3) of std_logic_vector(0 to 3);
    signal seeds : list;
    
begin
    lsfr0 : lsfr_bit port map(rst=>irst, clk=>iclk, rbit_out=>bits(0), seed=>seeds(0));
    lsfr1 : lsfr_bit port map(rst=>irst, clk=>iclk, rbit_out=>bits(1), seed=>seeds(1));
    lsfr2 : lsfr_bit port map(rst=>irst, clk=>iclk, rbit_out=>bits(2), seed=>seeds(2));
    lsfr3 : lsfr_bit port map(rst=>irst, clk=>iclk, rbit_out=>bits(3), seed=>seeds(3));
    
    process (clk, rst)
    begin
        iclk <= clk;
        irst <= rst;
        if(rst = '1') then
            bits <= (others => '0');
            res <= (others => '0');
            seeds(0) <= "0001";
            seeds(1) <= "0010";
            seeds(2) <= "0100";
            seeds(3) <= "1000";
        elsif(rising_edge(clk)) then
            if(val = '1') then
                for i in 0 to maxsize loop
                    if(bits(i) = '0') then
                        res(i) <= '0';
                    else
                        res(i) <= '1';
                    end if;
                end loop;
            end if;
        end if;
    end process;

end arch;
