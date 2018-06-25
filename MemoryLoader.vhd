library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_Unsigned.all;
use IEEE.Std_Logic_Arith.all;

entity MemoryLoader is
	port (
			loader_enable	: in	std_logic;
			showInLedR		: in	std_logic;
			memory_Address : in	std_logic_vector(3 downto 0);
			memory_Data		: out std_logic_vector(9 downto 0)
			);
end MemoryLoader;

architecture Circuit of MemoryLoader is
	
	variable virtual_Memory : std_logic_vector(9 downto 0) := "0000000000";
	variable variable_Memory : std_logic_vector(9 downto 0) := "0000000000";
	
	component ROM is
		port (
				address 	: in 	std_logic_vector(3 downto 0);
				data 		: out std_logic_vector(9 downto 0)
				);
	end component;
	
	begin
	
		process(loader_enable)
			begin
				if(loader_enable = '1') then
					virtual_Memory := variable_Memory;
				end if;
		end process;
		
		memory_Data <= virtual_Memory;
		
		ROM_GETTER : ROM port map (memory_Address,variable_Memory);
		
		process(showInLedR)
			begin
				if(showInLedR = '1') then
					
				else
					
				end if;
		end process;
		
end Circuit;