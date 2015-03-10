library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GAME_BOX is
	generic
	(
		XPOS : in NATURAL;
		YPOS : in NATURAL
	);
	port
	(
		pixel_x : in integer range 0 to 1000;
		pixel_y : in integer range 0 to 500;
		number	: in integer range 0 to 2500; 		
		
		color	: OUT STD_LOGIC_VECTOR(11 downto 0);
		-- segnale che indica alla view quando va disegnato il box
		drawBox : OUT STD_LOGIC := '0'
	);
end GAME_BOX;


architecture game_arch of GAME_BOX is
	-- Coordinate finali del cubo sullo schermo
	constant MAX_X 		: integer range 0 to 1000 	:= XPOS + 150;
	constant MAX_Y 		: integer range 0 to 500 	:= YPOS + 105;
begin

	valueChange : process(number)
	begin
		case number is
			when 2 => 
				color 	<=	"111100000000"; -- ROSSINO
			when others => 
				color 	<=	"001101101100";
		end case;
	end process valueChange;
	
	drawBox <= '1' 
		when 
			pixel_x >= XPOS and pixel_x <= MAX_X and pixel_y >= YPOS and pixel_y <= MAX_Y 
		else
			'0';
				
end game_arch;
