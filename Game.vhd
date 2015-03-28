LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE WORK.GAME_TYPES.ALL;

entity GAME is
    port
	(
		-- INPUT
		clk_50Mhz	: IN  STD_LOGIC;
		PS2_CLK		: IN  STD_LOGIC;
		PS2_DAT		: IN  STD_LOGIC;

		-- OUTPUT	
		hsync,
		vsync		: OUT  STD_LOGIC;		
		red, 
		green,
		blue		: OUT STD_LOGIC_VECTOR(3 downto 0);				
		leds1 	: OUT STD_LOGIC_VECTOR(6 downto 0); 
		leds2 	: OUT STD_LOGIC_VECTOR(6 downto 0);
		leds3 	: OUT STD_LOGIC_VECTOR(6 downto 0); 
		leds4 	: OUT STD_LOGIC_VECTOR(6 downto 0)
	);
end GAME;

architecture Behavioral of GAME is

	signal clock_25Mhz: STD_LOGIC;
	signal keyCode: STD_LOGIC_VECTOR(7 downto 0);			
	signal goingReady: STD_LOGIC;

	signal boot: STD_LOGIC;
	
	signal isgameover: STD_LOGIC;
	signal isvictory: STD_LOGIC;
	signal box_values : GAME_GRID;
	signal score: INTEGER RANGE 0 to 9999;
	signal movepadDirection: STD_LOGIC_VECTOR(3 downto 0);
	
	signal won: STD_LOGIC;
	signal lost: STD_LOGIC;

BEGIN

ClockDivider: entity work.GAME_CLKGENERATOR
	port map
	(
		clock			=> clk_50Mhz,
		clock_mezzi => clock_25Mhz
	);

Keyboard: entity work.GAME_KEYBOARD
	port map
	(
		clk				=> clock_25Mhz,
		keyboardClock	=> PS2_CLK,
		keyboardData	=> PS2_DAT,	
		keyCode			=> keyCode		
	);

ControlUnit: entity work.GAME_CONTROL
	port map
	(
		clk				=> clock_25Mhz,
		
		keyboardData	=> keyCode,	
		goingReady		=> goingReady, 
		
		isgameover	=> isgameover,
		isvictory	=> isvictory,

		boot	=> boot,
		
		won	=>	won,
		lost	=> lost,
		
		movepadDirection => movepadDirection
	);

Datapath: entity work.GAME_DATA
	port map
	(
		clk			=> clock_25Mhz,
		bootstrap	=> boot,
		
		movepadDirection => movepadDirection,
		
		goingReady	=> goingReady,
		isgameover	=> isgameover,
		isvictory 	=> isvictory,
		box_values 	=> box_values,
		score			=> score
	);

View: entity work.GAME_VIEW
	port map
	(
		clk			=> clock_25Mhz,
		
		box_values 	=> box_values,
		score			=> score,

		bootstrap	=> boot,
		lost			=> lost,
		won			=> won,
		
		hsync			=> hsync,		
		vsync			=> vsync,		
		red			=> red,	
		green			=> green,		
		blue			=> blue,		
				
		leds1			=> leds1,		
		leds2 		=> leds2,
		leds3 		=> leds3, 
		leds4 		=> leds4 
	);
end Behavioral;