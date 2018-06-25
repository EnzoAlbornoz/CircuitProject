library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_Unsigned.all;
use IEEE.Std_Logic_Arith.all;

----------------------------------------------------
entity To1HzConverter is
	port(
			CLOCK_50Mhz : in std_logic;
			CLOCK_1Hz	: out std_logic
			);
end To1HzConverter;

architecture Circuit of To1HzConverter is
	begin
		process(CLOCK_50Mhz)
			variable Counter : integer := 0;
			begin
				if(CLOCK_50Mhz'event and CLOCK_50Mhz = '1') then
					if(Counter = 50000000) then
						CLOCK_1Hz <= '1';
					else
						Counter := Counter + 1;
						CLOCK_1Hz <= '0';
					end if;
				end if;
	end process;
end Circuit;