----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2018 11:20:58 PM
-- Design Name: 
-- Module Name: fsm2 - Behavioral
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
use ieee.numeric_std.ALL; 
use IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_misc.all;

entity fsm2 is
    port(
        clk   : IN std_logic;
        rst   : IN std_logic;
        ins   : IN std_logic_vector (0 to 3);
        addr  : IN std_logic_vector (0 to 3);
        vin   : IN std_logic_vector (0 to 10);
        val   : OUT std_logic;
        win   : OUT std_logic;
        empty : OUT std_logic
    );
end fsm2;

architecture arch of fsm2 is
    constant maxvalue : integer := 11; -- log2(2048) = 11
    constant sizemax  : integer := 3;
    
    type row is array (0 to sizemax) of std_logic_vector(0 to maxvalue-1);
    type matrix is array (0 to sizemax) of row;
    -- set=000, idle=001, up=010, down=011, left=100, right=101
    type vecv is array (0 to sizemax) of std_logic_vector(0 to sizemax);
    
    signal mat  : matrix;
    signal r    : std_logic_vector (0 to 1); -- 0 to log2(4)-1
    signal c    : std_logic_vector (0 to 1); -- 0 to log2(4)-1
    signal cnt  : std_logic_vector (0 to 3); -- 0 to log2(4*4)-1
    signal mode : std_logic_vector (0 to 3); -- ins
    signal zero : std_logic_vector (0 to maxvalue-1);
    signal subEmptyCheckVector : std_logic_vector(0 to sizemax);
    signal emptyCheckVector : vecv;
    signal subWinCheckVector : std_logic_vector(0 to sizemax);
    signal winCheckVector : vecv;

