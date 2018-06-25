library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_Unsigned.all;
use IEEE.Std_Logic_Arith.all;

----------------------------------------------------
entity Timer is
	port (
			--INPUT------------------------------------
			ResetCounter: in std_logic;
			EnableCount : in std_logic;
			--OUTPUT-----------------------------------
			endTime : out std_logic;
			outNumber : out std_logic_vector(2 downto 0);
			--CLOCK------------------------------------
			CLOCK : in std_logic
			);
end Timer;

architecture Circuit of Timer is 
	signal virtualCLock	: std_logic := '0';
	signal internalClock : std_logic;
	signal internalCount : std_logic_vector(2 downto 0);
	
	component To1HzConverter is
		port(
			CLOCK_50Mhz : in std_logic;
			CLOCK_1Hz	: out std_logic
			);
	end component;
	
	begin
		virtualCLock <= CLOCK;
		
		CLOCK_GENERATOR : To1HzConverter port map(virtualCLock,InternalClock);
		
		process(internalClock,ResetCounter,EnableCount)
		begin
			if(ResetCounter = '1') then
				outNumber <= "101";
				internalCount <= "101";
				endTime <= '0';
			end if;
			if(EnableCount = '1') then
				if(InternalClock'event and InternalClock = '1') then
					if(internalCount = "000") then
							endTime <= '1';
					else
							outNumber 	  <= internalCount - 1;
							internalCount <= internalCount - 1;
					end if;
				end if;
			end if;			
	end process;
end Circuit;