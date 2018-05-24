----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2018 11:17:05 PM
-- Design Name: 
-- Module Name: controller - arch
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

entity controller is
    Port (
        clk    : IN  std_logic;
        rst    : IN  std_logic;
        userin : IN  std_logic;
        user   : IN  std_logic_vector (0 to 1); -- 0 left, 1 right, 2 up, 3 down
        ready  : OUT std_logic;
        result : OUT std_logic -- U in progress, 0 loose, 1 win
    );
end controller;

architecture arch of controller is
    -- in charge of outputing either 2 or 4
    component rand is
        port(
            iclk : IN std_logic;
            irst : IN std_logic;
            ires : OUT std_logic_vector (0 to 2)
        );
    end component;
    
    -- in charge of outputing a random number between 0 and 15 included
    component randuint is
        port(
            clk : IN std_logic;
            rst : IN std_logic;
            val : IN std_logic;
            res : OUT std_logic_vector(0 to 3)
        );
    end component;
    
    -- in charge of managing the matrix and the motions
    component fsm2 is
        port(
            clk : IN std_logic;
            rst : IN std_logic;
            ins : IN std_logic_vector (0 to 3);
            addr: IN std_logic_vector (0 to 3);
            vin : IN std_logic_vector (0 to 10);
            val : OUT std_logic;
            win : OUT std_logic;
            empty : OUT std_logic
        );
    end component;
    
    constant maxvalue : integer := 11;
    constant maxsize : integer := 3;
    
    signal internalclk : std_logic;
    signal internalrst : std_logic;
    signal integerrand : std_logic_vector (0 to 2);
    signal addressenab : std_logic;
    signal addressrand : std_logic_vector (0 to 3);
    signal instruction : std_logic_vector (0 to 3);
    signal addressfsm2 : std_logic_vector (0 to 3);
    signal valueinfsm2 : std_logic_vector (0 to maxvalue-1);
    signal outputfsm2  : std_logic;
    signal userhaswon  : std_logic;
    signal emptycaseav : std_logic;
    
    signal fill : std_logic_vector (0 to maxvalue-maxsize-1);
    signal cnt  : std_logic;
    
    -- 0 init
    -- 1 rand addr + rand case value
    -- 2 place in matrix
    -- 3 motion processing
    -- 4 check whether there is a 2048
    -- 5 loose
    -- 6 win
    signal status : std_logic_vector(0 to 2); -- contains the states

begin
    randctrl :     rand     port map(iclk=>internalclk, irst=>internalrst, ires=>integerrand);
    randuintctrl : randuint port map(clk=>internalclk, rst=>internalrst, val=>addressenab, res=>addressrand);
    fsmctrl :      fsm2     port map(clk=>internalclk, rst=>internalrst, ins=>instruction, addr=>addressfsm2, vin=>valueinfsm2, val=>outputfsm2, win=>userhaswon, empty=>emptycaseav);
    
    process (clk, rst)
    begin
        internalclk <= clk;
        internalrst <= rst;
        if(rst = '1') then
            status <= (others => '0');
            ready <= '0';
            result <= 'U';
            fill <= (others => '0');
            cnt <= '0';
        elsif(rising_edge(clk)) then
            case(status) is
                when("000") => -- init
                    internalrst <= rst;
                    status <= "001";
                when("001") => -- rand addr + val
                    addressenab <= '1';
                    -- nothing to activate in rand
                    status <= "010";
                when("010") => -- placement
                    if(cnt = '0') then
                        addressfsm2 <= addressrand;
                        valueinfsm2 <= "01000000000"; -- comment to check if win works
                        status <= "010";
                        instruction <= "0110"; --load at precise addr
                        cnt <= '1';
                    elsif(outputfsm2 = '1') then
                        status <= "011";
                        -- indicates to the player that he can play
                        ready <= '1';
                        cnt <= '0';
                    else
                        status <= "010";
                        instruction <= "0001"; --idle
                    end if;
                when("011") => -- motion processing
                    if(userin = '1') then
                        ready <= '0';
                        -- cast instruction representation
                        case(user) is
                            when("00") => instruction <= "0010"; --left
                            when("01") => instruction <= "0011"; --right
                            when("10") => instruction <= "0100"; --up
                            when("11") => instruction <= "0101"; --down
                            when others => null;
                        end case;
                    else
                        if(outputfsm2 = '1') then
                            -- go back
                            status <= "100";
                            instruction <= "0111"; --request game status (win & empty)
                        else
                            status <= "011";
                            instruction <= "0001"; --idle
                        end if;
                    end if;
                when("100") => -- game status check
                    status <= "101";
                    instruction <= "0001";
                when("101") =>
                    if(userhaswon = '1') then
                        -- there is a 2048
                        status <= "111"; -- go to win
                    else
                        if(emptycaseav = '1') then
                            -- some cases are still empty
                            status <= "001"; -- go to rand
                        else
                            -- there is neither space left or 2048
                            status <= "110";
                        end if;
                    end if;
                    --instruction <= "0001";
                when("110") => result <= '0';
                when("111") => result <= '1';
                when others => null;
            end case;
        end if;
    end process;

end arch;
