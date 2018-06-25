library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_Unsigned.all;
use IEEE.Std_Logic_Arith.all;

entity HexDisplay is
	port (
			enableHEX : in  std_logic;
			in_Number : in  std_logic_vector(3 downto 0);
			outNumber : out std_logic_vector(6 downto 0)
			);
end HexDisplay;

architecture Circuit of HexDisplay is
	
	constant OFF 			: std_logic_vector(6 downto 0) := "1111111";
	signal virtualSignal : std_logic_vector(6 downto 0);
	
	begin
		virtualSignal	<= 
			"1000000" when in_Number = "0000" else
			"1111001" when in_Number = "0001" else
			"0100100" when in_Number = "0010" else
			"0110000" when in_Number = "0011" else
			"0011001" when in_Number = "0100" else
			"0010010" when in_Number = "0101" else
			"0000010" when in_Number = "0110" else
			"1111000" when in_Number = "0111" else
			"0000000" when in_Number = "1000" else
			"0001100" when in_Number = "1001" else
			"0001000" when in_Number = "1010" else
			--SPECIALS-CHARACTERS-----------------
			"0101111" when in_Number = "1110" else -- > r letter
			"0000111" when in_Number = "1111"; 		-- > t letter
		outNumber	<=	
			virtualSignal when enableHEX = '1' else
			OFF;
end Circuit;