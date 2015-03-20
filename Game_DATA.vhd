LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_MISC.ALL;
USE IEEE.NUMERIC_STD.ALL;
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

signal box_values_curr_status : GAME_GRID := (others => (others => 0));
signal box_values_next_status : GAME_GRID := (others => (others => 0));
signal curr_score	: INTEGER RANGE 0 to 9999 := 0;
signal next_score	: INTEGER RANGE 0 to 9999 := 0;
signal gameO		: STD_LOGIC := '0';
signal youWin		: STD_LOGIC := '0';
signal randNum		: INTEGER RANGE 0 to 15;

type STATE_TYPE is(randupdate, idle, merge1, move1, merge2, move2, merge3, move3);

signal reg_state, reg_next_state : STATE_TYPE;
signal directionPosEdge : STD_LOGIC_VECTOR(3 downto 0);
signal directionPosEdge_next : STD_LOGIC_VECTOR(3 downto 0);
signal merge_reg, merge_next : STD_LOGIC_VECTOR(3 downto 0);

PROCEDURE addNumRand(signal values: IN GAME_GRID; signal position: IN INTEGER; signal result: INOUT GAME_GRID) IS
variable row : INTEGER;
variable col : INTEGER;
BEGIN
	case position is
		when 1 =>
			row := 0;
			col := 0;
		when 2 =>
			row := 0;
			col := 1;
		when 3 =>
			row := 0;
			col := 2;
		when 4 =>
			row := 0;
			col := 3;
		when 5 =>
			row := 1;
			col := 0;
		when 6 =>
			row := 1;
			col := 1;
		when 7 =>
			row := 1;
			col := 2;
		when 8 =>
			row := 1;
			col := 3;
		when 9 =>
			row := 2;
			col := 0;
		when 10 =>
			row := 2;
			col := 1;
		when 11 =>
			row := 2;
			col := 2;
		when 12 =>
			row := 2;
			col := 3;
		when 13 =>
			row := 3;
			col := 0;
		when 14 =>
			row := 3;
			col := 1;
		when 15 =>
			row := 3;
			col := 2;
		when 16 =>
			row := 3;
			col := 3;
		when others =>
			NULL;
	end case;
	if (values(row,col) = 0)
	then
		result(row,col) <= 2;
	end if;
END addNumRand;


BEGIN

RANDGEN: entity work.GAME_RANDOMGEN
	port map
	(
		clk => clk,
		random_num => randNum
	);

