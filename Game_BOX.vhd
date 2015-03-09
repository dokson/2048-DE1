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
		--boxValue : in integer range 0 to 2500; 
	
		--this signal is so we can tell whether we should actually draw the color
		--being output by the box or not!
		
		--red, green, blue		: OUT STD_LOGIC_VECTOR(3 downto 0)
		drawBox : out STD_LOGIC := '0'
	);
end GAME_BOX;


architecture game_arch of GAME_BOX is
	--============================================================================
	------------------Constant Declarations---------------------------------------
	--============================================================================
	constant DIMENSIONS : integer range 0 to 200 := 150;
	constant MAX_X : integer range 0 to 1000 := XPOS + DIMENSIONS - 1;
	constant MAX_Y : integer range 0 to 500 := YPOS + DIMENSIONS - 1;

begin
	drawBox <= '1' 
		when 
			pixel_x >= XPOS and pixel_x <= MAX_X and pixel_y >= YPOS and pixel_y <= MAX_Y 
		else
			'0';
end game_arch;
