----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2018 08:39:34 AM
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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

entity alu4bits_tb is
end alu4bits_tb;

architecture arch of alu4bits_tb is
    component alu4bits port(
        A    : IN  std_logic_vector (0 to 3);
        B    : IN  std_logic_vector (0 to 3);
        S    : IN  std_logic_vector (0 to 1);
        Cin  : IN  std_logic;
        M    : IN  std_logic;
        Dout : OUT std_logic_vector (0 to 3);
        Cout : OUT std_logic
    );
    end component;

    signal Atb    : std_logic_vector (0 to 3);
    signal Btb    : std_logic_vector (0 to 3);
    signal Stb    : std_logic_vector (0 to 1);
    signal Mtb    : std_logic;
    signal Cintb  : std_logic;
    signal Douttb : std_logic_vector (0 to 3);
    signal Couttb : std_logic;
        
    type list is array (0 to 4) of std_logic_vector (0 to 3);
    type over is array (0 to 4) of std_logic;
    
begin
    alutb : alu4bits port map(A=>Atb, B=>Btb, S=>Stb, Cin=>Cintb, M=>Mtb, Dout=>Douttb, Cout=>couttb);
    
    stimuli : process
        variable inputA   : list := ("1100", "1010", "0011", "0100", "0100");
        variable inputB   : list := ("0100", "1100", "0111", "1001", "0001");
        variable inputAC1 : list := ("0011", "0101", "1100", "1011", "1011");
        variable inputBC1 : list := ("1011", "0011", "1000", "0110", "1110");
        
        variable ansOr    : list := ("1100", "1110", "0111", "1101", "0101");
        variable ansAnd   : list := ("0100", "1000", "0011", "0000", "0000");
        variable ansXor   : list := ("1000", "0110", "0100", "1101", "0101");
        variable ansXnor  : list := ("0111", "1001", "1011", "0010", "1010");
        
        variable CoutOr    : over := ('0', '0', '0', '0', '0');
        variable CoutAnd   : over := ('0', '0', '0', '0', '0');
        variable CoutXor   : over := ('0', '0', '0', '0', '0');
        variable CoutXnor  : over := ('0', '0', '0', '0', '0');
        
        variable ansMov   : list := ("1100", "1010", "0011", "0100", "0100");
        variable ansInc   : list := ("1101", "1011", "0100", "0101", "0101");
        variable ansAdd   : list := ("0000", "0110", "1010", "1101", "0101");
        variable ansAddInc: list := ("0001", "0111", "1011", "1110", "0110");
        variable ansAddC1B: list := ("0111", "1101", "1011", "1010", "0010");
        variable ansSubB  : list := ("1000", "1110", "1100", "1011", "0011");
        variable ansAddC1A: list := ("0111", "0001", "0011", "0100", "1100");
        variable ansSubA  : list := ("1000", "0010", "0100", "0101", "1101");
        
        variable CoutMov   : over := ('0', '0', '0', '0', '0');
        variable CoutInc   : over := ('0', '0', '0', '0', '0');
        variable CoutAdd   : over := ('1', '1', '0', '0', '0');
        variable CoutAddInc: over := ('1', '1', '0', '0', '0');
        variable CoutAddC1B: over := ('1', '0', '0', '0', '1');
        variable CoutSubB  : over := ('0', '1', '1', '1', '0');
        variable CoutAddC1A: over := ('0', '1', '1', '1', '0');
        variable CoutSubA  : over := ('1', '0', '0', '0', '1');
    
    begin
        report "Testing logic opcodes !";
        
        Mtb <= '0';
        report "Testing OR";
        Stb <= "00";
        Cintb <= '0';
        for i in 0 to 4 loop
            Atb <= inputA(i);
            Btb <= inputB(i);
            wait for 16.6 ns;
            assert (Douttb = ansOr(i)) report "Issue in OR";
            assert (Couttb = CoutOr(i)) report "Overflow issue in OR";
        end loop;
        
        report "Testing AND";
        Stb <= "01";
        Cintb <= '0';
        for i in 0 to 4 loop
            Atb <= inputA(i);
            Btb <= inputB(i);
            wait for 16.6 ns;
            assert (Douttb = ansAnd(i)) report "Issue in AND";
            assert (Couttb = CoutAnd(i)) report "Overflow issue in AND";
        end loop;
        
        report "Testing XOR";
        Stb <= "10";
        Cintb <= '0';
        for i in 0 to 4 loop
            Atb <= inputA(i);
            Btb <= inputB(i);
            wait for 16.6 ns;
            assert (Douttb = ansXor(i)) report "Issue in XOR";
            assert (Couttb = CoutXor(i)) report "Overflow issue in XOR";
        end loop;
        
        report "Testing XNOR";
        Stb <= "11";
        Cintb <= '0';
        for i in 0 to 4 loop
            Atb <= inputA(i);
            Btb <= inputB(i);
            wait for 16.6 ns;
            assert (Douttb = ansXnor(i)) report "Issue in XNOR";
            assert (Couttb = CoutXnor(i)) report "Overflow issue in XNOR";
        end loop;
        
        report "Testing arithmetic opcodes !";
        
        Mtb <= '1';
        report "Testing MOV";
        Stb <= "00";
        Cintb <= '0';
        for i in 0 to 4 loop
            Atb <= inputA(i);
            Btb <= inputB(i);
            wait for 16.6 ns;
            assert (Douttb = ansMov(i)) report "Issue in MOV";
            assert (Couttb = CoutMov(i)) report "Overflow issue in MOV";
        end loop;
        
        report "Testing INC";
        Stb <= "00";
        Cintb <= '1';
        for i in 0 to 4 loop
            Atb <= inputA(i);
            Btb <= inputB(i);
            wait for 16.6 ns;
            assert (Douttb = ansInc(i)) report "Issue in INC";
            assert (Couttb = CoutInc(i)) report "Overflow issue in INC";
        end loop;
        
        report "Testing ADD";
        Stb <= "01";
        Cintb <= '0';
        for i in 0 to 4 loop
            Atb <= inputA(i);
            Btb <= inputB(i);
            wait for 16.6 ns;
            assert (Douttb = ansAdd(i)) report "Issue in ADD";
            assert (Couttb = CoutAdd(i)) report "Overflow issue in ADD";
        end loop;
        
        report "Testing ADD/INC";
        Stb <= "01";
        Cintb <= '1';
        for i in 0 to 4 loop
            Atb <= inputA(i);
            Btb <= inputB(i);
            wait for 16.6 ns;
            assert (Douttb = ansAddInc(i)) report "Issue in ADD/INC";
            assert (Couttb = CoutAddInc(i)) report "Overflow issue in ADD/INC";
        end loop;
        
        report "Testing ADDBC1";
        Stb <= "10";
        Cintb <= '0';
        for i in 0 to 4 loop
            Atb <= inputA(i);
            Btb <= inputB(i);
            wait for 16.6 ns;
            assert (Douttb = ansAddC1B(i)) report "Issue in ADDBC1";
            assert (Couttb = CoutAddC1B(i)) report "Overflow issue in ADDBC1";
        end loop;
        
        report "Testing SUBB";
        Stb <= "10";
        Cintb <= '1';
        for i in 0 to 4 loop
            Atb <= inputA(i);
            Btb <= inputB(i);
            wait for 16.6 ns;
            assert (Douttb = ansSubB(i)) report "Issue in SUBB";
            assert (Couttb = CoutSubB(i)) report "Overflow issue in SUBB";
        end loop;
        
        report "Testing ADDAC1";
        Stb <= "11";
        Cintb <= '0';
        for i in 0 to 4 loop
            Atb <= inputA(i);
            Btb <= inputB(i);
            wait for 16.6 ns;
            assert (Douttb = ansAddC1A(i)) report "Issue in ADDAC1";
            assert (Couttb = CoutAddC1A(i)) report "Overflow issue in ADDAC1";
        end loop;
        
        report "Testing SUBA";
        Stb <= "11";
        Cintb <= '1';
        for i in 0 to 4 loop
            Atb <= inputA(i);
            Btb <= inputB(i);
            wait for 16.6 ns;
            assert (Douttb = ansSubA(i)) report "Issue in SUBA";
            assert (Couttb = CoutSubA(i)) report "Overflow issue in SUBA";
        end loop;

    end process;
    
end architecture arch;
