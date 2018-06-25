library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_Unsigned.all;
use IEEE.Std_Logic_Arith.all;

entity Control is
	port( --DATAPATH-OUT----------
			R1 : out std_logic;		  -- 
			R2 : out std_logic;		  -- 
			E1 : out std_logic;		  -- 
			E2 : out std_logic;		  -- 
			E3 : out std_logic;		  -- 
			E4 : out std_logic;		  -- 
			E5 : out std_logic;		  -- 
			--DATAPATH-IN-----------	
			sw_error  : in std_logic; -- If the player doesn't put 4 x "1";
			end_game  :	in std_logic; -- If 
			end_time  :	in std_logic; -- If
			end_round :	in std_logic; -- If
			--BUTTONS---------------
			reset  : in  std_logic;   -- BTN0
			enter  : in  std_logic;	  -- BTN1
			--CLOCK-----------------
			CLOCK : in  std_logic
			);
			
end Control;

architecture ControlCircuit of Control is
	--STATE-TYPE---------------------------------------------
	type STATES is (Start,Setup,Play,Check,Result,NextRound);
	signal ActualS,NextS : STATES;
	--PROCESSES----------------------------------------------
	begin 
		process(CLOCK,reset)
			begin
				if(reset = '0') then
					ActualS <= Start;
				elsif(CLOCK'event and CLOCK = '1') then
					ActualS <= NextS;
				end if;
		end process;
		
		process(ActualS)
			begin
				case ActualS is
					when Start     =>
						--OUTPUT-SIGNALS--
						R1 <= '1';
						R2 <= '1';
						E1 <= '0';
						E2 <= '0';
						E3 <= '0';
						E4 <= '0';
						E5 <= '0';
						--STATE-CHANGE----
						if(enter = '1') then
							nextS <= Start;
						else
							nextS <= Setup;
						end if;
						------------------
					when Setup     =>
						--OUTPUT-SIGNALS--
						R1 <= '0';
						R2 <= '0';
						E1 <= '0';
						E2 <= '1';
						E3 <= '0';
						E4 <= '0';
						E5 <= '0';
						--STATE-CHANGE----
						if(enter = '1') then
							nextS <= Setup;
						else
							nextS <= Play;
						end if;
						------------------
					when Play      =>
						--OUTPUT-SIGNALS--
						R1 <= '0';
						R2 <= '0';
						E1 <= '1';
						E2 <= '0';
						E3 <= '0';
						E4 <= '0';
						E5 <= '0';
						--STATE-CHANGE----
						if(end_time = '1') then
							nextS <= Result;
						elsif(enter = '1') then
								nextS <= Play;
							else
								nextS <= Check;
						end if;
						------------------
					when Check     =>
						--OUTPUT-SIGNALS--
						R1 <= '0';
						R2 <= '0';
						E1 <= '0';
						E2 <= '0';
						E3 <= '1';
						E4 <= '0';
						E5 <= '0';
						--STATE-CHANGE----
						if(end_round = '1' or sw_error = '1' or end_game = '1') then
							nextS <= Result;
						else
							nextS <= NextRound;
						end if;
						------------------
					when Result    =>
						--OUTPUT-SIGNALS--
						R1 <= '0';
						R2 <= '0';
						E1 <= '0';
						E2 <= '0';
						E3 <= '0';
						E4 <= '1';
						E5 <= '1';
						--STATE-CHANGE----
						if(enter = '1') then
							nextS <= Result;
						else
							nextS <= Start;
						end if;
						------------------
					when NextRound =>
						--OUTPUT-SIGNALS--
						R1 <= '1';
						R2 <= '0';
						E1 <= '0';
						E2 <= '0';
						E3 <= '0';
						E4 <= '1';
						E5 <= '0';
						--STATE-CHANGE----
						if(enter = '1') then
							nextS <= NextRound;
						else
							nextS <= Play;
						end if;
						------------------
				end case;
		end process;
		
	end ControlCircuit;