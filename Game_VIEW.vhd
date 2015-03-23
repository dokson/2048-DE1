LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.GAME_TYPES.ALL;

ENTITY GAME_VIEW IS
PORT
	(
		-- INPUTs
		clk			: IN STD_LOGIC;	
		
		upBorder 	: IN INTEGER RANGE 0 to 500;
		downBorder 	: IN INTEGER RANGE 0 to 500;
		leftBorder 	: IN INTEGER RANGE 0 to 1000;
		rightBorder : IN INTEGER RANGE 0 to 1000;
		
		-- MODEL STATUS
		box_values	: IN GAME_GRID;
		score : IN INTEGER RANGE 0 to 9999;
		
		bootstrap	: IN STD_LOGIC;
		
		-- gameover / victory
		gameover,
		victory		: IN STD_LOGIC;
		
		-- OUTPUTs
		hsync,
		vsync		: OUT STD_LOGIC;
		red, 
		green,
		blue		: OUT STD_LOGIC_VECTOR(3 downto 0);
		
		-- USCITE 7 bit per i 4 display 7 segmenti
		leds1,
		leds2,
		leds3,
		leds4 		: OUT STD_LOGIC_VECTOR(6 downto 0)
	); 
		
end  GAME_VIEW;

ARCHITECTURE behavior of  GAME_VIEW IS

-- Sync Counters
shared variable h_cnt	: integer range 0 to 1000;
shared variable v_cnt  	: integer range 0 to 500;

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

-- Segnali per il disegno dei caratteri su schermo : autori
signal drawCharC : STD_LOGIC;
signal drawCharO : STD_LOGIC;
signal drawCharL : STD_LOGIC;
signal drawCharA : STD_LOGIC;
signal drawCharC1 : STD_LOGIC;
signal drawCharE : STD_LOGIC;
signal drawCharSep: STD_LOGIC;
signal drawCharG : STD_LOGIC;
signal drawCharE1 : STD_LOGIC;
signal drawCharZ : STD_LOGIC;
signal drawCharZ1 : STD_LOGIC;
signal drawCharI : STD_LOGIC;

-- game over
signal drawGoG : STD_LOGIC;
signal drawGoA : STD_LOGIC;
signal drawGoM : STD_LOGIC;
signal drawGoE : STD_LOGIC;
signal drawGoO : STD_LOGIC;
signal drawGoV : STD_LOGIC;
signal drawGoE1: STD_LOGIC;
signal drawGoR : STD_LOGIC;

BEGIN


--Disegno caratteri : autori
CHC: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 16,
		YPOS => 26
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code =>  'C',
		drawChar 	=> drawCharC
	);
CHO: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 26,
		YPOS => 26
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'o',
		drawChar 	=> drawCharO
	);
CHL: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 36,
		YPOS => 26
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'l',
		drawChar 	=> drawCharL
	);
CHA: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 46,
		YPOS => 26
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'a',
		drawChar 	=> drawCharA
	);
CHC1: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 56,
		YPOS => 26
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'c',
		drawChar 	=> drawCharC1
	);
CHE: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 66,
		YPOS => 26
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'e',
		drawChar 	=> drawCharE
	);

CHSEP: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 76,
		YPOS => 26
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => '-',
		drawChar 	=> drawCharSep
	);
CHG: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 86,
		YPOS => 26
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'G',
		drawChar 	=> drawCharG
	);
CHE1: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 96,
		YPOS => 26
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'e',
		drawChar 	=> drawCharE1
	);
CHZ: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 106,
		YPOS => 26
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'z',
		drawChar 	=> drawCharZ
	);
CHZ1: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 116,
		YPOS => 26
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'z',
		drawChar 	=> drawCharZ1
	);
CHI: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 126,
		YPOS => 26
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'i',
		drawChar 	=> drawCharI
	);


-- disegno caratteri : game over
CHGOG: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 280,
		YPOS => 232
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'G',
		drawChar 	=> drawGoG
	);
	
CHGOA: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 290,
		YPOS => 232
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'A',
		drawChar 	=> drawGoA
	);

CHGOM: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 300,
		YPOS => 232
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'M',
		drawChar 	=> drawGoM
	);

CHGOE: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 310,
		YPOS => 232
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'E',
		drawChar 	=> drawGoE
	);
--over

CHGOO: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 330,
		YPOS => 232
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'O',
		drawChar 	=> drawGoO
	);

