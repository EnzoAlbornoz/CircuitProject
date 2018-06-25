library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_Unsigned.all;
use IEEE.Std_Logic_Arith.all;

entity ValidAnswer is 
	port (
			toVerify 		: in std_logic_vector(9 downto 0);
			isValid			: out std_logic
			);
end ValidAnswer;

architecture circuit of ValidAnswer is
	signal check: std_logic_vector(3 downto 0);
	begin
		process(toVerify)
			begin
				for i in 9 downto 0 loop
					if(toVerify(i) = '1') then
						check <= check + 1;
					end if;
					
					if (check = "0100") then
						isValid <= '1';
					else	
						isValid <= '0';
					end if;
				end loop;
			end process;
end circuit;		
