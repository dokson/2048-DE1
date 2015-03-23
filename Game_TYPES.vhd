LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE GAME_TYPES IS
	constant GRID_WIDTH 	: INTEGER := 4;
	constant GRID_HEIGHT 	: INTEGER := 4; 
	
	type GAME_GRID is array (GRID_HEIGHT-1 downto 0, GRID_WIDTH -1 downto 0) of integer;
	subtype RGB_COLOR is std_logic_vector(11 downto 0);
	
	-- Colori primari
	constant COLOR_BLACK	: RGB_COLOR := X"000";
	constant COLOR_WHITE	: RGB_COLOR := X"FFF";
	constant COLOR_RED		: RGB_COLOR := X"F00";
	constant COLOR_ORANGE	: RGB_COLOR := X"F80";
	constant COLOR_GREEN	: RGB_COLOR := X"0F0";
	constant COLOR_BLUE		: RGB_COLOR := X"00F";
	constant COLOR_YELLOW	: RGB_COLOR := X"FF0";
	constant COLOR_CYAN		: RGB_COLOR := X"0FF";
	constant COLOR_GREY		: RGB_COLOR := X"888";
	constant COLOR_MAGENTA	: RGB_COLOR := X"F0F";	
	
	-- Colori personalizzati
	constant COLOR_TEAL		: RGB_COLOR := X"065";

END GAME_TYPES;