begin
    comparei: for i in 0 to sizemax generate
        comparej: for j in 0 to sizemax generate
            winCheckVector(i)(j) <= '1' when (mat(i)(j) = "10000000000") else '0';
            emptyCheckVector(i)(j) <= '1' when (mat(i)(j) = "00000000000") else '0';
        end generate comparej;
        subWinCheckVector(i) <= or_reduce(winCheckVector(i));
        subEmptyCheckVector(i) <= or_reduce(emptyCheckVector(i));
    end generate comparei;
    
    process (clk, rst)
    begin
        if(rst = '1') then
            mat <= (others => (others => (others => '0')));
            r <= (others => '0');
            c <= (others => '0');
            cnt <= (others => '0');
            zero <= (others => '0');
            mode <= (others => '0');
            val <= '0';
            win <= '0';
            empty <= '0';
        elsif(rising_edge(clk)) then
            if(ins /= "001") then
                mode <= ins;
                case(ins) is
                    when ("0010")|("0100") => cnt <= (others => '0');
                    when ("0011")|("0101") => cnt <= "0011"; --sizemax-1
                    when ("0110")         => cnt <= "0000";
                    when others => null;
                end case;
                r <= addr(0 to 1);
                c <= addr(2 to 3);
                val <= '0';
            else
                case(mode) is
                    when ("0000") =>
                        c <= c+'1';
                        if(c = sizemax) then
                            r <= r+'1';
                        end if;
                        mat(to_integer(unsigned(r)))(to_integer(unsigned(c))) <= vin;
                        -- go back to idle mode
                        if(cnt = ((sizemax+1)*(sizemax+1))-1) then
                            mode <= "0001";
                            cnt <= (others => '0');
                        else
                            cnt <= cnt+'1';
                        end if;
                    when ("0001") =>
                        val <= '1';
                    when ("0010") => -- left
                        for i in 0 to sizemax loop
                            if(mat(i)(to_integer(unsigned(cnt))) = zero) then
                                mat(i)(to_integer(unsigned(cnt))) <= mat(i)(to_integer(unsigned(cnt))+1);
                                mat(i)(to_integer(unsigned(cnt))+1) <= (others => '0');
                            elsif(mat(i)(to_integer(unsigned(cnt))) = mat(i)(to_integer(unsigned(cnt))+1)) then
                                mat(i)(to_integer(unsigned(cnt))) <= mat(i)(to_integer(unsigned(cnt))) + mat(i)(to_integer(unsigned(cnt))+1);
                                mat(i)(to_integer(unsigned(cnt))+1) <= (others => '0');
                            end if;
                            if(cnt = sizemax-1) then
                                mode <= "0001";
                            else
                                cnt <= cnt+'1';
                            end if;
                        end loop;
                    when ("0011") => -- right
                        for i in 0 to sizemax loop
                            if(mat(i)(to_integer(unsigned(cnt))) = zero) then
                                mat(i)(to_integer(unsigned(cnt))) <= mat(i)(to_integer(unsigned(cnt))-1);
                                mat(i)(to_integer(unsigned(cnt))-1) <= (others => '0');
                            elsif(mat(i)(to_integer(unsigned(cnt))) = mat(i)(to_integer(unsigned(cnt)))-1) then
                                mat(i)(to_integer(unsigned(cnt))) <= mat(i)(to_integer(unsigned(cnt))) + mat(i)(to_integer(unsigned(cnt))-1);
                                mat(i)(to_integer(unsigned(cnt))-1) <= (others => '0');
                            end if;
                            if(cnt = 1) then
                                mode <= "0001";
                            else
                                cnt <= cnt-'1';
                            end if;
                        end loop;
                    when ("0100") => -- up
                        for i in 0 to sizemax loop
                            if(mat(to_integer(unsigned(cnt)))(i) = zero) then
                                mat(to_integer(unsigned(cnt)))(i) <= mat(to_integer(unsigned(cnt))+1)(i);
                                mat(to_integer(unsigned(cnt))+1)(i) <= (others => '0');
                            elsif(mat(to_integer(unsigned(cnt)))(i) = mat(to_integer(unsigned(cnt))+1)(i)) then
                                mat(to_integer(unsigned(cnt)))(i) <= mat(to_integer(unsigned(cnt)))(i) + mat(to_integer(unsigned(cnt))+1)(i);
                                mat(to_integer(unsigned(cnt))+1)(i) <= (others => '0');
                            end if;
                            if(cnt = sizemax-1) then
                                mode <= "0001";
                            else
                                cnt <= cnt+'1';
                            end if;
                        end loop;
                    when ("0101") => -- down
                        for i in 0 to sizemax loop
                            if(mat(to_integer(unsigned(cnt)))(i) = zero) then
                                mat(to_integer(unsigned(cnt)))(i) <= mat(to_integer(unsigned(cnt))-1)(i);
                                mat(to_integer(unsigned(cnt))-1)(i) <= (others => '0');
                            elsif(mat(to_integer(unsigned(cnt)))(i) = mat(to_integer(unsigned(cnt))-1)(i)) then
                                mat(to_integer(unsigned(cnt)))(i) <= mat(to_integer(unsigned(cnt)))(i) + mat(to_integer(unsigned(cnt))-1)(i);
                                mat(to_integer(unsigned(cnt))-1)(i) <= (others => '0');
                            end if;
                            if(cnt = 1) then
                                mode <= "0001";
                            else
                                cnt <= cnt-'1';
                            end if;
                        end loop;
                    when ("0110") => -- set as close as possible
                        if(mat(to_integer(unsigned(r)))(to_integer(unsigned(c))) = 0) then
                            mat(to_integer(unsigned(r)))(to_integer(unsigned(c))) <= vin;
                            mode <= "0001";
                        else
                            c <= c+'1';
                            if(c = sizemax) then
                                r <= r+'1';
                            end if;
                            val <= '0';
                        end if;
                    when ("0111") =>
                        -- check if there is a 2048
                        win <= or_reduce(subWinCheckVector);
                        -- check if there is space left
                        empty <= or_reduce(subEmptyCheckVector);
                        mode <= "0001";
                    when others =>
                        null;
                end case;
            end if;
        end if;
    end process;

end arch;
