library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_Unsigned.all;
use IEEE.Std_Logic_Arith.all;

----------------------------------------------------
entity Datapath is
	port (	
				--INPUT---------------------------------
				R1	: in std_logic;
				R2	: in std_logic;
				E1	: in std_logic;
				E2	: in std_logic;
				E3	: in std_logic;
				E4	: in std_logic;
				E5	: in std_logic;
				SW : in std_logic_vector(9 downto 0);
				--OUTPUT--------------------------------
				sw_erro 		: out std_logic;
				end_game		: out std_logic;
				end_time		: out std_logic;
				end_round	: out std_logic;
				--CLOCK---------------------------------
				CLOCK : in std_logic;
				--DISPLAYERS(HEX-LEDR)------------------
				HEX0 : out std_logic_vector(6 downto 0);
				HEX1 : out std_logic_vector(6 downto 0);
				HEX2 : out std_logic_vector(6 downto 0);
				HEX3 : out std_logic_vector(6 downto 0);
				HEX4 : out std_logic_vector(6 downto 0);
				HEX5 : out std_logic_vector(6 downto 0);
				LEDR : out std_logic_vector(9 downto 0)
				);
end Datapath;

architecture Circuit of Datapath is
	signal memory_data : std_logic_vector(9 downto 0);
	signal timerToHEX	 : std_logic_vector(2 downto 0);
	signal roundToHEX	 : std_logic_vector(3 downto 0);
	
	component Timer is
		port (
			--INPUT------------------------------------
			ResetCounter: in  std_logic;
			EnableCount : in  std_logic;
			--OUTPUT-----------------------------------
			endTime 		: out std_logic;
			outNumber 	: out std_logic_vector(2 downto 0);
			--CLOCK------------------------------------
			CLOCK 		: in  std_logic
			);
		end component;	
			
	component HexDisplay is
		port (
				enableHEX : in  std_logic;
				in_Number : in  std_logic_vector(3 downto 0);
				outNumber : out std_logic_vector(6 downto 0)
				);
	end component;
	
	component RoundCounter is 
		port (
				resetCounter	: in 	std_logic;
				nextRound 		: in 	std_logic;
				endRound			: out std_logic;
				roundNumber		: out std_logic_vector(3 downto 0)
				);
	end component;
	
	component MemoryLoader is
		port ( 
				loader_enable	: in	std_logic;
				memory_Address : in	std_logic_vector(3 downto 0);
				memory_Data		: out std_logic_vector(9 downto 0)
				);
	end component;
	
	component CheckAnswer is
		port (
				--INPUT----------------------------------
				usr_answer    		:  in  std_logic_vector(9 downto 0);
				memory_answer 		:  in  std_logic_vector(9 downto 0);
				CLOCK					: 	in  std_logic;
				--OUTPUT---------------------------------
				sw_erro				:	out std_logic;
				end_game				:	out std_logic
				);
	end component;
	
	component PointsCalculator is
		port (
				--INPUT----------------------------------
				isCorrectAnswer 	: in  std_logic;
				roundsNumber		: in  std_logic_vector(3 downto 0);
				end_game 			: in 	std_logic;
				--OUTPUT---------------------------------
				pointsHEX0			: out std_logic_vector(3 downto 0);
				pointsHEX1			: out std_logic_vector(3 downto 0)
				);
end component;

	begin
		--PORT-MAPS---------------------------------
		---MEMORY-------------------------
		memory_import 	: MemoryLoader port map (E2,SW(9 downto 6),memory_data); 
		---TIMER--------------------------
		timer_clock		: Timer 		 	port map (R1,E1,end_game,timerToHEX,CLOCK);
		timer_display	: HexDisplay	port map (E1,timerToHEX,HEX2);
		t_display		: HexDisplay 	port map ('1',"1111",HEX3);
		---ROUND--------------------------
		round_counter	: RoundCounter port map (R2,E3,end_round,roundToHEX);
		round_display	: HexDisplay	port map (E3,roundToHEX,HEX4);
		r_display		: HexDisplay 	port map('1',"1110",HEX5);
		---RESULT-POINTS------------------
		
end circuit;
	