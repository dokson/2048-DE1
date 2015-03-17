LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_MISC.ALL;
USE WORK.GAME_TYPES.ALL;
USE WORK.GAME_UTILS.ALL;

ENTITY GAME_DATA IS
PORT
	(   
		-- INPUT
		clk			: IN STD_LOGIC;
		
		enable		: IN STD_LOGIC;
		bootstrap	: IN STD_LOGIC;
		
		movepadDirection: IN STD_LOGIC_VECTOR(3 downto 0);

		-- OUTPUT
		northBorder	: OUT INTEGER range 0 to 500;
		southBorder	: OUT INTEGER range 0 to 500;
		westBorder	: OUT INTEGER range 0 to 1000;
		eastBorder	: OUT INTEGER range 0 to 1000;
		
		goingReady	: OUT STD_LOGIC;
		gameover	: OUT STD_LOGIC;
		victory		: OUT STD_LOGIC;
		box_values	: BUFFER GAME_GRID;
		score		: BUFFER INTEGER RANGE 0 to 9999
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




BEGIN

	WAIT UNTIL(clk'EVENT) AND (clk = '1');
	

	northBorder <= upBorder;
	southBorder <= downBorder;
	westBorder <= leftBorder;
	eastBorder <= rightBorder;
		
	IF (bootstrap='1') 
	THEN	-- reset
		
		-- iniz. stato iniziale gioco
		box_values_status := ((others=> (others=>0)));
		box_values_status(2,2) := 2;
		box_values_status(2,3) := 4;
		box_values_status(3,1) := 2;
		box_values_status(3,2) := 2;
		box_values_status(3,3) := 2;
		score <= 0;
		
		gameO := isGameOver(box_values_status); 
		youWin:= isVictory(box_values_status);
		
		gameover <= gameO;
		victory <= youWin;
	END IF;
	
	-- segnali in uscita
	gameover<= gameO;
	victory	<= youWin;
	box_values <= box_values_status;
	
END PROCESS;
END behavior;