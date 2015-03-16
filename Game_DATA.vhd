LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_MISC.ALL;
USE WORK.GAME_TYPES.ALL;


ENTITY GAME_DATA IS
PORT
	(   
		-- INPUT
		clk			: IN STD_LOGIC;
		
		enable		: IN STD_LOGIC;
		bootstrap	: IN STD_LOGIC;

		-- OUTPUT
		northBorder	: OUT INTEGER range 0 to 500;
		southBorder	: OUT INTEGER range 0 to 500;
		westBorder	: OUT INTEGER range 0 to 1000;
		eastBorder	: OUT INTEGER range 0 to 1000;
		
		goingReady	: OUT STD_LOGIC;
		gameover	: OUT STD_LOGIC;
		victory		: OUT STD_LOGIC;
		box_values	: BUFFER GAME_GRID
	);
end  GAME_DATA;

ARCHITECTURE behavior of GAME_DATA IS
BEGIN
	
PROCESS
-- bordo schermo
constant leftBorder	: integer := 15;
constant rightBorder: integer := 625;
constant upBorder	: integer := 44;	
constant downBorder	: integer := 474;

variable gameO		: STD_LOGIC :='0';
variable youWin		: STD_LOGIC :='0';
variable box_values_status : GAME_GRID;

variable i			: integer range 0 to 128 :=0;


-- Funz. che stabilisce se la partita è stata persa oppure no
FUNCTION isGameOver(values: GAME_GRID) RETURN std_logic IS
variable result: std_logic := '0';
variable zeroCount : integer;
BEGIN
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			if(values(i,j) = 0)
			then
				zeroCount := zeroCount +1;
			end if;
		end loop;
	end loop;
	if (zeroCount = 0)
	then
		result := '1';
	end if;
	return result;
END FUNCTION isGameOver;

--Funz. che stabilisce se la partita è terminata con la vittoria
FUNCTION isVictory(values: GAME_GRID) RETURN std_logic IS
variable result: std_logic := '0';
BEGIN
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			if(values(i,j) = 0)
			then
				result := '1';
			end if;
		end loop;
	end loop;
	return result;
END FUNCTION isVictory;

BEGIN

	WAIT UNTIL(clk'EVENT) AND (clk = '1');
		
	IF (bootstrap='1') 
	THEN	-- reset
		
		-- iniz. stato iniziale gioco, sempre uguale per regolamento
		box_values_status := ((others=> (others=>0)));
		box_values_status(2,2) := 2;
		box_values_status(2,3) := 4;
		box_values_status(3,1) := 2;
		box_values_status(3,2) := 2;
		box_values_status(3,3) := 2048;
		
		gameO := isGameOver(box_values_status); 
		youWin:= isVictory(box_values_status);
		
		northBorder <= upBorder;
		southBorder <= downBorder;
		westBorder <= leftBorder;
		eastBorder <= rightBorder;
		gameover <= gameO;
		victory <= youWin;
		box_values <= box_values_status;
	END IF;
	
	-- segnali in uscita
	gameover<= gameO;
	victory	<= youWin;
	
END PROCESS;
END behavior;