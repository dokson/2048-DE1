LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE GAME_TYPES IS
	constant GRID_WIDTH 	: INTEGER := 4;
	constant GRID_HEIGHT 	: INTEGER := 4; 
	
	-- game state type
	type GAME_STATE is (bootstrap, playing, gameover, victory);
	
	-- data type
	type DATA_STATE is (randupdate, idle, merge1, move1, merge2, move2, merge3, move3);
	type GAME_GRID is array (GRID_HEIGHT-1 downto 0, GRID_WIDTH -1 downto 0) of integer;
	
	-- tipi per la grafica
	subtype RGB_COLOR is std_logic_vector(11 downto 0);
	
	-- Colori standard
	constant COLOR_BLACK	: RGB_COLOR := X"000";
	constant COLOR_BLUE		: RGB_COLOR := X"00F";
	constant COLOR_BLUE_MED	: RGB_COLOR := X"00D";
	constant COLOR_BLUE_MIDN: RGB_COLOR := X"227";
	constant COLOR_BLUEROYAL: RGB_COLOR := X"46E";
	constant COLOR_BROWN	: RGB_COLOR := X"841";
	constant COLOR_CYAN		: RGB_COLOR := X"0FF";
	constant COLOR_CREAM	: RGB_COLOR := X"EFE";
	constant COLOR_GOLD		: RGB_COLOR	:= X"FD0";
	constant COLOR_GREEN	: RGB_COLOR	:= X"080";
	constant COLOR_GREEN_D	: RGB_COLOR	:= X"060";
	constant COLOR_GREEN_SPR: RGB_COLOR := X"0F8";
	constant COLOR_GREY		: RGB_COLOR := X"888";
	constant COLOR_GREY_D	: RGB_COLOR := X"BBB";
	constant COLOR_KHAKI	: RGB_COLOR	:= X"FE8";
	constant COLOR_IVORY	: RGB_COLOR	:= X"FFE";
	constant COLOR_LIME		: RGB_COLOR := X"0F0";
	constant COLOR_MAGENTA	: RGB_COLOR := X"F0F";
	constant COLOR_MAROON	: RGB_COLOR := X"800";
	constant COLOR_NAVY		: RGB_COLOR := X"008";
	constant COLOR_OLIVE	: RGB_COLOR := X"880";
	constant COLOR_ORANGE	: RGB_COLOR := X"FA0";
	constant COLOR_ORANGE_D	: RGB_COLOR := X"F80";
	constant COLOR_ORANGERED: RGB_COLOR := X"F40";
	constant COLOR_ORCHID	: RGB_COLOR := X"E7D";
	constant COLOR_PINK		: RGB_COLOR	:= X"FCC";
	constant COLOR_PINK_HOT	: RGB_COLOR	:= X"F7B";
	constant COLOR_PLUM		: RGB_COLOR := X"DAD";
	constant COLOR_PURPLE	: RGB_COLOR := X"808";
	constant COLOR_REBECCA	: RGB_COLOR := X"639";
	constant COLOR_RED		: RGB_COLOR := X"F00";
	constant COLOR_SALMON	: RGB_COLOR	:= X"F87";
	constant COLOR_SILVER	: RGB_COLOR := X"CCC";
	constant COLOR_SLATEGRAY: RGB_COLOR := X"789";
	constant COLOR_SNOW		: RGB_COLOR := X"FEE";
	constant COLOR_TEAL		: RGB_COLOR := X"088";
	constant COLOR_TURQUOISE: RGB_COLOR := X"4ED";
	constant COLOR_VIOLET	: RGB_COLOR := X"E8E";
	constant COLOR_WHEAT	: RGB_COLOR := X"FDB";
	constant COLOR_WHITE	: RGB_COLOR := X"FFF";
	constant COLOR_YELLOW	: RGB_COLOR := X"FF0";
	constant COLOR_YLLWGREEN: RGB_COLOR := X"AD3";
	
	-- Colori personalizzati per il gioco
	constant COLOR_BG		: RGB_COLOR := COLOR_SLATEGRAY;
	constant COLOR_BORDER	: RGB_COLOR := COLOR_GREY_D;
	constant COLOR_0		: RGB_COLOR := X"999";
	constant COLOR_2		: RGB_COLOR := X"EED"; 
	constant COLOR_4		: RGB_COLOR := X"FEC";
	constant COLOR_8		: RGB_COLOR := X"EA7";
	constant COLOR_16		: RGB_COLOR := X"E85";
	constant COLOR_32		: RGB_COLOR := X"E65";
	constant COLOR_64		: RGB_COLOR := X"E53";
	constant COLOR_128		: RGB_COLOR := X"FE5";
	constant COLOR_256		: RGB_COLOR := X"ED4";
	constant COLOR_512		: RGB_COLOR := X"ED0";
	constant COLOR_1024		: RGB_COLOR := X"EC0";
	constant COLOR_2048		: RGB_COLOR := X"EB0";
	
END GAME_TYPES;
