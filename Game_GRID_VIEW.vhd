LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.GAME_TYPES.ALL;

entity GAME_GRID_VIEW is
	port
	(
		-- INPUT
		clk			: IN STD_LOGIC;
		pixel_x 		: IN INTEGER RANGE 0 to 1000;
		pixel_y 		: IN INTEGER RANGE 0 to 500;	
		box_values	: IN GAME_GRID;
		
		-- OUTPUT
		color			: OUT STD_LOGIC_VECTOR(11 downto 0); -- colore da mandare in VGA
		drawGrid 	: OUT STD_LOGIC := '0' 	-- disegna la Grid quando = 1
	);
end GAME_GRID_VIEW;

ARCHITECTURE grid_arch of GAME_GRID_VIEW IS

-- Dimensioni fisse di tutti i box
constant XfirstColumn	: integer := 16;
constant YfirstRow		: integer := 46;

constant XsecondColumn	: integer := 167;
constant YsecondRow		: integer := 153;

constant XthirdColumn	: integer := 319;
constant YthirdRow		: integer := 260;

constant XfourthColumn	: integer := 471;
constant YfourthRow		: integer := 367;

-- Segnali per il disegno dei box e il relativo colore
signal drawbox1	: STD_LOGIC;
signal color1	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox2	: STD_LOGIC;
signal color2	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox3	: STD_LOGIC;
signal color3	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox4	: STD_LOGIC;
signal color4	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox5	: STD_LOGIC;
signal color5	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox6	: STD_LOGIC;
signal color6	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox7	: STD_LOGIC;
signal color7	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox8	: STD_LOGIC;
signal color8	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox9	: STD_LOGIC;
signal color9	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox10: STD_LOGIC;
signal color10	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox11: STD_LOGIC;
signal color11	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox12: STD_LOGIC;
signal color12	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox13: STD_LOGIC;
signal color13	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox14: STD_LOGIC;
signal color14	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox15: STD_LOGIC;
signal color15	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox16: STD_LOGIC;
signal color16	: STD_LOGIC_VECTOR(11 downto 0);

BEGIN

BOX1: entity work.GAME_BOX
	generic map
	(
		XPOS => XfirstColumn,
		YPOS => YfirstRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(0,0),
		drawbox => drawbox1,
		color => color1
	);

BOX2: entity work.GAME_BOX
	generic map
	(
		XPOS => XsecondColumn,
		YPOS => YfirstRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(0,1),
		drawbox => drawbox2,
		color => color2
	);
	
BOX3: entity work.GAME_BOX
	generic map
	(
		XPOS => XthirdColumn,
		YPOS => YfirstRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(0,2),
		drawbox => drawbox3,
		color 	=> color3
	);

BOX4: entity work.GAME_BOX
	generic map
	(
		XPOS => XfourthColumn,
		YPOS => YfirstRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(0,3),
		drawbox => drawbox4,
		color 	=> color4
	);

BOX5: entity work.GAME_BOX
	generic map
	(
		XPOS =>	XfirstColumn,
		YPOS => YsecondRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(1,0),
		drawbox => drawbox5,
		color 	=> color5
	);

BOX6: entity work.GAME_BOX
	generic map
	(
		XPOS => XsecondColumn,
		YPOS => YsecondRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(1,1),
		drawbox => drawbox6,
		color 	=> color6
	);
	
BOX7: entity work.GAME_BOX
	generic map
	(
		XPOS => XthirdColumn,
		YPOS => YsecondRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(1,2),
		drawbox => drawbox7,
		color 	=> color7
	);

BOX8: entity work.GAME_BOX
	generic map
	(
		XPOS => XfourthColumn,
		YPOS => YsecondRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(1,3),
		drawbox => drawbox8,
		color 	=> color8
	);
	
BOX9: entity work.GAME_BOX
	generic map
	(
		XPOS => XfirstColumn,
		YPOS => YthirdRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(2,0),
		drawbox => drawbox9,
		color 	=> color9
	);
	
