library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_Unsigned.all;
use IEEE.Std_Logic_Arith.all;

entity RoundCounter is
	port (
			resetCounter	: in std_logic;
			nextRound 		: in std_logic;
			endRound			: out std_logic;
			roundNumber		: out std_logic_vector(3 downto 0));
end RoundCounter;

architecture Circuit of RoundCounter is

	signal internalNumber : std_logic_vector(3 downto 0);
	
	begin
		process(nextRound,resetCounter)
			begin
				if(resetCounter = '1') then
					endRound <= '0';
					internalNumber <= "0000";
				elsif(internalNumber = "1010") then
					endRound <= '1';
					else
						internalNumber <= internalNumber + 1;
				end if;
		end process;
		
		roundNumber <= internalNumber;
end Circuit;