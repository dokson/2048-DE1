LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_MISC.ALL;
USE WORK.GAME_TYPES.ALL;
USE WORK.GAME_UTILS.ALL;
USE WORK.GAME_LOGIC.ALL;

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

signal box_values_curr_status : GAME_GRID := (others => (others => 0));
signal box_values_next_status : GAME_GRID := (others => (others => 0));
signal curr_score	: INTEGER RANGE 0 to 9999 := 0;
signal next_score	: INTEGER RANGE 0 to 9999 := 0;
signal gameO		: STD_LOGIC := '0';
signal youWin		: STD_LOGIC := '0';
BEGIN

process(clk, bootstrap, curr_score, box_values_curr_status, gameO, youWin)
	constant score_initial_status		: INTEGER RANGE 0 to 9999 := 50;
	constant box_values_initial_status : GAME_GRID := ((2,2,2,0),(4,2,0,0),(0,0,0,0),(0,0,0,0));
	begin
			if(bootstrap = '1')
			then
				box_values_curr_status <= box_values_initial_status;
				curr_score <= score_initial_status;
				goingReady <= '1';
			elsif(clk'event and clk = '1')
			then
				box_values_curr_status <= box_values_next_status;
				curr_score <= next_score;
				gameO <= isGameOver(box_values_next_status);
				youWin <= isVictory(box_values_next_status);
				goingReady <= '1';
			end if;
			score <= curr_score;
			box_values <= box_values_curr_status;
			gameover<= gameO;
			victory	<= youWin;
	end process;
	
PROCESS (clk, box_values_curr_status, curr_score, movepadDirection, box_values_next_status)
-- bordo schermo
constant leftBorder	: integer := 15;
constant rightBorder: integer := 625;
constant upBorder	: integer := 44;	
constant downBorder	: integer := 474;

constant dirUP : std_logic_vector(3 downto 0):="1000";
constant dirDOWN : std_logic_vector(3 downto 0):="0001";
constant dirLEFT : std_logic_vector(3 downto 0):="0100";
constant dirRIGHT : std_logic_vector(3 downto 0):="0010";



variable i			: integer range 0 to 128 :=0;




BEGIN

	northBorder <= upBorder;
	southBorder <= downBorder;
	westBorder <= leftBorder;
	eastBorder <= rightBorder;
	
	box_values_next_status <= box_values_curr_status;
	next_score <= curr_score;
	
	case movepadDirection is
		when dirRIGHT =>
			box_values_next_status <= moveRight(box_values_next_status);
		when dirLEFT =>
			box_values_next_status <= moveLeft(box_values_next_status);
		when dirUP =>
			box_values_next_status <= moveUp(box_values_next_status);
		when dirDOWN =>
			box_values_next_status <= moveDown(box_values_next_status);
		when others =>
			box_values_next_status <= box_values_next_status;
	end case;
	
--	-- iniz. stato iniziale gioco, sempre uguale per regolamento
--	box_values_status(2,2) := 2;
--	box_values_status(2,3) := 4;
--	box_values_status(3,1) := 2;
--	box_values_status(3,2) := 2;
--	box_values_status(3,3) := 2;



	
	

	
	-- segnali in uscita

	
END PROCESS;
END behavior;