BOX10: entity work.GAME_BOX
	generic map
	(
		XPOS => XsecondColumn,
		YPOS => YthirdRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(2,1),
		drawbox => drawbox10,
		color 	=> color10
	);

BOX11: entity work.GAME_BOX
	generic map
	(
		XPOS => XthirdColumn,
		YPOS => YthirdRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(2,2),
		drawbox => drawbox11,
		color 	=> color11
	);

BOX12: entity work.GAME_BOX
	generic map
	(
		XPOS => XfourthColumn,
		YPOS => YthirdRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(2,3),
		drawbox => drawbox12,
		color 	=> color12
	);

BOX13: entity work.GAME_BOX
	generic map
	(
		XPOS => XfirstColumn,
		YPOS => YfourthRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(3,0),
		drawbox => drawbox13,
		color 	=> color13
	);
	
BOX14: entity work.GAME_BOX
	generic map
	(
		XPOS => XsecondColumn,
		YPOS => YfourthRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(3,1),
		drawbox => drawbox14,
		color 	=> color14
	);

BOX15: entity work.GAME_BOX
	generic map
	(
		XPOS => XthirdColumn,
		YPOS => YfourthRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(3,2),
		drawbox => drawbox15,
		color 	=> color15
	);
	
BOX16: entity work.GAME_BOX
	generic map
	(
		XPOS => XfourthColumn,
		YPOS => YfourthRow
	)
	port map
	(
		clk => clk,
		pixel_x => pixel_x,
		pixel_y => pixel_y,
		number 	=> box_values(3,3),
		drawbox => drawbox16,
		color 	=> color16
	);
	
	drawBoxes : process
		(
			clk, drawbox1, drawbox2, drawbox3, drawbox4, drawbox5, drawbox6, drawbox7, drawbox8,
			drawbox9, drawbox10, drawbox11, drawbox12, drawbox13, drawbox14, drawbox15, drawbox16
		)
	begin
		if(clk'event and clk = '1')
		then
			--- DISEGNO DI OGNI BOX
			IF(drawbox1='1')
			THEN
				color <= color1; 		
			ELSIF(drawbox2='1')
			THEN
				color <= color2;  
			ELSIF(drawbox3='1')
			THEN
				color <= color3; 
			ELSIF(drawbox4='1')
			THEN
				color <= color4; 
			ELSIF(drawbox5='1')
			THEN
				color <= color5; 
			ELSIF(drawbox6='1')
			THEN
				color <= color6; 
			ELSIF(drawbox7='1')
			THEN
				color <= color7; 
			ELSIF(drawbox8='1')
			THEN
				color <= color8; 
			ELSIF(drawbox9='1')
			THEN
				color <= color9; 
			ELSIF(drawbox10='1')
			THEN
				color <= color10; 
			ELSIF(drawbox11='1')
			THEN
				color <= color11; 
			ELSIF(drawbox12='1')
			THEN
				color <= color12; 
			ELSIF(drawbox13='1')
			THEN
				color <= color13; 
			ELSIF(drawbox14='1')
			THEN
				color <= color14; 
			ELSIF(drawbox15='1')
			THEN
				color <= color15; 
			ELSIF(drawbox16='1')
			THEN
				color <= color16;
			ELSE
				color <= COLOR_BG;
			END IF;
		end if;
	end process drawBoxes;
	
	drawGrid <= '1' 
	when 
		(
			drawbox1 = '1' or drawbox2 = '1' or drawbox3='1' or drawbox4='1' or
			drawbox5 = '1' or drawbox6 = '1' or drawbox7='1' or drawbox8='1' or
			drawbox9 = '1' or drawbox10 = '1' or drawbox11='1' or drawbox12='1' or
			drawbox13 = '1' or drawbox14 = '1' or drawbox15='1' or drawbox16='1'
		)
	else
		'0';

END grid_arch;