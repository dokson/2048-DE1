LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity GAME is
    port
	(
		-- INPUT
		clk_50Mhz		: IN  STD_LOGIC;
		cheatKey		: IN  STD_LOGIC;
		PS2_CLK			: IN  STD_LOGIC;
		PS2_DAT			: IN  STD_LOGIC;
			
		-- OUTPUT	
		hsync,
		vsync			: OUT  STD_LOGIC;		
		red, 
		green,
		blue			: OUT STD_LOGIC_VECTOR(3 downto 0);				
		leds1 			: OUT STD_LOGIC_VECTOR(6 downto 0); 
		leds2 			: OUT STD_LOGIC_VECTOR(6 downto 0);
		leds3 			: OUT STD_LOGIC_VECTOR(6 downto 0); 
		leds4 			: OUT STD_LOGIC_VECTOR(6 downto 0)
	);
end GAME;

architecture Behavioral of GAME is
			
	component GAME_CLKGENERATOR is
	port
	(
		clock		: IN  STD_LOGIC;
		clock_mezzi	: OUT STD_LOGIC
	);
	end component;

	component GAME_KEYBOARD is
	port
	(
		clk				: IN  STD_LOGIC;
		keyboardClock	: IN STD_LOGIC;
		keyboardData	: IN STD_LOGIC;
		keyCode			: OUT STD_LOGIC_VECTOR(7 downto 0)
	);
	end component;

	component GAME_CONTROL is
	port
	(
		clk				: IN STD_LOGIC;
		
		keyboardData	: IN STD_LOGIC_VECTOR (7 downto 0);
		goingReady		: IN STD_LOGIC;
		
		enable			: OUT STD_LOGIC;
		boot			: OUT STD_LOGIC
	);
	end component;

	component GAME_DATA is
	port
	(
		clk				: IN STD_LOGIC;
		enable			: IN STD_LOGIC;
		bootstrap		: IN STD_LOGIC;
		
		northBorder		: OUT INTEGER range 0 to 500;
		southBorder		: OUT INTEGER range 0 to 500;
		westBorder		: OUT INTEGER range 0 to 1000;
		eastBorder		: OUT INTEGER range 0 to 1000;
		goingReady		: OUT STD_LOGIC;
		victory			: OUT STD_LOGIC;
		gameover		: OUT STD_LOGIC
	);
	end component;

	component GAME_VIEW is
	port(
		clk				: IN STD_LOGIC;
		
		northBorder		: IN INTEGER range 0 to 500;
		southBorder		: IN INTEGER range 0 to 500;
		westBorder		: IN INTEGER range 0 to 1000;
		eastBorder		: IN INTEGER range 0 to 1000;

		bootstrap		: IN STD_LOGIC;
		gameover		: IN STD_LOGIC;
		victory			: IN STD_LOGIC;
		
		hsync,
		vsync			: OUT STD_LOGIC;
		red, 
		green,
		blue			: OUT STD_LOGIC_VECTOR(3 downto 0);	
				
		leds1 			: OUT STD_LOGIC_VECTOR(6 downto 0); 
		leds2 			: out STD_LOGIC_VECTOR(6 downto 0); 
		leds3 			: out STD_LOGIC_VECTOR(6 downto 0); 
		leds4 			: out STD_LOGIC_VECTOR(6 downto 0) 	
		);
	end component;



signal clock_25Mhz: STD_LOGIC;
signal keyCode: STD_LOGIC_VECTOR(7 downto 0);			
signal goingReady: STD_LOGIC;

signal enable: STD_LOGIC;
signal boot: STD_LOGIC;

signal northBorder: INTEGER range 0 to 500;
signal southBorder: INTEGER range 0 to 500;
signal westBorder: INTEGER range 0 to 1000;
signal eastBorder: INTEGER range 0 to 1000;
signal gameover: STD_LOGIC;
signal victory: STD_LOGIC;

BEGIN

ClockGenerator: GAME_CLKGENERATOR
	port map(
		clock		=> clk_50Mhz,
		clock_mezzi 	=> clock_25Mhz
		);

KeyboardController: GAME_KEYBOARD
	port map(
		clk		=> clock_25Mhz,
		keyboardClock	=> PS2_CLK,
		keyboardData	=> PS2_DAT,	
		keyCode		=> keyCode		
		);

ControlUnit: GAME_CONTROL
	port map(
		clk		=> clock_25Mhz,
		
		keyboardData	=> keyCode,	
		goingReady	=> goingReady, 

		enable		=> enable,		
		boot		=> boot
		);

Datapath: GAME_DATA
	port map(
		clk		=> clock_25Mhz,
		enable		=> enable,
		bootstrap	=> boot,

		northBorder	=> northBorder,
		southBorder	=> southBorder,
		westBorder	=> westBorder,
		eastBorder	=> eastBorder,
		
		goingReady	=> goingReady,
		victory		=> victory,
		gameover 	=> gameover
		);

View: GAME_VIEW
	port map
	(
		clk		=> clock_25Mhz,

		northBorder	=> northBorder,
		southBorder	=> southBorder,
		westBorder	=> westBorder,
		eastBorder	=> eastBorder,

		bootstrap	=> boot,
		gameover	=> gameover,
		victory		=> victory,
		
		hsync		=> hsync,		
		vsync		=> vsync,		
		red			=> red,	
		green		=> green,		
		blue		=> blue,		
		
				
		leds1		=> leds1,		
		leds2 		=> leds2,
		leds3 		=> leds3, 
		leds4 		=> leds4 
	);



end Behavioral;