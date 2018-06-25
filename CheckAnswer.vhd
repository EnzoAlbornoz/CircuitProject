library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_Unsigned.all;
use IEEE.Std_Logic_Arith.all;

entity CheckAnswer is
	port (
			--INPUT----------------------------------
			usr_answer    	:  in  std_logic_vector(9 downto 0);
			memory_answer 	:  in  std_logic_vector(9 downto 0);
			--OUTPUT---------------------------------
			sw_erro			:	out std_logic;
			end_game			:	out std_logic
			);
end CheckAnswer;

architecture Circuit of CheckAnswer is
	signal validedAnswer : std_logic;
	
	component ValidAnswer is
		port (
				toVerify 		: in std_logic_vector(9 downto 0);
				isValid			: out std_logic
				);
	end component;
	
	begin
		AnswerValider : ValidAnswer port map (usr_answer,validedAnswer);
		process(validedAnswer)
			begin
				if (validedAnswer = '1') then
				sw_erro <= '0';
				if(usr_answer = memory_answer) then
					end_game <= '1';
				else
					end_game <= '0';
				end if;
			else
				sw_erro <= '1';
			end if;
		end process;
end Circuit;