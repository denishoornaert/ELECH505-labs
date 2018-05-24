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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ppalu4bits_tb is
end ppalu4bits_tb;

architecture arch of ppalu4bits_tb is
    component ppalu4bits port(
        clk  : IN  std_logic;
        rst  : IN  std_logic;
        A    : IN  std_logic_vector (0 to 3);
        B    : IN  std_logic_vector (0 to 3);
        S    : IN  std_logic_vector (0 to 1);
        Cin  : IN  std_logic;
        M    : IN  std_logic;
        Dout : OUT std_logic_vector (0 to 3);
        Cout : OUT std_logic
    );
    end component;

    signal clktb  : std_logic;
    signal rsttb  : std_logic;
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
	 alutb : ppalu4bits port map(clk=>clktb, rst=>rsttb, A=>Atb, B=>Btb, S=>Stb, M=>Mtb, Cin=>Cintb, Dout=>Douttb, Cout=>Couttb);
    
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
	 
		report "Testing binary operators !";

		Mtb <= '0';

		report "Testing OR";

		-- set up
		rsttb <= '1';
		clktb <= '0';
		wait for 100 ns;
		clktb <= not clktb;
		wait for 100 ns;

		for i in 0 to 6 loop -- up to 7 as we need to wait 3 more clock cycles to see the last results.
			-- introduce controls
			rsttb <= '0';
			Mtb <= '0';
			Stb <= "00";
			
			-- introduce the data to process
			if(i <= 4) then -- 4 is the size of the arrays
				Atb <= inputA(i);
				Btb <= inputB(i);
			end if;
			
			-- introduce the first clock cycle
			clktb <= not clktb;
			wait for 100 ns;
			clktb <= not clktb;
			wait for 100 ns;
			
			-- check whether results are available. If yes, then compare
			if(2 <= i) then
				assert (ansOr(i-2) = Douttb) report "Issue with OR";
				assert (Couttb = CoutOr(i-2)) report "Overflow issue in OR";
			end if;
		end loop;

		report "Testing AND";

		-- set up
		rsttb <= '1';
		clktb <= '0';
		wait for 100 ns;
		clktb <= not clktb;
		wait for 100 ns;

		for i in 0 to 6 loop -- up to 7 as we need to wait 3 more clock cycles to see the last results.
			-- introduce controls
			rsttb <= '0';
			Mtb <= '0';
			Stb <= "01";
			
			-- introduce the data to process
			if(i <= 4) then -- 4 is the size of the arrays
				Atb <= inputA(i);
				Btb <= inputB(i);
			end if;
			
			-- introduce the first clock cycle
			clktb <= not clktb;
			wait for 100 ns;
			clktb <= not clktb;
			wait for 100 ns;
			
			-- check whether results are available. If yes, then compare
			if(2 <= i) then
				assert (ansAnd(i-2) = Douttb) report "Issue with AND";
				assert (Couttb = CoutAnd(i-2)) report "Overflow issue in AND";
			end if;
		end loop;
		
		report "Testing XOR";

		-- set up
		rsttb <= '1';
		clktb <= '0';
		wait for 100 ns;
		clktb <= not clktb;
		wait for 100 ns;

		for i in 0 to 6 loop -- up to 7 as we need to wait 3 more clock cycles to see the last results.
			-- introduce controls
			rsttb <= '0';
			Mtb <= '0';
			Stb <= "10";
			
			-- introduce the data to process
			if(i <= 4) then -- 4 is the size of the arrays
				Atb <= inputA(i);
				Btb <= inputB(i);
			end if;
			
			-- introduce the first clock cycle
			clktb <= not clktb;
			wait for 100 ns;
			clktb <= not clktb;
			wait for 100 ns;
			
			-- check whether results are available. If yes, then compare
			if(2 <= i) then
				assert (ansXor(i-2) = Douttb) report "Issue with XOR";
				assert (Couttb = CoutXor(i-2)) report "Overflow issue in XOR";
			end if;
		end loop;
		
		report "Testing XNOR";

		-- set up
		rsttb <= '1';
		clktb <= '0';
		wait for 100 ns;
		clktb <= not clktb;
		wait for 100 ns;

		for i in 0 to 6 loop -- up to 7 as we need to wait 3 more clock cycles to see the last results.
			-- introduce controls
			rsttb <= '0';
			Mtb <= '0';
			Stb <= "11";
			
			-- introduce the data to process
			if(i <= 4) then -- 4 is the size of the arrays
				Atb <= inputA(i);
				Btb <= inputB(i);
			end if;
			
			-- introduce the first clock cycle
			clktb <= not clktb;
			wait for 100 ns;
			clktb <= not clktb;
			wait for 100 ns;
			
			-- check whether results are available. If yes, then compare
			if(2 <= i) then
				assert (ansXnor(i-2) = Douttb) report "Issue with XNOR";
				assert (Couttb = CoutXnor(i-2)) report "Overflow issue in XNOR";
			end if;
		end loop;
		
		report "Testing arithmetic operators !";

		Mtb <= '0';

		report "Testing MOV";

		-- set up
		rsttb <= '1';
		clktb <= '0';
		wait for 100 ns;
		clktb <= not clktb;
		wait for 100 ns;

		for i in 0 to 6 loop -- up to 7 as we need to wait 3 more clock cycles to see the last results.
			-- introduce controls
			rsttb <= '0';
			Mtb <= '1';
			Stb <= "00";
			Cintb <= '0';
			
			-- introduce the data to process
			if(i <= 4) then -- 4 is the size of the arrays
				Atb <= inputA(i);
				Btb <= inputB(i);
			end if;
			
			-- introduce the first clock cycle
			clktb <= not clktb;
			wait for 100 ns;
			clktb <= not clktb;
			wait for 100 ns;
			
			-- check whether results are available. If yes, then compare
			if(2 <= i) then
				assert (ansMov(i-2) = Douttb) report "Issue with MOV";
				assert (Couttb = CoutMov(i-2)) report "Overflow issue in MOV";
			end if;
		end loop;

		report "Testing INC";

		-- set up
		rsttb <= '1';
		clktb <= '0';
		wait for 100 ns;
		clktb <= not clktb;
		wait for 100 ns;

		for i in 0 to 6 loop -- up to 7 as we need to wait 3 more clock cycles to see the last results.
			-- introduce controls
			rsttb <= '0';
			Mtb <= '1';
			Stb <= "00";
			Cintb <= '1';
			
			-- introduce the data to process
			if(i <= 4) then -- 4 is the size of the arrays
				Atb <= inputA(i);
				Btb <= inputB(i);
			end if;
			
			-- introduce the first clock cycle
			clktb <= not clktb;
			wait for 100 ns;
			clktb <= not clktb;
			wait for 100 ns;
			
			-- check whether results are available. If yes, then compare
			if(2 <= i) then
				assert (ansInc(i-2) = Douttb) report "Issue with INC";
				assert (Couttb = CoutInc(i-2)) report "Overflow issue in INC";
			end if;
		end loop;
		
		report "Testing ADD";

		-- set up
		rsttb <= '1';
		clktb <= '0';
		wait for 100 ns;
		clktb <= not clktb;
		wait for 100 ns;

		for i in 0 to 6 loop -- up to 7 as we need to wait 3 more clock cycles to see the last results.
			-- introduce controls
			rsttb <= '0';
			Mtb <= '1';
			Stb <= "01";
			Cintb <= '0';
			
			-- introduce the data to process
			if(i <= 4) then -- 4 is the size of the arrays
				Atb <= inputA(i);
				Btb <= inputB(i);
			end if;
			
			-- introduce the first clock cycle
			clktb <= not clktb;
			wait for 100 ns;
			clktb <= not clktb;
			wait for 100 ns;
			
			-- check whether results are available. If yes, then compare
			if(2 <= i) then
				assert (ansAdd(i-2) = Douttb) report "Issue with ADD";
				assert (Couttb = CoutAdd(i-2)) report "Overflow issue in ADD";
			end if;
		end loop;
		
		report "Testing ADDINC";

		-- set up
		rsttb <= '1';
		clktb <= '0';
		wait for 100 ns;
		clktb <= not clktb;
		wait for 100 ns;

		for i in 0 to 6 loop -- up to 7 as we need to wait 3 more clock cycles to see the last results.
			-- introduce controls
			rsttb <= '0';
			Mtb <= '1';
			Stb <= "01";
			Cintb <= '1';
			
			-- introduce the data to process
			if(i <= 4) then -- 4 is the size of the arrays
				Atb <= inputA(i);
				Btb <= inputB(i);
			end if;
			
			-- introduce the first clock cycle
			clktb <= not clktb;
			wait for 100 ns;
			clktb <= not clktb;
			wait for 100 ns;
			
			-- check whether results are available. If yes, then compare
			if(2 <= i) then
				assert (ansAddInc(i-2) = Douttb) report "Issue with ADDINC";
				assert (Couttb = CoutAddInc(i-2)) report "Overflow issue in ADDINC";
			end if;
		end loop;
		
		report "Testing ADDC1B";

		-- set up
		rsttb <= '1';
		clktb <= '0';
		wait for 100 ns;
		clktb <= not clktb;
		wait for 100 ns;

		for i in 0 to 6 loop -- up to 7 as we need to wait 3 more clock cycles to see the last results.
			-- introduce controls
			rsttb <= '0';
			Mtb <= '1';
			Stb <= "10";
			Cintb <= '0';
			
			-- introduce the data to process
			if(i <= 4) then -- 4 is the size of the arrays
				Atb <= inputA(i);
				Btb <= inputB(i);
			end if;
			
			-- introduce the first clock cycle
			clktb <= not clktb;
			wait for 100 ns;
			clktb <= not clktb;
			wait for 100 ns;
			
			-- check whether results are available. If yes, then compare
			if(2 <= i) then
				assert (ansAddC1B(i-2) = Douttb) report "Issue with ADDC1B";
				assert (Couttb = CoutAddC1B(i-2)) report "Overflow issue in ADDC1B";
			end if;
		end loop;

		report "Testing SUBB";

		-- set up
		rsttb <= '1';
		clktb <= '0';
		wait for 100 ns;
		clktb <= not clktb;
		wait for 100 ns;

		for i in 0 to 6 loop -- up to 7 as we need to wait 3 more clock cycles to see the last results.
			-- introduce controls
			rsttb <= '0';
			Mtb <= '1';
			Stb <= "10";
			Cintb <= '1';
			
			-- introduce the data to process
			if(i <= 4) then -- 4 is the size of the arrays
				Atb <= inputA(i);
				Btb <= inputB(i);
			end if;
			
			-- introduce the first clock cycle
			clktb <= not clktb;
			wait for 100 ns;
			clktb <= not clktb;
			wait for 100 ns;
			
			-- check whether results are available. If yes, then compare
			if(2 <= i) then
				assert (ansSubB(i-2) = Douttb) report "Issue with SUBB";
				assert (Couttb = CoutSubB(i-2)) report "Overflow issue in SUBB";
			end if;
		end loop;
		
		report "Testing ADDC1A";

		-- set up
		rsttb <= '1';
		clktb <= '0';
		wait for 100 ns;
		clktb <= not clktb;
		wait for 100 ns;

		for i in 0 to 6 loop -- up to 7 as we need to wait 3 more clock cycles to see the last results.
			-- introduce controls
			rsttb <= '0';
			Mtb <= '1';
			Stb <= "11";
			Cintb <= '0';
			
			-- introduce the data to process
			if(i <= 4) then -- 4 is the size of the arrays
				Atb <= inputA(i);
				Btb <= inputB(i);
			end if;
			
			-- introduce the first clock cycle
			clktb <= not clktb;
			wait for 100 ns;
			clktb <= not clktb;
			wait for 100 ns;
			
			-- check whether results are available. If yes, then compare
			if(2 <= i) then
				assert (ansAddC1A(i-2) = Douttb) report "Issue with ADDC1A";
				assert (Couttb = CoutAddC1A(i-2)) report "Overflow issue in ADDC1A";
			end if;
		end loop;
		
		report "Testing SUBA";

		-- set up
		rsttb <= '1';
		clktb <= '0';
		wait for 100 ns;
		clktb <= not clktb;
		wait for 100 ns;

		for i in 0 to 6 loop -- up to 7 as we need to wait 3 more clock cycles to see the last results.
			-- introduce controls
			rsttb <= '0';
			Mtb <= '1';
			Stb <= "11";
			Cintb <= '1';
			
			-- introduce the data to process
			if(i <= 4) then -- 4 is the size of the arrays
				Atb <= inputA(i);
				Btb <= inputB(i);
			end if;
			
			-- introduce the first clock cycle
			clktb <= not clktb;
			wait for 100 ns;
			clktb <= not clktb;
			wait for 100 ns;
			
			-- check whether results are available. If yes, then compare
			if(2 <= i) then
				assert (ansSubA(i-2) = Douttb) report "Issue with SUBA";
				assert (Couttb = CoutSubA(i-2)) report "Overflow issue in SUBA";
			end if;
		end loop;

	end process;
    
end architecture arch;
