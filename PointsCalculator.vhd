library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_Unsigned.all;
use IEEE.Std_Logic_Arith.all;

entity PointsCalculator is
	port (
			--INPUT----------------------------------
			isCorrectAnswer 	: in  std_logic;
			roundsNumber		: in  std_logic_vector(3 downto 0);
			--OUTPUT---------------------------------
			pointsHEX0: out std_logic_vector(3 downto 0);
			pointsHEX1: out std_logic_vector(3 downto 0)
			);
end PointsCalculator;

architecture Circuit of PointsCalculator is
	--"VARIÁVEIS"---------------------------------
	signal   actualPoints  	: unsigned(4 downto 0);
	signal	isCA			  	: unsigned;
	signal	roundCounter	: unsigned(4 downto 0);
	--CONSTANTES----------------------------------
	constant ten 				: unsigned := "01010";
	constant twenty 			: unsigned := "10100";
	----------------------------------------------
	begin
		process(isCorrectAnswer)
			begin
				--------------------------------------
				if(isCorrectAnswer = '1') then
					isCa <= "1";
				else
					isCA <= "0";
				end if;
				--------------------------------------
				if(isCorrectAnswer = '1') then
					-----------------------------------
					actualPoints <= (("01000" * isCA) + ("01010" - unsigned(roundCounter)));
					--DESCRIÇÃO-DAS-PRóXIMAS-LINHAS----
					---O programa verifica o valor  ---
					---de actualPoints:				  ---
					---|Se for menor que 10;		  ---
					---|Se for entre 10 e 20;		  ---
					---|Se for maior que 20;		  ---
					---E formata para enviar ao HEX ---
					-----------------------------------
					if (actualPoints < ten) then
						--------------------------------
						pointsHEX0 <= std_logic_vector(actualPoints(3 downto 0));
						pointsHEX1 <= "00000";
						--------------------------------
					elsif (actualPoints < twenty) then
						--------------------------------
						pointsHEX0 <= actualPoints - ten;
						pointsHEX1 <= "00001";
						--------------------------------
					else
						-------------------------------- 
						pointsHEX0 <= actualPoints - twenty;
						pointsHEX1 <= "00010";
						--------------------------------
					end if;
				end if;
		end process;
end Circuit;
	