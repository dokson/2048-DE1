LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity GAME_BOX is
	generic
	(
		XPOS 	: in NATURAL;
		YPOS 	: in NATURAL
	);
	port
	(
		-- INPUT
		pixel_x : IN INTEGER RANGE 0 to 1000;
		pixel_y : IN INTEGER RANGE 0 to 500;
		number	: IN INTEGER RANGE 0 to 2500; 		
		
		-- OUTPUT
		color	: OUT STD_LOGIC_VECTOR(11 downto 0); -- colore attuale del box
		drawBox : OUT STD_LOGIC := '0' 	-- disegna il box quando drawBox = 1
	);
end GAME_BOX;

architecture box_arch of GAME_BOX is
	-- Dimensioni fisse di tutti i box
	constant larghezza 	: integer := 150; 	
	constant altezza 	: integer := 105;
	constant posNumeroH	: integer := 53;
	constant posNumeroV : integer := 75;
	-- Coordinate finali del cubo sullo schermo
	constant MAX_X 		: integer := XPOS + larghezza; -- larghezza
	constant MAX_Y 		: integer := YPOS + altezza; -- altezza
	
	--
	signal numberToDraw1		: character;
	signal numberToDraw2		: character;
	signal numberToDraw3		: character;
	signal numberToDraw4		: character;
	signal drawNum1			: std_logic;
	signal drawNum2			: std_logic;
	signal drawNum3			: std_logic;
	signal drawNum4			: std_logic;

begin
	CH1: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => XPOS+55,
		YPOS => YPOS+53
	)
	port map
	(
		pixel_x => pixel_x,
		pixel_y	=> pixel_y,
		char_code =>  numberToDraw1,
		drawChar 	=> drawNum1
	);
	CH2: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => XPOS+65,
		YPOS => YPOS+53
	)
	port map
	(
		pixel_x => pixel_x,
		pixel_y	=> pixel_y,
		char_code =>  numberToDraw2,
		drawChar 	=> drawNum2
	);
	CH3: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => XPOS+75,
		YPOS => YPOS+53
	)
	port map
	(
		pixel_x => pixel_x,
		pixel_y	=> pixel_y,
		char_code =>  numberToDraw3,
		drawChar 	=> drawNum3
	);
	CH4: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => XPOS+85,
		YPOS => YPOS+53
	)
	port map
	(
		pixel_x => pixel_x,
		pixel_y	=> pixel_y,
		char_code =>  numberToDraw4,
		drawChar 	=> drawNum4
	);
	valueChange : process(number, drawNum1, drawNum2,  drawNum3, drawNum4)
	begin
		if not(drawNum1 = '1' or drawNum2 = '1' or drawNum3 = '1' or drawNum4 = '1')
		then
			case number is
				when 2 => 
					numberToDraw4 <= '2';
					numberToDraw3 <= '0';
					numberToDraw2 <= '0';
					numbertoDraw1 <= '0';
					color 	<=	"101110111011"; -- grigio chiaro
				when 4 => 
					numberToDraw4 <= '4';
					numberToDraw3 <= '0';
					numberToDraw2 <= '0';
					numbertoDraw1 <= '0';
					color 	<=	"101010101010"; -- grigio scuro
				when 8 => 
					numberToDraw4 <= '8';
					numberToDraw3 <= '0';
					numberToDraw2 <= '0';
					numbertoDraw1 <= '0';
					color 	<=	"110101110110"; -- rosa
				when 16 => 
					numberToDraw4 <= '6';
					numberToDraw3 <= '1';
					numberToDraw2 <= '0';
					numbertoDraw1 <= '0';
					color 	<=	"111001000100"; -- rosa +
				when 32 => 
					numberToDraw4 <= '2';
					numberToDraw3 <= '3';
					numberToDraw2 <= '0';
					numbertoDraw1 <= '0';
					color 	<=	"111000110011"; -- rosa ++
				when 64 => 
					numberToDraw4 <= '4';
					numberToDraw3 <= '6';
					numberToDraw2 <= '0';
					numbertoDraw1 <= '0';
					color 	<=	"111100000000"; -- rosso +++
				when 128 =>
					numberToDraw4 <= '8';
					numberToDraw3 <= '2';
					numberToDraw2 <= '1';
					numbertoDraw1 <= '0';
					color 	<=	"111111100101"; -- giallo
				when 256 =>
					numberToDraw4 <= '6';
					numberToDraw3 <= '5';
					numberToDraw2 <= '2';
					numbertoDraw1 <= '0';
					color 	<=	"111011010100"; -- giallo ++
				when 512 =>
					numberToDraw4 <= '2';
					numberToDraw3 <= '1';
					numberToDraw2 <= '5';
					numbertoDraw1 <= '0';
					color 	<=	"111011010000"; -- giallo +++
				when 1024 =>
					numberToDraw4 <= '4';
					numberToDraw3 <= '0';
					numberToDraw2 <= '2';
					numbertoDraw1 <= '1';
					color 	<=	"111011000000"; -- giallo +++
				when 2048 =>
					numberToDraw4 <= '8';
					numberToDraw3 <= '4';
					numberToDraw2 <= '0';
					numbertoDraw1 <= '2';
					color 	<=	"111010110000"; -- giallo ++++
				when others => 
					color 	<=	"111111111111";
			end case;
		else
			color <= "000000000000";
		end if;
	end process valueChange;
	
	drawBox <= '1' 
		when 
			(pixel_x >= XPOS and pixel_x <= MAX_X and pixel_y >= YPOS and pixel_y <= MAX_Y)  or (drawNum1 = '1' or 
				drawNum2 = '1' or drawNum3 = '1' or drawNum4 = '1')
		else
			'0';
			
	
end box_arch;
