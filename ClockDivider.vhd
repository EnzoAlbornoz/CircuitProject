library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_Unsigned.all;
use IEEE.Std_Logic_Arith.all;
-------------------
-- Clock Divider --
-- 50MHz -> 01Hz --
-------------------
entity ClockDivider is
	port(	clock_in  : std_logic;
			clock_out : std_logic
			);
end ClockDivider;

architecture Circuit of ClockDivider is
	signal count : std_logic_vector(25 downto 0);
	begin			
		process(clock_in)
			begin
				if(clock_in'event and clock_in = '1') then
					if(count = "10111110101111000010000000") then
						count <= "00000000000000000000000000";
					else
						count <= count + 1;
					end if;
				end if;
		end process;
end Circuit;