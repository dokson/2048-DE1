LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY GAME_DATA IS
PORT
	(   
		-- INPUT
		clk		: IN STD_LOGIC;
		
		enable: IN STD_LOGIC;
		bootstrap: IN STD_LOGIC;

		-- OUTPUT
		northBorder: OUT INTEGER range 0 to 500;
		southBorder: OUT INTEGER range 0 to 500;
		westBorder: OUT INTEGER range 0 to 1000;
		eastBorder: OUT INTEGER range 0 to 1000;
		
		goingReady: OUT STD_LOGIC;
		gameover: OUT STD_LOGIC;
		victory: OUT STD_LOGIC
	);
end  GAME_DATA;

ARCHITECTURE behavior of  GAME_DATA IS

BEGIN
	
PROCESS
variable cntScrittaLampeggiante: integer range 0 to 16000000;
variable scrittaLampeggia: STD_LOGIC;

-- bordo schermo
constant leftBorder:integer  range 0 to 1000:=15;
constant rightBorder:integer  range 0 to 1000:=625;
constant upBorder: integer  range 0 to 500:=44;	
constant downBorder: integer  range 0 to 500:= 474;

variable gameO: STD_LOGIC :='0';
variable youWin: STD_LOGIC:='0';

variable i: integer range 0 to 128:=0;

BEGIN
WAIT UNTIL(clk'EVENT) AND (clk = '1');

		IF(cntScrittaLampeggiante = 10000000)THEN	
				cntScrittaLampeggiante := 0;
				scrittaLampeggia :=NOT scrittaLampeggia;
				
			ELSE	
				cntScrittaLampeggiante := cntScrittaLampeggiante  + 1;
				
		END IF;
		
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
		gameover <=gameO;
		victory <=youWin;
	
END PROCESS;
END behavior;