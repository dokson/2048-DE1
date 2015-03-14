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
	-- Coordinate finali del cubo sullo schermo
	constant MAX_X 		: integer := XPOS + larghezza; -- larghezza
	constant MAX_Y 		: integer := YPOS + altezza; -- altezza
begin
	valueChange : process(number)
	begin
		case number is
			when 2 => 
				color 	<=	"101110111011"; -- grigio chiaro
			when 4 => 
				color 	<=	"101010101010"; -- grigio scuro
			when 8 => 
				color 	<=	"110101110110"; -- rosa
			when 16 => 
				color 	<=	"111001000100"; -- rosa +
			when 32 => 
				color 	<=	"111000110011"; -- rosa ++
			when 64 => 
				color 	<=	"111100000000"; -- rosa +++
			when others => 
				color 	<=	"111111111111";
		end case;
	end process valueChange;
	
	drawBox <= '1' 
		when 
			pixel_x >= XPOS and pixel_x <= MAX_X and pixel_y >= YPOS and pixel_y <= MAX_Y 
		else
			'0';
end box_arch;
