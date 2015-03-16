LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


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
		victory		: OUT STD_LOGIC
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

variable i			: integer range 0 to 128 :=0;

BEGIN
	WAIT UNTIL(clk'EVENT) AND (clk = '1');
		
	IF (bootstrap='1') 
	THEN	-- reset
		gameO :='0'; 
		youWin:='0';
		
		northBorder <= upBorder;
		southBorder <= downBorder;
		westBorder <= leftBorder;
		eastBorder <= rightBorder;
	ELSE
		gameO := '1';
	END IF;
	
	-- segnali in uscita
	gameover<= gameO;
	victory	<= youWin;
	
END PROCESS;
END behavior;