process(clk, bootstrap, curr_score, box_values_curr_status, gameO, youWin)
	constant score_initial_status		: INTEGER RANGE 0 to 9999 := 0;
	constant box_values_initial_status : GAME_GRID := ((2,2,2,0),(4,2,0,0),(0,0,0,0),(0,0,0,0));
	begin
			if(bootstrap = '1')
			then
				box_values_curr_status <= box_values_initial_status;
				curr_score <= score_initial_status;
				goingReady <= '1';
				directionPosEdge <= (others => '0');
				merge_reg <= (others => '0');
				reg_state <= idle;
			elsif(clk'event and clk = '1')
			then
				directionPosEdge <= directionPosEdge_next;
				box_values_curr_status <= box_values_next_status;
				curr_score <= next_score;
				reg_state <= reg_next_state;
				merge_reg <= merge_next;
				goingReady <= '0';
--				gameO <= isGameOver(box_values_next_status);
--				youWin <= isVictory(box_values_next_status);
			end if;
			score <= curr_score;
			box_values <= box_values_curr_status;
			gameover<= gameO;
			victory	<= youWin;
	end process;
	
PROCESS (box_values_curr_status, curr_score, movepadDirection, box_values_next_status, 
			randNum, reg_next_state, reg_state, gameO, youWin, directionPosEdge, merge_reg, merge_next)
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
	merge_next <= merge_reg;
	reg_next_state <= reg_state;
	directionPosEdge_next <= directionPosEdge;
	
	if (gameO = '0' and youWin = '0')
	then
	
		if(reg_state = idle) then
			merge_next <= (others => '0');
			if(unsigned(directionPosEdge) > 0) then
				reg_next_state <= merge1;
			else
				directionPosEdge_next <= movepadDirection;
			end if;
		elsif(reg_state = merge1 or reg_state = merge2 or reg_state = merge3) then
			
			--next state logic
			if(reg_state = merge1) 
			then
				reg_next_state <= move1;
			elsif(reg_state = merge2) 
			then
				reg_next_state <= move2;
			else
				reg_next_state <= move3;
			end if;
			
			case directionPosEdge is
				when dirRIGHT =>
					-- prima riga
					if(merge_reg(0) = '0')
					then
						if(box_values_curr_status(0,0) = box_values_curr_status(0,1) and  
							box_values_curr_status(0,2) = box_values_curr_status(0,3))
						then
							box_values_next_status(0,0) <= 0;
							box_values_next_status(0,1) <= 0;
							box_values_next_status(0,2) <= box_values_curr_status(0,0) + box_values_curr_status(0,1);
							box_values_next_status(0,3) <= box_values_curr_status(0,2)+box_values_curr_status(0,3);
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(0,2) + box_values_next_status(0,3);
						elsif(box_values_curr_status(0,2) = box_values_curr_status(0,3))
						then
							box_values_next_status(0,0) <= 0;
							box_values_next_status(0,1) <= box_values_curr_status(0,0);
							box_values_next_status(0,2) <= box_values_curr_status(0,1);
							box_values_next_status(0,3) <= box_values_curr_status(0,2)+box_values_curr_status(0,3);
							merge_next(0) <= '1';
							next_score <= next_score + box_values_curr_status(0,2);
						elsif(box_values_curr_status(0,1) = box_values_curr_status(0,2))
						then
							box_values_next_status(0,0) <= 0;
							box_values_next_status(0,1) <= box_values_curr_status(0,0);
							box_values_next_status(0,2) <= box_values_curr_status(0,1)+box_values_curr_status(0,2);
							box_values_next_status(0,3) <= box_values_curr_status(0,3);
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(0,2);
						elsif(box_values_curr_status(0,0) = box_values_curr_status(0,1)) 
						then
							box_values_next_status(0,0) <= 0;
							box_values_next_status(0,1) <= box_values_curr_status(0,0)+box_values_curr_status(0,1);
							box_values_next_status(0,2) <= box_values_curr_status(0,2);
							box_values_next_status(0,3) <= box_values_curr_status(0,3);
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(0,1);
						end if;
					end if;
					
					-- seconda riga
					if(merge_reg(1)='0')
					then
						if(box_values_curr_status(1,0) = box_values_curr_status(1,1) and  
							box_values_curr_status(1,2) = box_values_curr_status(1,3))
						then
							box_values_next_status(1,0) <= 0;
							box_values_next_status(1,1) <= 0;
							box_values_next_status(1,2) <= box_values_curr_status(1,0)+box_values_curr_status(1,1);
							box_values_next_status(1,3) <= box_values_curr_status(1,2)+box_values_curr_status(1,3);
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(1,2) + box_values_next_status(1,3);
						elsif(box_values_curr_status(1,2) = box_values_curr_status(1,3))
						then
							box_values_next_status(1,0) <= 0;
							box_values_next_status(1,1) <= box_values_curr_status(1,0);
							box_values_next_status(1,2) <= box_values_curr_status(1,1);
							box_values_next_status(1,3) <= box_values_curr_status(1,2)+box_values_curr_status(1,3);
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(1,3);
						elsif(box_values_curr_status(1,1) = box_values_curr_status(1,2))
						then
							box_values_next_status(1,0) <= 0;
							box_values_next_status(1,1) <= box_values_curr_status(1,0);
							box_values_next_status(1,2) <= box_values_curr_status(1,1)+box_values_curr_status(1,2);
							box_values_next_status(1,3) <= box_values_curr_status(1,3);
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(1,2);
						elsif(box_values_curr_status(1,0) = box_values_curr_status(1,1)) 
						then
							box_values_next_status(1,0) <= 0;
							box_values_next_status(1,1) <= box_values_curr_status(1,0)+box_values_curr_status(1,1);
							box_values_next_status(1,2) <= box_values_curr_status(1,2);
							box_values_next_status(1,3) <= box_values_curr_status(1,3);
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(1,1);
							next_score <= box_values_curr_status(1,0)+box_values_curr_status(1,1);
						end if;
					end if;
					
					-- terza riga
					if(merge_reg(2) = '0') 
					then
						if(box_values_curr_status(2,0) = box_values_curr_status(2,1) and  
							box_values_curr_status(2,2) = box_values_curr_status(2,3))
						then
							box_values_next_status(2,0) <= 0;
							box_values_next_status(2,1) <= 0;
							box_values_next_status(2,2) <= box_values_curr_status(2,0)+box_values_curr_status(2,1);
							box_values_next_status(2,3) <= box_values_curr_status(2,2)+box_values_curr_status(2,3);
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(2,2) + box_values_next_status(2,3);
						elsif(box_values_curr_status(2,2) = box_values_curr_status(2,3))
						then
							box_values_next_status(2,0) <= 0;
							box_values_next_status(2,1) <= box_values_curr_status(2,0);
							box_values_next_status(2,2) <= box_values_curr_status(2,1);
							box_values_next_status(2,3) <= box_values_curr_status(2,2)+box_values_curr_status(2,3);
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(2,3);
						elsif(box_values_curr_status(2,1) = box_values_curr_status(2,2))
						then
							box_values_next_status(2,0) <= 0;
							box_values_next_status(2,1) <= box_values_curr_status(2,0);
							box_values_next_status(2,2) <= box_values_curr_status(2,1)+ box_values_curr_status(2,2);
							box_values_next_status(2,3) <= box_values_curr_status(2,3);
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(2,2);
						elsif(box_values_curr_status(2,0) = box_values_curr_status(2,1)) 
						then
							box_values_next_status(2,0) <= 0;
							box_values_next_status(2,1) <= box_values_curr_status(2,0)+box_values_curr_status(2,1);
							box_values_next_status(2,2) <= box_values_curr_status(2,2);
							box_values_next_status(2,3) <= box_values_curr_status(2,3);
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(2,1);
						end if;
					end if;
					
					-- quarta riga
					if(merge_reg(3) = '0') 
					then
						if(box_values_curr_status(3,0) = box_values_curr_status(3,1) and  
							box_values_curr_status(3,2) = box_values_curr_status(3,3))
						then
							box_values_next_status(3,0) <= 0;
							box_values_next_status(3,1) <= 0;
							box_values_next_status(3,2) <= box_values_curr_status(3,0)+box_values_curr_status(3,1);
							box_values_next_status(3,3) <= box_values_curr_status(3,2)+box_values_curr_status(3,3);
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(3,2) + box_values_next_status(3,3);
						elsif(box_values_curr_status(3,2) = box_values_curr_status(3,3))
						then
							box_values_next_status(3,0) <= 0;
							box_values_next_status(3,1) <= box_values_curr_status(3,0);
							box_values_next_status(3,2) <= box_values_curr_status(3,1);
							box_values_next_status(3,3) <= box_values_curr_status(3,2)+box_values_curr_status(3,3);
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(3,3);
						elsif(box_values_curr_status(3,1) = box_values_curr_status(3,2))
						then
							box_values_next_status(3,0) <= 0;
							box_values_next_status(3,1) <= box_values_curr_status(3,0);
							box_values_next_status(3,2) <= box_values_curr_status(3,1) + box_values_curr_status(3,2);
							box_values_next_status(3,3) <= box_values_curr_status(3,3);
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(3,2);
						elsif(box_values_curr_status(3,0) = box_values_curr_status(3,1)) 
						then
							box_values_next_status(3,0) <= 0;
							box_values_next_status(3,1) <= box_values_curr_status(3,0)+box_values_curr_status(3,1);
							box_values_next_status(3,2) <= box_values_curr_status(3,2);
							box_values_next_status(3,3) <= box_values_curr_status(3,3);
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(3,1);
						end if;
					end if;
				when dirLEFT =>
					-- prima riga
					if(merge_reg(0)='0')
					then
						if(box_values_curr_status(0,0) = box_values_curr_status(0,1) and  
							box_values_curr_status(0,2) = box_values_curr_status(0,3))
						then
							box_values_next_status(0,0) <= box_values_curr_status(0,0)+box_values_curr_status(0,1);
							box_values_next_status(0,1) <= box_values_curr_status(0,2)+box_values_curr_status(0,3);
							box_values_next_status(0,2) <= 0;
							box_values_next_status(0,3) <= 0;
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(0,1) + box_values_next_status(0,0);
						elsif(box_values_curr_status(0,0) = box_values_curr_status(0,1))
						then
							box_values_next_status(0,0) <= box_values_curr_status(0,0)+box_values_curr_status(0,1);
							box_values_next_status(0,1) <= box_values_curr_status(0,2);
							box_values_next_status(0,2) <= box_values_curr_status(0,3);
							box_values_next_status(0,3) <= 0;
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(0,0);
						elsif(box_values_curr_status(0,1) = box_values_curr_status(0,2))
						then
							box_values_next_status(0,0) <= box_values_curr_status(0,0);
							box_values_next_status(0,1) <= box_values_curr_status(0,1)+box_values_curr_status(0,2);
							box_values_next_status(0,2) <= box_values_curr_status(0,3);
							box_values_next_status(0,3) <= 0;
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(0,1);
						elsif(box_values_curr_status(0,2) = box_values_curr_status(0,3)) 
						then
							box_values_next_status(0,0) <= box_values_curr_status(0,0);
							box_values_next_status(0,1) <= box_values_curr_status(0,1);
							box_values_next_status(0,2) <= box_values_curr_status(0,2)+box_values_curr_status(0,3);
							box_values_next_status(0,3) <= 0;
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(0,2);
						end if;
					end if;
					-- seconda riga
					if(merge_reg(1) = '0')
					then
						if(box_values_curr_status(1,0) = box_values_curr_status(1,1) and  
							box_values_curr_status(1,2) = box_values_curr_status(1,3))
						then
							box_values_next_status(1,0) <= box_values_curr_status(1,0)+box_values_curr_status(1,1);
							box_values_next_status(1,1) <= box_values_curr_status(1,2)+box_values_curr_status(1,3);
							box_values_next_status(1,2) <= 0;
							box_values_next_status(1,3) <= 0;
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(1,0) + box_values_next_status(1,1);
						elsif(box_values_curr_status(1,0) = box_values_curr_status(1,1))
						then
							box_values_next_status(1,0) <= box_values_curr_status(1,0)+box_values_curr_status(1,1);
							box_values_next_status(1,1) <= box_values_curr_status(1,2);
							box_values_next_status(1,2) <= box_values_curr_status(1,3);
							box_values_next_status(1,3) <= 0;
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(1,0);
						elsif(box_values_curr_status(1,1) = box_values_curr_status(1,2))
						then
							box_values_next_status(1,0) <= box_values_curr_status(1,0);
							box_values_next_status(1,1) <= box_values_curr_status(1,1)+box_values_curr_status(1,2);
							box_values_next_status(1,2) <= box_values_curr_status(1,3);
							box_values_next_status(1,3) <= 0;
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(1,1);
						elsif(box_values_curr_status(1,2) = box_values_curr_status(1,3)) 
						then
							box_values_next_status(1,0) <= box_values_curr_status(1,0);
							box_values_next_status(1,1) <= box_values_curr_status(1,1);
							box_values_next_status(1,2) <= box_values_curr_status(1,2)+box_values_curr_status(1,3);
							box_values_next_status(1,3) <= 0;
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(1,2);
						end if;
					end if;
					-- terza riga
					if(merge_reg(2) = '0')
					then
						if(box_values_curr_status(2,0) = box_values_curr_status(2,1) and  
							box_values_curr_status(2,2) = box_values_curr_status(2,3))
						then
							box_values_next_status(2,0) <= box_values_curr_status(2,0)+box_values_curr_status(2,1);
							box_values_next_status(2,1) <= box_values_curr_status(2,2)+box_values_curr_status(2,3);
							box_values_next_status(2,2) <= 0;
							box_values_next_status(2,3) <= 0;
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(2,1) + box_values_next_status(2,0);
						elsif(box_values_curr_status(2,0) = box_values_curr_status(2,1))
						then
							box_values_next_status(2,0) <= box_values_curr_status(2,0)+box_values_curr_status(2,1);
							box_values_next_status(2,1) <= box_values_curr_status(2,2);
							box_values_next_status(2,2) <= box_values_curr_status(2,3);
							box_values_next_status(2,3) <= 0;
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(2,0);
						elsif(box_values_curr_status(2,1) = box_values_curr_status(2,2))
						then
							box_values_next_status(2,0) <= box_values_curr_status(2,0);
							box_values_next_status(2,1) <= box_values_curr_status(2,1)+box_values_curr_status(2,2);
							box_values_next_status(2,2) <= box_values_curr_status(2,3);
							box_values_next_status(2,3) <= 0;
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(2,1);
						elsif(box_values_curr_status(2,2) = box_values_curr_status(2,3)) 
						then
							box_values_next_status(2,0) <= box_values_curr_status(2,0);
							box_values_next_status(2,1) <= box_values_curr_status(2,1);
							box_values_next_status(2,2) <= box_values_curr_status(2,2)+box_values_curr_status(2,3);
							box_values_next_status(2,3) <= 0;
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(2,2);
						end if;
					end if;
					-- quarta riga
					if(merge_reg(3) = '0')
					then
						if(box_values_curr_status(3,0) = box_values_curr_status(3,1) and  
							box_values_curr_status(3,2) = box_values_curr_status(3,3))
						then
							box_values_next_status(3,0) <= box_values_curr_status(3,0)+box_values_curr_status(3,1);
							box_values_next_status(3,1) <= box_values_curr_status(3,2)+box_values_curr_status(3,3);
							box_values_next_status(3,2) <= 0;
							box_values_next_status(3,3) <= 0;
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(3,0) + box_values_next_status(3,1);
						elsif(box_values_curr_status(3,0) = box_values_curr_status(3,1))
						then
							box_values_next_status(3,0) <= box_values_curr_status(3,0)+box_values_curr_status(3,1);
							box_values_next_status(3,1) <= box_values_curr_status(3,2);
							box_values_next_status(3,2) <= box_values_curr_status(3,3);
							box_values_next_status(3,3) <= 0;
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(3,0);
						elsif(box_values_curr_status(3,1) = box_values_curr_status(3,2))
						then
							box_values_next_status(3,0) <= box_values_curr_status(3,0);
							box_values_next_status(3,1) <= box_values_curr_status(3,1)+box_values_curr_status(3,2);
							box_values_next_status(3,2) <= box_values_curr_status(3,3);
							box_values_next_status(3,3) <= 0;
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(3,1);
						elsif(box_values_curr_status(3,2) = box_values_curr_status(3,3)) 
						then
							box_values_next_status(3,0) <= box_values_curr_status(3,0);
							box_values_next_status(3,1) <= box_values_curr_status(3,1);
							box_values_next_status(3,2) <= box_values_curr_status(3,2)+box_values_curr_status(3,3);
							box_values_next_status(3,3) <= 0;
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(3,2);
						end if;
					end if;
				when dirUP =>
					-- prima colonna
					if(merge_reg(0)='0')
					then
						if(box_values_curr_status(0,0) = box_values_curr_status(1,0) 
							and box_values_curr_status(2,0) = box_values_curr_status(3,0))
						then
							box_values_next_status(0,0) <= box_values_curr_status(0,0)+box_values_curr_status(1,0);
							box_values_next_status(1,0) <= box_values_curr_status(2,0)+box_values_curr_status(3,0);
							box_values_next_status(2,0) <= 0;
							box_values_next_status(3,0) <= 0;
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(1,0) + box_values_next_status(0,0);
						elsif(box_values_curr_status(0,0) = box_values_curr_status(1,0))
						then
							box_values_next_status(0,0) <= box_values_curr_status(0,0)+box_values_curr_status(1,0);
							box_values_next_status(1,0) <= box_values_curr_status(2,0);
							box_values_next_status(2,0) <= box_values_curr_status(3,0);
							box_values_next_status(3,0) <= 0;
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(0,0);
						elsif(box_values_curr_status(1,0) = box_values_curr_status(2,0))
						then
							box_values_next_status(0,0) <= box_values_curr_status(0,0);
							box_values_next_status(1,0) <= box_values_curr_status(1,0)+box_values_curr_status(2,0);
							box_values_next_status(2,0) <= box_values_curr_status(3,0);
							box_values_next_status(3,0) <= 0;
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(1,0);
						elsif(box_values_curr_status(2,0) = box_values_curr_status(3,0))
						then
							box_values_next_status(0,0) <= box_values_curr_status(0,0);
							box_values_next_status(1,0) <= box_values_curr_status(1,0);
							box_values_next_status(2,0) <= box_values_curr_status(2,0)+box_values_curr_status(3,0);
							box_values_next_status(3,0) <= 0;
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(2,0);
						end if;
					end if;
					-- seconda colonna
					if(merge_reg(1)='0')
					then
						if(box_values_curr_status(0,1) = box_values_curr_status(1,1) 
							and box_values_curr_status(2,1) = box_values_curr_status(3,1))
						then
							box_values_next_status(0,1) <= box_values_curr_status(0,1)+box_values_curr_status(1,1);
							box_values_next_status(1,1) <= box_values_curr_status(2,1)+box_values_curr_status(3,1);
							box_values_next_status(2,1) <= 0;
							box_values_next_status(3,1) <= 0;
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(0,1) + box_values_next_status(1,1);
						elsif(box_values_curr_status(0,1) = box_values_curr_status(1,1))
						then
							box_values_next_status(0,1) <= box_values_curr_status(0,1)+box_values_curr_status(1,1);
							box_values_next_status(1,1) <= box_values_curr_status(2,1);
							box_values_next_status(2,1) <= box_values_curr_status(3,1);
							box_values_next_status(3,1) <= 0;
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(0,1);
						elsif(box_values_curr_status(1,1) = box_values_curr_status(2,1))
						then
							box_values_next_status(0,1) <= box_values_curr_status(0,1);
							box_values_next_status(1,1) <= box_values_curr_status(1,1)+box_values_curr_status(2,1);
							box_values_next_status(2,1) <= box_values_curr_status(3,1);
							box_values_next_status(3,1) <= 0;
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(1,1);
						elsif(box_values_curr_status(2,1) = box_values_curr_status(3,1))
						then
							box_values_next_status(0,1) <= box_values_curr_status(0,1);
							box_values_next_status(1,1) <= box_values_curr_status(1,1);
							box_values_next_status(2,1) <= box_values_curr_status(2,1)+box_values_curr_status(3,1);
							box_values_next_status(3,1) <= 0;
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(2,1);
						end if;
					end if;
					-- terza colonna
					if(merge_reg(2)='0')
					then
						if(box_values_curr_status(0,2) = box_values_curr_status(1,2) 
							and box_values_curr_status(2,2) = box_values_curr_status(3,2))
						then
							box_values_next_status(0,2) <= box_values_curr_status(0,2)+box_values_curr_status(1,2);
							box_values_next_status(1,2) <= box_values_curr_status(2,2)+box_values_curr_status(3,2);
							box_values_next_status(2,2) <= 0;
							box_values_next_status(3,2) <= 0;
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(0,2) + box_values_next_status(1,2);
						elsif(box_values_curr_status(0,2) = box_values_curr_status(1,2))
						then
							box_values_next_status(0,2) <= box_values_curr_status(0,2)+box_values_curr_status(1,2);
							box_values_next_status(1,2) <= box_values_curr_status(2,2);
							box_values_next_status(2,2) <= box_values_curr_status(3,2);
							box_values_next_status(3,2) <= 0;
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(0,2);
						elsif(box_values_curr_status(1,2) = box_values_curr_status(2,2))
						then
							box_values_next_status(0,2) <= box_values_curr_status(0,2);
							box_values_next_status(1,2) <= box_values_curr_status(1,2)+box_values_curr_status(2,2);
							box_values_next_status(2,2) <= box_values_curr_status(3,2);
							box_values_next_status(3,2) <= 0;
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(1,2);
						elsif(box_values_curr_status(2,2) = box_values_curr_status(3,2))
						then
							box_values_next_status(0,2) <= box_values_curr_status(0,2);
							box_values_next_status(1,2) <= box_values_curr_status(1,2);
							box_values_next_status(2,2) <= box_values_curr_status(2,2)+box_values_curr_status(3,2);
							box_values_next_status(3,2) <= 0;
							next_score <= next_score + box_values_next_status(2,2);
							merge_next(2) <= '1';
						end if;
					end if;
					-- quarta colonna
					if(merge_reg(3)='0')
					then
						if(box_values_curr_status(0,3) = box_values_curr_status(1,3) 
							and box_values_curr_status(2,3) = box_values_curr_status(3,3))
						then
							box_values_next_status(0,3) <= box_values_curr_status(0,3)+box_values_curr_status(1,3);
							box_values_next_status(1,3) <= box_values_curr_status(2,3)+box_values_curr_status(3,3);
							box_values_next_status(2,3) <= 0;
							box_values_next_status(3,3) <= 0;
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(0,3) + box_values_next_status(1,3);
						elsif(box_values_curr_status(0,3) = box_values_curr_status(1,3))
						then
							box_values_next_status(0,3) <= box_values_curr_status(0,3)+box_values_curr_status(1,3);
							box_values_next_status(1,3) <= box_values_curr_status(2,3);
							box_values_next_status(2,3) <= box_values_curr_status(3,3);
							box_values_next_status(3,3) <= 0;
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(0,3);
						elsif(box_values_curr_status(1,3) = box_values_curr_status(2,3))
						then
							box_values_next_status(0,3) <= box_values_curr_status(0,3);
							box_values_next_status(1,3) <= box_values_curr_status(1,3)+box_values_curr_status(2,3);
							box_values_next_status(2,3) <= box_values_curr_status(3,3);
							box_values_next_status(3,3) <= 0;
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(1,3);
						elsif(box_values_curr_status(2,3) = box_values_curr_status(3,3))
						then
							box_values_next_status(0,3) <= box_values_curr_status(0,3);
							box_values_next_status(1,3) <= box_values_curr_status(1,3);
							box_values_next_status(2,3) <= box_values_curr_status(2,3)+box_values_curr_status(3,3);
							box_values_next_status(3,3) <= 0;
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(2,3);
						end if;
					end if;
				when dirDOWN =>
					-- prima colonna
					if(merge_reg(0)='0')
					then
						if(box_values_curr_status(0,0) = box_values_curr_status(1,0) 
							and box_values_curr_status(2,0) = box_values_curr_status(3,0))
						then
							box_values_next_status(0,0) <= 0;
							box_values_next_status(1,0) <= 0;
							box_values_next_status(2,0) <= box_values_curr_status(0,0)+box_values_curr_status(1,0);
							box_values_next_status(3,0) <= box_values_curr_status(2,0)+box_values_curr_status(3,0);
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(2,0) + box_values_next_status(3,0);
						elsif(box_values_curr_status(2,0) = box_values_curr_status(3,0))
						then
							box_values_next_status(0,0) <= 0;
							box_values_next_status(1,0) <= box_values_curr_status(0,0);
							box_values_next_status(2,0) <= box_values_curr_status(1,0);
							box_values_next_status(3,0) <= box_values_curr_status(2,0) + box_values_curr_status(3,0);
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(3,0);
						elsif(box_values_curr_status(1,0) = box_values_curr_status(2,0))
						then
							box_values_next_status(0,0) <= 0;
							box_values_next_status(1,0) <= box_values_curr_status(0,0);
							box_values_next_status(2,0) <= box_values_curr_status(1,0)+box_values_curr_status(2,0);
							box_values_next_status(3,0) <= box_values_curr_status(3,0);
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(2,0);
						elsif(box_values_curr_status(0,0) = box_values_curr_status(1,0))
						then
							box_values_next_status(0,0) <= 0;
							box_values_next_status(1,0) <= box_values_curr_status(0,0) + box_values_curr_status(1,0);
							box_values_next_status(2,0) <= box_values_curr_status(2,0);
							box_values_next_status(3,0) <= box_values_curr_status(3,0);
							merge_next(0) <= '1';
							next_score <= next_score + box_values_next_status(1,0);
						end if;
					end if;
					-- seconda colonna
					if(merge_reg(1)='0')
					then
						if(box_values_curr_status(0,1) = box_values_curr_status(1,1) 
							and box_values_curr_status(2,1) = box_values_curr_status(3,1))
						then
							box_values_next_status(0,1) <= 0;
							box_values_next_status(1,1) <= 0;
							box_values_next_status(2,1) <= box_values_curr_status(0,1)+box_values_curr_status(1,1);
							box_values_next_status(3,1) <= box_values_curr_status(2,1)+box_values_curr_status(3,1);
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(3,1) + box_values_next_status(2,1);
						elsif(box_values_curr_status(2,1) = box_values_curr_status(3,1))
						then
							box_values_next_status(0,1) <= 0;
							box_values_next_status(1,1) <= box_values_curr_status(0,1);
							box_values_next_status(2,1) <= box_values_curr_status(1,1);
							box_values_next_status(3,1) <= box_values_curr_status(2,1) + box_values_curr_status(3,1);
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(3,1);
						elsif(box_values_curr_status(1,1) = box_values_curr_status(2,1))
						then
							box_values_next_status(0,1) <= 0;
							box_values_next_status(1,1) <= box_values_curr_status(0,1);
							box_values_next_status(2,1) <= box_values_curr_status(1,1)+box_values_curr_status(2,1);
							box_values_next_status(3,1) <= box_values_curr_status(3,1);
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(2,1);
						elsif(box_values_curr_status(0,1) = box_values_curr_status(1,1))
						then
							box_values_next_status(0,1) <= 0;
							box_values_next_status(1,1) <= box_values_curr_status(0,1) + box_values_curr_status(1,1);
							box_values_next_status(2,1) <= box_values_curr_status(2,1);
							box_values_next_status(3,1) <= box_values_curr_status(3,1);
							merge_next(1) <= '1';
							next_score <= next_score + box_values_next_status(1,1);
						end if;
					end if;
					-- terza colonna
					if(merge_reg(2)='0')
					then
						if(box_values_curr_status(0,2) = box_values_curr_status(1,2) 
							and box_values_curr_status(2,2) = box_values_curr_status(3,2))
						then
							box_values_next_status(0,2) <= 0;
							box_values_next_status(1,2) <= 0;
							box_values_next_status(2,2) <= box_values_curr_status(0,2)+box_values_curr_status(1,2);
							box_values_next_status(3,2) <= box_values_curr_status(2,2)+box_values_curr_status(3,2);
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(2,2) + box_values_next_status(3,2);
						elsif(box_values_curr_status(2,2) = box_values_curr_status(3,2))
						then
							box_values_next_status(0,2) <= 0;
							box_values_next_status(1,2) <= box_values_curr_status(0,2);
							box_values_next_status(2,2) <= box_values_curr_status(1,2);
							box_values_next_status(3,2) <= box_values_curr_status(2,2) + box_values_curr_status(3,2);
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(3,2);
						elsif(box_values_curr_status(1,2) = box_values_curr_status(2,2))
						then
							box_values_next_status(0,2) <= 0;
							box_values_next_status(1,2) <= box_values_curr_status(0,2);
							box_values_next_status(2,2) <= box_values_curr_status(1,2)+box_values_curr_status(2,2);
							box_values_next_status(3,2) <= box_values_curr_status(3,2);
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(2,2);
						elsif(box_values_curr_status(0,2) = box_values_curr_status(1,2))
						then
							box_values_next_status(0,2) <= 0;
							box_values_next_status(1,2) <= box_values_curr_status(0,2) + box_values_curr_status(1,2);
							box_values_next_status(2,2) <= box_values_curr_status(2,2);
							box_values_next_status(3,2) <= box_values_curr_status(3,2);
							merge_next(2) <= '1';
							next_score <= next_score + box_values_next_status(1,2);
						end if;
					end if;
					-- quarta colonna
					if(merge_reg(3)='0')
					then
						if(box_values_curr_status(0,3) = box_values_curr_status(1,3) 
							and box_values_curr_status(2,3) = box_values_curr_status(3,3))
						then
							box_values_next_status(0,3) <= 0;
							box_values_next_status(1,3) <= 0;
							box_values_next_status(2,3) <= box_values_curr_status(0,3)+box_values_curr_status(1,3);
							box_values_next_status(3,3) <= box_values_curr_status(2,3)+box_values_curr_status(3,3);
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(2,3) + box_values_next_status(3,3);
						elsif(box_values_curr_status(2,3) = box_values_curr_status(3,3))
						then
							box_values_next_status(0,3) <= 0;
							box_values_next_status(1,3) <= box_values_curr_status(0,3);
							box_values_next_status(2,3) <= box_values_curr_status(1,3);
							box_values_next_status(3,3) <= box_values_curr_status(2,3) + box_values_curr_status(3,3);
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(3,3);
						elsif(box_values_curr_status(1,3) = box_values_curr_status(2,3))
						then
							box_values_next_status(0,3) <= 0;
							box_values_next_status(1,3) <= box_values_curr_status(0,3);
							box_values_next_status(2,3) <= box_values_curr_status(1,3)+box_values_curr_status(2,3);
							box_values_next_status(3,3) <= box_values_curr_status(3,3);
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(2,3);
						elsif(box_values_curr_status(0,3) = box_values_curr_status(1,3))
						then
							box_values_next_status(0,3) <= 0;
							box_values_next_status(1,3) <= box_values_curr_status(0,3) + box_values_curr_status(1,3);
							box_values_next_status(2,3) <= box_values_curr_status(2,3);
							box_values_next_status(3,3) <= box_values_curr_status(3,3);
							merge_next(3) <= '1';
							next_score <= next_score + box_values_next_status(1,3);
						end if;
					end if;
				when others =>
					reg_next_state <= idle;
			end case;
		elsif(reg_state = move1 or reg_state = move2 or reg_state = move3)
		then
			if(reg_state = move1) then
				reg_next_state <= merge2;
			elsif(reg_state = move2) then
				reg_next_state <= merge3;
			else
				reg_next_state <= randupdate;
			end if;
			
			case directionPosEdge is
				when dirRIGHT =>
					-- prima riga
					if(box_values_curr_status(0,2) > 0 and box_values_curr_status(0,3) = 0)
					then
						box_values_next_status(0,0) <= 0;
						box_values_next_status(0,1) <= box_values_curr_status(0,0);
						box_values_next_status(0,2) <= box_values_curr_status(0,1);
						box_values_next_status(0,3) <= box_values_curr_status(0,2);
					elsif(box_values_curr_status(0,1) > 0 and box_values_curr_status(0,2) = 0)
					then
						box_values_next_status(0,0) <= 0;
						box_values_next_status(0,1) <= box_values_curr_status(0,0);
						box_values_next_status(0,2) <= box_values_curr_status(0,1);
					elsif(box_values_curr_status(0,0) > 0 and box_values_curr_status(0,1) = 0)
					then
						box_values_next_status(0,0) <= 0;
						box_values_next_status(0,1) <= box_values_curr_status(0,0);
					end if;
					
					--seconda riga
					if(box_values_curr_status(1,2) > 0 and box_values_curr_status(1,3) = 0)
					then
						box_values_next_status(1,0) <= 0;
						box_values_next_status(1,1) <= box_values_curr_status(1,0);
						box_values_next_status(1,2) <= box_values_curr_status(1,1);
						box_values_next_status(1,3) <= box_values_curr_status(1,2);
					elsif(box_values_curr_status(1,1) > 0 and box_values_curr_status(1,2) = 0)
					then
						box_values_next_status(1,0) <= 0;
						box_values_next_status(1,1) <= box_values_curr_status(1,0);
						box_values_next_status(1,2) <= box_values_curr_status(1,1);
					elsif(box_values_curr_status(1,0) > 0 and box_values_curr_status(1,1) = 0)
					then
						box_values_next_status(1,0) <= 0;
						box_values_next_status(1,1) <= box_values_curr_status(1,0);
					end if;
					
					--terza riga
					if(box_values_curr_status(2,2) > 0 and box_values_curr_status(2,3) = 0)
					then
						box_values_next_status(2,0) <= 0;
						box_values_next_status(2,1) <= box_values_curr_status(2,0);
						box_values_next_status(2,2) <= box_values_curr_status(2,1);
						box_values_next_status(2,3) <= box_values_curr_status(2,2);
					elsif(box_values_curr_status(2,1) > 0 and box_values_curr_status(2,2) = 0)
					then
						box_values_next_status(2,0) <= 0;
						box_values_next_status(2,1) <= box_values_curr_status(2,0);
						box_values_next_status(2,2) <= box_values_curr_status(2,1);
					elsif(box_values_curr_status(2,0) > 0 and box_values_curr_status(2,1) = 0)
					then
						box_values_next_status(2,0) <= 0;
						box_values_next_status(2,1) <= box_values_curr_status(2,0);
					end if;
					
					--quarta riga
					if(box_values_curr_status(3,2) > 0 and box_values_curr_status(3,3) = 0)
					then
						box_values_next_status(3,0) <= 0;
						box_values_next_status(3,1) <= box_values_curr_status(3,0);
						box_values_next_status(3,2) <= box_values_curr_status(3,1);
						box_values_next_status(3,3) <= box_values_curr_status(3,2);
					elsif(box_values_curr_status(3,1) > 0 and box_values_curr_status(3,2) = 0)
					then
						box_values_next_status(3,0) <= 0;
						box_values_next_status(3,1) <= box_values_curr_status(3,0);
						box_values_next_status(3,2) <= box_values_curr_status(3,1);
					elsif(box_values_curr_status(3,0) > 0 and box_values_curr_status(3,1) = 0)
					then
						box_values_next_status(3,0) <= 0;
						box_values_next_status(3,1) <= box_values_curr_status(3,0);
					end if;
				when dirLEFT =>
				
					-- prima riga
					if(box_values_curr_status(0,1) > 0 and box_values_curr_status(0,0) = 0)
					then
						box_values_next_status(0,3) <= 0;
						box_values_next_status(0,2) <= box_values_curr_status(0,3);
						box_values_next_status(0,1) <= box_values_curr_status(0,2);
						box_values_next_status(0,0) <= box_values_curr_status(0,1);
					elsif(box_values_curr_status(0,2) > 0 and box_values_curr_status(0,1) = 0)
					then
						box_values_next_status(0,3) <= 0;
						box_values_next_status(0,2) <= box_values_curr_status(0,3);
						box_values_next_status(0,1) <= box_values_curr_status(0,2);
					elsif(box_values_curr_status(0,3) > 0 and box_values_curr_status(0,2) = 0)
					then
						box_values_next_status(0,3) <= 0;
						box_values_next_status(0,2) <= box_values_curr_status(0,3);
					end if;
					
					-- seconda riga
					if(box_values_curr_status(1,1) > 0 and box_values_curr_status(1,0) = 0)
					then
						box_values_next_status(1,3) <= 0;
						box_values_next_status(1,2) <= box_values_curr_status(1,3);
						box_values_next_status(1,1) <= box_values_curr_status(1,2);
						box_values_next_status(1,0) <= box_values_curr_status(1,1);
					elsif(box_values_curr_status(1,2) > 0 and box_values_curr_status(1,1) = 0)
					then
						box_values_next_status(1,3) <= 0;
						box_values_next_status(1,2) <= box_values_curr_status(1,3);
						box_values_next_status(1,1) <= box_values_curr_status(1,2);
					elsif(box_values_curr_status(1,3) > 0 and box_values_curr_status(1,2) = 0)
					then
						box_values_next_status(1,3) <= 0;
						box_values_next_status(1,2) <= box_values_curr_status(1,3);
					end if;
					
					-- terza riga
					if(box_values_curr_status(2,1) > 0 and box_values_curr_status(2,0) = 0)
					then
						box_values_next_status(2,3) <= 0;
						box_values_next_status(2,2) <= box_values_curr_status(2,3);
						box_values_next_status(2,1) <= box_values_curr_status(2,2);
						box_values_next_status(2,0) <= box_values_curr_status(2,1);
					elsif(box_values_curr_status(2,2) > 0 and box_values_curr_status(2,1) = 0)
					then
						box_values_next_status(2,3) <= 0;
						box_values_next_status(2,2) <= box_values_curr_status(2,3);
						box_values_next_status(2,1) <= box_values_curr_status(2,2);
					elsif(box_values_curr_status(2,3) > 0 and box_values_curr_status(2,2) = 0)
					then
						box_values_next_status(2,3) <= 0;
						box_values_next_status(2,2) <= box_values_curr_status(2,3);
					end if;
					
					-- quarta riga
					if(box_values_curr_status(3,1) > 0 and box_values_curr_status(3,0) = 0)
					then
						box_values_next_status(3,3) <= 0;
						box_values_next_status(3,2) <= box_values_curr_status(3,3);
						box_values_next_status(3,1) <= box_values_curr_status(3,2);
						box_values_next_status(3,0) <= box_values_curr_status(3,1);
					elsif(box_values_curr_status(3,2) > 0 and box_values_curr_status(3,1) = 0)
					then
						box_values_next_status(3,3) <= 0;
						box_values_next_status(3,2) <= box_values_curr_status(3,3);
						box_values_next_status(3,1) <= box_values_curr_status(3,2);
					elsif(box_values_curr_status(3,3) > 0 and box_values_curr_status(3,2) = 0)
					then
						box_values_next_status(3,3) <= 0;
						box_values_next_status(3,2) <= box_values_curr_status(3,3);
					end if;

				when dirUP =>
					
					--prima colonna
					if(box_values_curr_status(1,0) > 0 and box_values_curr_status(0,0) = 0)
					then
						box_values_next_status(3,0) <= 0;
						box_values_next_status(2,0)	<= box_values_curr_status(3,0);
						box_values_next_status(1,0) <= box_values_curr_status(2,0);
						box_values_next_status(0,0) <= box_values_curr_status(1,0);
					elsif(box_values_curr_status(2,0) > 0 and box_values_curr_status(1,0) = 0)
					then
						box_values_next_status(3,0) <= 0;
						box_values_next_status(2,0)	<= box_values_curr_status(3,0);
						box_values_next_status(1,0) <= box_values_curr_status(2,0);
					elsif(box_values_curr_status(3,0) > 0 and box_values_curr_status(2,0) = 0)
					then
						box_values_next_status(3,0) <= 0;
						box_values_next_status(2,0)	<= box_values_curr_status(3,0);
					end if;
					
					--seconda colonna
					if(box_values_curr_status(1,1) > 0 and box_values_curr_status(0,1) = 0)
					then
						box_values_next_status(3,1) <= 0;
						box_values_next_status(2,1)	<= box_values_curr_status(3,1);
						box_values_next_status(1,1) <= box_values_curr_status(2,1);
						box_values_next_status(0,1) <= box_values_curr_status(1,1);
					elsif(box_values_curr_status(2,1) > 0 and box_values_curr_status(1,1) = 0)
					then
						box_values_next_status(3,1) <= 0;
						box_values_next_status(2,1)	<= box_values_curr_status(3,1);
						box_values_next_status(1,1) <= box_values_curr_status(2,1);
					elsif(box_values_curr_status(3,1) > 0 and box_values_curr_status(2,1) = 0)
					then
						box_values_next_status(3,1) <= 0;
						box_values_next_status(2,1)	<= box_values_curr_status(3,1);
					end if;
					
					--terza colonna
					if(box_values_curr_status(1,2) > 0 and box_values_curr_status(0,2) = 0)
					then
						box_values_next_status(3,2) <= 0;
						box_values_next_status(2,2)	<= box_values_curr_status(3,2);
						box_values_next_status(1,2) <= box_values_curr_status(2,2);
						box_values_next_status(0,2) <= box_values_curr_status(1,2);
					elsif(box_values_curr_status(2,2) > 0 and box_values_curr_status(1,2) = 0)
					then
						box_values_next_status(3,2) <= 0;
						box_values_next_status(2,2)	<= box_values_curr_status(3,2);
						box_values_next_status(1,2) <= box_values_curr_status(2,2);
					elsif(box_values_curr_status(3,2) > 0 and box_values_curr_status(2,2) = 0)
					then
						box_values_next_status(3,2) <= 0;
						box_values_next_status(2,2)	<= box_values_curr_status(3,2);
					end if;
					
					--quarta colonna
					if(box_values_curr_status(1,3) > 0 and box_values_curr_status(0,3) = 0)
					then
						box_values_next_status(3,3) <= 0;
						box_values_next_status(2,3)	<= box_values_curr_status(3,3);
						box_values_next_status(1,3) <= box_values_curr_status(2,3);
						box_values_next_status(0,3) <= box_values_curr_status(1,3);
					elsif(box_values_curr_status(2,3) > 0 and box_values_curr_status(1,3) = 0)
					then
						box_values_next_status(3,3) <= 0;
						box_values_next_status(2,3)	<= box_values_curr_status(3,3);
						box_values_next_status(1,3) <= box_values_curr_status(2,3);
					elsif(box_values_curr_status(3,3) > 0 and box_values_curr_status(2,3) = 0)
					then
						box_values_next_status(3,3) <= 0;
						box_values_next_status(2,3)	<= box_values_curr_status(3,3);
					end if;
				when dirDOWN =>
				
					-- prima colonna
					if(box_values_curr_status(2,0) > 0 and box_values_curr_status(3,0) = 0)
					then
						box_values_next_status(0,0) <= 0;
						box_values_next_status(1,0) <= box_values_curr_status(0,0);
						box_values_next_status(2,0) <= box_values_curr_status(1,0);
						box_values_next_status(3,0) <= box_values_curr_status(2,0);
					elsif(box_values_curr_status(1,0) > 0 and box_values_curr_status(2,0) = 0)
					then
						box_values_next_status(0,0) <= 0;
						box_values_next_status(1,0) <= box_values_curr_status(0,0);
						box_values_next_status(2,0) <= box_values_curr_status(1,0);
					elsif(box_values_curr_status(0,0) > 0 and box_values_curr_status(1,0) = 0)
					then
						box_values_next_status(0,0) <= 0;
						box_values_next_status(1,0) <= box_values_curr_status(0,0);
					end if;
					
					-- seconda colonna
					if(box_values_curr_status(2,1) > 0 and box_values_curr_status(3,1) = 0)
					then
						box_values_next_status(0,1) <= 0;
						box_values_next_status(1,1) <= box_values_curr_status(0,1);
						box_values_next_status(2,1) <= box_values_curr_status(1,1);
						box_values_next_status(3,1) <= box_values_curr_status(2,1);
					elsif(box_values_curr_status(1,1) > 0 and box_values_curr_status(2,1) = 0)
					then
						box_values_next_status(0,1) <= 0;
						box_values_next_status(1,1) <= box_values_curr_status(0,1);
						box_values_next_status(2,1) <= box_values_curr_status(1,1);
					elsif(box_values_curr_status(0,1) > 0 and box_values_curr_status(1,1) = 0)
					then
						box_values_next_status(0,1) <= 0;
						box_values_next_status(1,1) <= box_values_curr_status(0,1);
					end if;
					
					-- terza colonna
					if(box_values_curr_status(2,2) > 0 and box_values_curr_status(3,2) = 0)
					then
						box_values_next_status(0,2) <= 0;
						box_values_next_status(1,2) <= box_values_curr_status(0,2);
						box_values_next_status(2,2) <= box_values_curr_status(1,2);
						box_values_next_status(3,2) <= box_values_curr_status(2,2);
					elsif(box_values_curr_status(1,2) > 0 and box_values_curr_status(2,2) = 0)
					then
						box_values_next_status(0,2) <= 0;
						box_values_next_status(1,2) <= box_values_curr_status(0,2);
						box_values_next_status(2,2) <= box_values_curr_status(1,2);
					elsif(box_values_curr_status(0,2) > 0 and box_values_curr_status(1,2) = 0)
					then
						box_values_next_status(0,2) <= 0;
						box_values_next_status(1,2) <= box_values_curr_status(0,2);
					end if;

					-- quarta colonna
					if(box_values_curr_status(2,3) > 0 and box_values_curr_status(3,3) = 0)
					then
						box_values_next_status(0,3) <= 0;
						box_values_next_status(1,3) <= box_values_curr_status(0,3);
						box_values_next_status(2,3) <= box_values_curr_status(1,3);
						box_values_next_status(3,3) <= box_values_curr_status(2,3);
					elsif(box_values_curr_status(1,3) > 0 and box_values_curr_status(2,3) = 0)
					then
						box_values_next_status(0,3) <= 0;
						box_values_next_status(1,3) <= box_values_curr_status(0,3);
						box_values_next_status(2,3) <= box_values_curr_status(1,3);
					elsif(box_values_curr_status(0,3) > 0 and box_values_curr_status(1,3) = 0)
					then
						box_values_next_status(0,3) <= 0;
						box_values_next_status(1,3) <= box_values_curr_status(0,3);
					end if;
				when others =>
					reg_next_state <= idle;
			end case;
		elsif(reg_state = randupdate)
		then
			directionPosEdge_next <= movepadDirection;
			reg_next_state <= idle;
--			addNumRand(box_values_curr_status, randNum, box_values_next_status);
		end if;
	end if;
--	-- iniz. stato iniziale gioco, sempre uguale per regolamento
--	box_values_status(2,2) := 2;
--	box_values_status(2,3) := 4;
--	box_values_status(3,1) := 2;
--	box_values_status(3,2) := 2;
--	box_values_status(3,3) := 2;




	
	-- segnali in uscita
END PROCESS;
END behavior;