CHGOV: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 340,
		YPOS => 232
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'V',
		drawChar 	=> drawGoV
	);

CHGOE1: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 350,
		YPOS => 232
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'E',
		drawChar 	=> drawGoE1
	);

CHGOR: entity work.GAME_CHDISPLAY
	generic map
	(
		XPOS => 360,
		YPOS => 232
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y	=> v_cnt,
		char_code => 'R',
		drawChar 	=> drawGoR
	);


BOX1: entity work.GAME_BOX
	generic map
	(
		XPOS => 16,
		YPOS => 46
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(0,0),
		drawbox => drawbox1,
		color 	=> color1
	);

BOX2: entity work.GAME_BOX
	generic map
	(
		XPOS => 168,
		YPOS => 46
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(0,1),
		drawbox => drawbox2,
		color 	=> color2
	);
	
BOX3: entity work.GAME_BOX
	generic map
	(
		XPOS => 320,
		YPOS => 46
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(0,2),
		drawbox => drawbox3,
		color 	=> color3
	);

BOX4: entity work.GAME_BOX
	generic map
	(
		XPOS => 472,
		YPOS => 46
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(0,3),
		drawbox => drawbox4,
		color 	=> color4
	);

BOX5: entity work.GAME_BOX
	generic map
	(
		XPOS => 16,
		YPOS => 153
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(1,0),
		drawbox => drawbox5,
		color 	=> color5
	);

BOX6: entity work.GAME_BOX
	generic map
	(
		XPOS => 168,
		YPOS => 153
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(1,1),
		drawbox => drawbox6,
		color 	=> color6
	);
	
BOX7: entity work.GAME_BOX
	generic map
	(
		XPOS => 320,
		YPOS => 153
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(1,2),
		drawbox => drawbox7,
		color 	=> color7
	);

BOX8: entity work.GAME_BOX
	generic map
	(
		XPOS => 472,
		YPOS => 153
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(1,3),
		drawbox => drawbox8,
		color 	=> color8
	);
	
BOX9: entity work.GAME_BOX
	generic map
	(
		XPOS => 16,
		YPOS => 260
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(2,0),
		drawbox => drawbox9,
		color 	=> color9
	);
	
BOX10: entity work.GAME_BOX
	generic map
	(
		XPOS => 168,
		YPOS => 260
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(2,1),
		drawbox => drawbox10,
		color 	=> color10
	);

BOX11: entity work.GAME_BOX
	generic map
	(
		XPOS => 320,
		YPOS => 260
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(2,2),
		drawbox => drawbox11,
		color 	=> color11
	);

BOX12: entity work.GAME_BOX
	generic map
	(
		XPOS => 472,
		YPOS => 260
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(2,3),
		drawbox => drawbox12,
		color 	=> color12
	);

BOX13: entity work.GAME_BOX
	generic map
	(
		XPOS => 16,
		YPOS => 367
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(3,0),
		drawbox => drawbox13,
		color 	=> color13
	);
	
BOX14: entity work.GAME_BOX
	generic map
	(
		XPOS => 168,
		YPOS => 367
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(3,1),
		drawbox => drawbox14,
		color 	=> color14
	);

BOX15: entity work.GAME_BOX
	generic map
	(
		XPOS => 320,
		YPOS => 367
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(3,2),
		drawbox => drawbox15,
		color 	=> color15
	);
	
BOX16: entity work.GAME_BOX
	generic map
	(
		XPOS => 472,
		YPOS => 367
	)
	port map
	(
		clk => clk,
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> box_values(3,3),
		drawbox => drawbox16,
		color 	=> color16
	);
	
SEGCTRL: entity work.GAME_7SEGCTRL
	port map
	(
		-- INPUT
		num	 => score,
		
		-- OUTPUT 
		seven_segs4 => leds4,
		seven_segs3 => leds3,
		seven_segs2 => leds2,
		seven_segs1	=> leds1
	);


PROCESS

-- costanti per le scritte
constant writePositionV	: integer range 0 to 50:=20;
constant distanceChar	: integer range 0 to 10:= 8;
constant writeColaceH	: integer range 0 to 1000:=40;
constant writeGezzH		: integer range 0 to 1000:=100;

variable h_sync			: STD_LOGIC;
variable v_sync			: STD_LOGIC;

-- Enable del video
variable video_en		: STD_LOGIC; 
variable horizontal_en	: STD_LOGIC;
variable vertical_en	: STD_LOGIC;

-- Segnali colori RGB a 4 bit
variable red_signal		: STD_LOGIC_VECTOR(3 downto 0); 
variable green_signal	: STD_LOGIC_VECTOR(3 downto 0);
variable blue_signal	: STD_LOGIC_VECTOR(3 downto 0);

BEGIN

WAIT UNTIL(clk'EVENT) AND (clk = '1');
	--Horizontal Sync
	--Reset Horizontal Counter	
	-- resettato al valore 799, anzichè 640, per rispettare i tempi di Front Porch
	IF (h_cnt = 799) 
		THEN
			h_cnt := 0;
		ELSE
			h_cnt := h_cnt + 1;
	END IF;

	--Sfondo
	IF (v_cnt >= 0) AND (v_cnt <= 479) 
	THEN
		-- Grigio scuro
		red_signal 	:= "0000";
		green_signal:= "0000";
		blue_signal	:= "0000";	
	END IF;	

--- BORDI SCHERMO
	IF (h_cnt <= leftBorder OR -- BORDO LEFT
		h_cnt >= rightBorder OR -- BORDO RIGHT
		v_cnt <= upBorder OR -- BORDO UP
		v_cnt >= downBorder) -- BORDO DOWN
	THEN
		-- Grigio chiaro
		red_signal 	:= "1000";
		green_signal:= "1000";
		blue_signal	:= "1000";
	END IF;
--- fine BORDO SCHERMO

--- DISEGNO DI OGNI CARATTERE : AUTORI
	IF(drawCharC='1')
	THEN
		red_signal(3 downto 0) 	:= "1111"; 		
		green_signal(3 downto 0):= "1111";  
		blue_signal(3 downto 0) := "1111"; 
	END IF;
	IF(drawCharO='1')
	THEN
		red_signal(3 downto 0) 	:= "1111"; 		
		green_signal(3 downto 0):= "1111";  
		blue_signal(3 downto 0) := "1111";
	END IF;
	IF(drawCharL='1')
	THEN
		red_signal(3 downto 0) 	:= "1111"; 		
		green_signal(3 downto 0):= "1111";  
		blue_signal(3 downto 0) := "1111"; 
	END IF;
	IF(drawCharA='1')
	THEN
		red_signal(3 downto 0) 	:= "1111"; 		
		green_signal(3 downto 0):= "1111";  
		blue_signal(3 downto 0) := "1111";
	END IF;
	IF(drawCharC1='1')
	THEN
		red_signal(3 downto 0) 	:= "1111"; 		
		green_signal(3 downto 0):= "1111";  
		blue_signal(3 downto 0) := "1111"; 
	END IF;
	IF(drawCharE='1')
	THEN
		red_signal(3 downto 0) 	:= "1111"; 		
		green_signal(3 downto 0):= "1111";  
		blue_signal(3 downto 0) := "1111"; 
	END IF;
	IF(drawCharSep='1')
	THEN
		red_signal(3 downto 0) 	:= "1111"; 		
		green_signal(3 downto 0):= "1111";  
		blue_signal(3 downto 0) := "1111"; 
	END IF;
	IF(drawCharG='1')
	THEN
		red_signal(3 downto 0) 	:= "1111"; 		
		green_signal(3 downto 0):= "1111";  
		blue_signal(3 downto 0) := "1111"; 
	END IF;
	IF(drawCharE1='1')
	THEN
		red_signal(3 downto 0) 	:= "1111"; 		
		green_signal(3 downto 0):= "1111";  
		blue_signal(3 downto 0) := "1111"; 
	END IF;
	IF(drawCharZ='1')
	THEN
		red_signal(3 downto 0) 	:= "1111"; 		
		green_signal(3 downto 0):= "1111";  
		blue_signal(3 downto 0) := "1111"; 
	END IF;
	IF(drawCharZ1='1')
	THEN
		red_signal(3 downto 0) 	:= "1111"; 		
		green_signal(3 downto 0):= "1111";  
		blue_signal(3 downto 0) := "1111"; 
	END IF;
	IF(drawCharI='1')
	THEN
		red_signal(3 downto 0) 	:= "1111"; 		
		green_signal(3 downto 0):= "1111";  
		blue_signal(3 downto 0) := "1111"; 
	END IF;

--- fine DISEGNO CHAR

--- DISEGNO DI OGNI BOX
	IF(drawbox1='1')
	THEN
		red_signal(3 downto 0) 	:= color1(11 downto 8); 		
		green_signal(3 downto 0):= color1(7 downto 4);  
		blue_signal(3 downto 0) := color1(3 downto 0); 
	END IF;
	
	IF(drawbox2='1')
	THEN
		red_signal(3 downto 0) 	:= color2(11 downto 8); 		
		green_signal(3 downto 0):= color2(7 downto 4);  
		blue_signal(3 downto 0) := color2(3 downto 0); 
	END IF;
	
	IF(drawbox3='1')
	THEN
		red_signal(3 downto 0) 	:= color3(11 downto 8); 		
		green_signal(3 downto 0):= color3(7 downto 4);  
		blue_signal(3 downto 0) := color3(3 downto 0); 
	END IF;
	
	IF(drawbox4='1')
	THEN
		red_signal(3 downto 0) 	:= color4(11 downto 8); 		
		green_signal(3 downto 0):= color4(7 downto 4);  
		blue_signal(3 downto 0) := color4(3 downto 0); 
	END IF;
	
	IF(drawbox5='1')
	THEN
		red_signal(3 downto 0) 	:= color5(11 downto 8); 		
		green_signal(3 downto 0):= color5(7 downto 4);  
		blue_signal(3 downto 0) := color5(3 downto 0); 
	END IF;
	
	IF(drawbox6='1')
	THEN
		red_signal(3 downto 0) 	:= color6(11 downto 8); 		
		green_signal(3 downto 0):= color6(7 downto 4);  
		blue_signal(3 downto 0) := color6(3 downto 0); 
	END IF;
	
	IF(drawbox7='1')
	THEN
		red_signal(3 downto 0) 	:= color7(11 downto 8); 		
		green_signal(3 downto 0):= color7(7 downto 4);  
		blue_signal(3 downto 0) := color7(3 downto 0); 
	END IF;
	
	IF(drawbox8='1')
	THEN
		red_signal(3 downto 0) 	:= color8(11 downto 8); 		
		green_signal(3 downto 0):= color8(7 downto 4);  
		blue_signal(3 downto 0) := color8(3 downto 0); 
	END IF;
	
	IF(drawbox9='1')
	THEN
		red_signal(3 downto 0) 	:= color9(11 downto 8); 		
		green_signal(3 downto 0):= color9(7 downto 4);  
		blue_signal(3 downto 0) := color9(3 downto 0); 
	END IF;
	
	IF(drawbox10='1')
	THEN
		red_signal(3 downto 0) 	:= color10(11 downto 8); 		
		green_signal(3 downto 0):= color10(7 downto 4);  
		blue_signal(3 downto 0) := color10(3 downto 0); 
	END IF;
	
	IF(drawbox11='1')
	THEN
		red_signal(3 downto 0) 	:= color11(11 downto 8); 		
		green_signal(3 downto 0):= color11(7 downto 4);  
		blue_signal(3 downto 0) := color11(3 downto 0); 
	END IF;
	
	IF(drawbox12='1')
	THEN
		red_signal(3 downto 0) 	:= color12(11 downto 8); 		
		green_signal(3 downto 0):= color12(7 downto 4);  
		blue_signal(3 downto 0) := color12(3 downto 0); 
	END IF;
	
	IF(drawbox13='1')
	THEN
		red_signal(3 downto 0) 	:= color13(11 downto 8); 		
		green_signal(3 downto 0):= color13(7 downto 4);  
		blue_signal(3 downto 0) := color13(3 downto 0); 
	END IF;
	
	IF(drawbox14='1')
	THEN
		red_signal(3 downto 0) 	:= color14(11 downto 8); 		
		green_signal(3 downto 0):= color14(7 downto 4);  
		blue_signal(3 downto 0) := color14(3 downto 0); 
	END IF;
	
	IF(drawbox15='1')
	THEN
		red_signal(3 downto 0) 	:= color15(11 downto 8); 		
		green_signal(3 downto 0):= color15(7 downto 4);  
		blue_signal(3 downto 0) := color15(3 downto 0); 
	END IF;
	
	IF(drawbox16='1')
	THEN
		red_signal(3 downto 0) 	:= color16(11 downto 8); 		
		green_signal(3 downto 0):= color16(7 downto 4);  
		blue_signal(3 downto 0) := color16(3 downto 0); 
	END IF;
		
------- FINE BOX

--- DISEGNO DI OGNI CARATTERE : GAME OVER
	IF (gameover = '1')
	THEN
		IF(drawGoG='1')
		THEN
			red_signal(3 downto 0) 	:= "0000"; 		
			green_signal(3 downto 0):= "0110";  
			blue_signal(3 downto 0) := "0101"; 
		END IF;
		IF(drawGoA='1')
		THEN
			red_signal(3 downto 0) 	:= "0000"; 		
			green_signal(3 downto 0):= "0110";  
			blue_signal(3 downto 0) := "0101";
		END IF;
		IF(drawGoM='1')
		THEN
			red_signal(3 downto 0) 	:= "0000"; 		
			green_signal(3 downto 0):= "0110";  
			blue_signal(3 downto 0) := "0101"; 
		END IF;
		IF(drawGoE='1')
		THEN
			red_signal(3 downto 0) 	:= "0000"; 		
			green_signal(3 downto 0):= "0110";  
			blue_signal(3 downto 0) := "0101";
		END IF;
		
		IF(drawGoO='1')
		THEN
			red_signal(3 downto 0) 	:= "0000"; 		
			green_signal(3 downto 0):= "0110";  
			blue_signal(3 downto 0) := "0101"; 
		END IF;
		IF(drawGoV='1')
		THEN
			red_signal(3 downto 0) 	:= "0000"; 		
			green_signal(3 downto 0):= "0110";  
			blue_signal(3 downto 0) := "0101"; 
		END IF;
		IF(drawGoE1='1')
		THEN
			red_signal(3 downto 0) 	:= "0000"; 		
			green_signal(3 downto 0):= "0110";  
			blue_signal(3 downto 0) := "0101";
		END IF;
		IF(drawGoR='1')
		THEN
			red_signal(3 downto 0) 	:= "0000"; 		
			green_signal(3 downto 0):= "0110";  
			blue_signal(3 downto 0) := "0101"; 
		END IF;
	END IF;
--- fine DISEGNO CHAR
-----------------------------------------------------------------------

	--Generazione segnale hsync (rispettando la specifica temporale di avere un ritardo "a" di 3.8 us fra un segnale e l'altro)
	--Infatti (659-639)/25000000 = 0.6 us, ossia il tempo di Front Porch "d". (755-659)/25000000 = 3.8, ossia il tempo "a"
	IF (h_cnt <= 755) AND (h_cnt >= 659) 
	THEN
		h_sync := '0';
	ELSE
		h_sync := '1';
	END IF;
	
	--Vertical Sync
	--Reset Vertical Counter. Non ci si ferma a 480 per rispettare le specifiche temporali
	--Infatti (524-479)= 45 = 2(a)+33(b)+10(d) righe
	IF (v_cnt >= 524) AND (h_cnt >= 699) 
	THEN
		v_cnt := 0;
	ELSIF (h_cnt = 699) 
		THEN
		v_cnt := v_cnt + 1;
	END IF;
	
	--Generazione segnale vsync (rispettando la specifica temporale di avere un ritardo "a" di due volte il tempo di riga us fra un segnale e l'altro)
	IF (v_cnt = 490 OR v_cnt = 491) 
	THEN
		v_sync := '0';	
	ELSE
		v_sync := '1';
	END IF;
	
	--Generazione Horizontal Data Enable (dati di riga validi, ossia nel range orizzontale 0-639)
	IF (h_cnt <= 639) 
	THEN
		horizontal_en := '1';
	ELSE
		horizontal_en := '0';
	END IF;
	
	--Generazione Vertical Data Enable (dati di riga validi, ossia nel range verticale 0-479)
	IF (v_cnt <= 479) 
	THEN
		vertical_en := '1';
	ELSE
		vertical_en := '0';
	END IF;
	
	video_en := horizontal_en AND vertical_en;

	-- Assegnamento segnali fisici a VGA
	red(0)		<= red_signal(0) AND video_en;
	green(0)  	<= green_signal(0) AND video_en;
	blue(0)		<= blue_signal(0) AND video_en;
	red(1)		<= red_signal(1) AND video_en;
	green(1)  	<= green_signal(1) AND video_en;
	blue(1)		<= blue_signal(1) AND video_en;
	red(2)		<= red_signal(2) AND video_en;
	green(2)    <= green_signal(2) AND video_en;
	blue(2)		<= blue_signal(2) AND video_en;
	red(3)		<= red_signal(3) AND video_en;
	green(3) 	<= green_signal(3) AND video_en;
	blue(3)		<= blue_signal(3) AND video_en;
	hsync		<= h_sync;
	vsync		<= v_sync;
	
END PROCESS;
END behavior;