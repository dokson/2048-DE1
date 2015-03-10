LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY GAME_VIEW IS
PORT
	(
		-- INPUTs
		clk			: IN STD_LOGIC;	
		
		northBorder : IN INTEGER range 0 to 500;
		southBorder : IN INTEGER range 0 to 500;
		westBorder 	: IN INTEGER range 0 to 1000;
		eastBorder 	: IN INTEGER range 0 to 1000;
		
		bootstrap	: IN STD_LOGIC;
		
		gameover 	: IN STD_LOGIC;
		victory		: IN STD_LOGIC;
		
		-- OUTPUTs
		hsync,
		vsync		: OUT STD_LOGIC;
		red, 
		green,
		blue		: OUT STD_LOGIC_VECTOR(3 downto 0);
		
		leds1 : OUT STD_LOGIC_VECTOR(6 downto 0); 	-- uscita 7 bit x 7 segmenti
		leds2 : OUT STD_LOGIC_VECTOR(6 downto 0); 	-- uscita 7 bit x 7 segmenti
		leds3 : OUT STD_LOGIC_VECTOR(6 downto 0); 	-- uscita 7 bit x 7 segmenti
		leds4 : OUT STD_LOGIC_VECTOR(6 downto 0) 	-- uscita 7 bit x 7 segmenti	
	); 
		
end  GAME_VIEW;

ARCHITECTURE behavior of  GAME_VIEW IS	
-- Sync Counters
shared variable h_cnt	: integer range 0 to 1000;
shared variable v_cnt  	: integer range 0 to 500;

signal drawbox1	: std_logic;
signal color1	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox2	: std_logic;
signal color2	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox3	: std_logic;
signal color3	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox4	: std_logic;
signal color4	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox5	: std_logic;
signal color5	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox6	: std_logic;
signal color6	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox7	: std_logic;
signal color7	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox8	: std_logic;
signal color8	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox9	: std_logic;
signal color9	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox10: std_logic;
signal color10	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox11: std_logic;
signal color11	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox12: std_logic;
signal color12	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox13: std_logic;
signal color13	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox14: std_logic;
signal color14	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox15: std_logic;
signal color15	: STD_LOGIC_VECTOR(11 downto 0);
signal drawbox16: std_logic;
signal color16	: STD_LOGIC_VECTOR(11 downto 0);
BEGIN

BOX1: entity work.GAME_BOX
	generic map
	(
		XPOS => 16,
		YPOS => 46
	)
	port map
	(
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 0,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 2,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 2,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 0,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 0,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 2,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 0,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 0,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 2,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 0,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 2,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 2,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 2,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 0,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 0,
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
		pixel_x => h_cnt,
		pixel_y => v_cnt,
		number 	=> 0,
		drawbox => drawbox16,
		color 	=> color16
	);

PROCESS

variable cntScrittaLampeggiante: integer range 0 to 16000000;
variable scrittaLampeggia: STD_LOGIC:='0';

-- costanti di utilit�
constant writePosition			: integer range 0 to 500:=300;

constant gameOver_g_Position	: integer range 0 to 1000:=282;
constant gameOver_a_Position	: integer range 0 to 1000:=288;
constant gameOver_m_Position	: integer range 0 to 1000:=294;
constant gameOver_e_Position	: integer range 0 to 1000:=300;
constant gameOver_o_Position	: integer range 0 to 1000:=312;
constant gameOver_v_Position	: integer range 0 to 1000:=318;
constant gameOver_e2_Position	: integer range 0 to 1000:=324;
constant gameOver_r_Position	: integer range 0 to 1000:=330;

constant youWin_y_Position	: integer range 0 to 1000:=288;
constant youWin_o_Position	: integer range 0 to 1000:=294;
constant youWin_u_Position	: integer range 0 to 1000:=300;
constant youWin_w_Position	: integer range 0 to 1000:=312;
constant youWin_i_Position	: integer range 0 to 1000:=318;
constant youWin_n_Position	: integer range 0 to 1000:=324;
constant youWin_e_Position	: integer range 0 to 1000:=330;		

-- bordi dello schermo
variable leftBorder		: integer range 0 to 1000;
variable rightBorder	: integer range 0 to 1000;
variable upBorder		: integer range 0 to 500;	
variable downBorder		: integer range 0 to 500;	

variable h_sync	: STD_LOGIC;
variable v_sync	: STD_LOGIC;

-- Enable del video
variable video_en		: STD_LOGIC; 
variable horizontal_en	: STD_LOGIC;
variable vertical_en	: STD_LOGIC;

-- Segnali colori RGB a 4 bit
variable red_signal		: std_logic_vector(3 downto 0); 
variable green_signal	: std_logic_vector(3 downto 0);
variable blue_signal	: std_logic_vector(3 downto 0);

BEGIN

WAIT UNTIL(clk'EVENT) AND (clk = '1');

		-- RESET
		IF (bootstrap='1')  
			THEN
			leds1 <= "0000000";
			leds2 <= "0000000";
			leds3 <= "0000000";
			leds4 <= "0000000";
			upBorder:= northBorder;
			downBorder:= southBorder;
			leftBorder:= westBorder;
			rightBorder:= eastBorder;
		END IF;


		--Horizontal Sync
		
		--Reset Horizontal Counter	
		-- (resettato al valore 799, anzich� 640, per rispettare i tempi di Front Porch)
		-- Infatti (799-639)/25000000 = 3.6 us = 3.8(a)+1.9(b)+0.6(d)	
		IF (h_cnt = 799) 
			THEN
				h_cnt := 0;
			ELSE
				h_cnt := h_cnt + 1;
		END IF;

		--Sfondo
		IF (v_cnt >= 0) AND (v_cnt <= 479) 
		THEN
			red_signal(3) 	:= '1'; red_signal(2) 	:= '0';	red_signal(1) 	:= '1'; red_signal(0) 	:= '1';		
			green_signal(3) := '1'; green_signal(2) := '0'; green_signal(1) := '1'; green_signal(0) := '1';
			blue_signal(3) 	:= '1'; blue_signal(2) 	:= '0';	blue_signal(1) 	:= '1';	blue_signal(0) 	:= '1';	
		END IF;	
		
-----------------------------------------------------------------------
------- DISEGNO DI OGNI BOX
		
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
-----------------------------------------------------------------------


-----------------------------------------------------------------------
-- DA CAMBIARE
		IF(gameover='1') 
		THEN
		-- GAME OVER draw
		--G
			IF (((v_cnt = writePosition OR v_cnt = 310)) AND ((h_cnt >= gameOver_g_Position+1) AND (h_cnt <= gameOver_g_Position+3))) OR
				(((h_cnt = gameOver_g_Position+4 )) AND ((v_cnt = writePosition+1) OR (v_cnt = writePosition+9) OR (v_cnt = writePosition+8) OR (v_cnt = writePosition+7))) OR
				(((h_cnt = gameOver_g_Position )) AND ((v_cnt >= writePosition+1) AND (v_cnt <= writePosition+9))) OR
				(((v_cnt = writePosition+7 )) AND ((h_cnt >= gameOver_g_Position+2) AND (h_cnt <= gameOver_g_Position+4))) THEN
					red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
					green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
					blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';			
			END IF;
		-- fine G
		--A
			IF (((v_cnt = writePosition OR v_cnt = writePosition+5)) AND ((h_cnt >= gameOver_a_Position+1) AND (h_cnt <= gameOver_a_Position+3))) OR
			(((h_cnt = gameOver_a_Position OR h_cnt = gameOver_a_Position+4)) AND ((v_cnt >= writePosition+1) AND (v_cnt <= 310))) THEN
					red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
					green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
					blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';			
			END IF;
		-- fine A
		--M
			IF (((h_cnt = gameOver_m_Position OR h_cnt = gameOver_m_Position+4)) AND ((v_cnt >= writePosition) AND (v_cnt <= 310))) OR
			(((h_cnt = gameOver_m_Position+1 OR h_cnt = gameOver_m_Position+3) AND (v_cnt >= writePosition+1) AND (v_cnt <= writePosition+2)) )OR
			((h_cnt = gameOver_m_Position+2) AND (v_cnt >= writePosition+2) AND (v_cnt <= writePosition+3)) OR 
			((h_cnt = gameOver_m_Position+2) AND (v_cnt >= writePosition+2) AND (v_cnt <= writePosition+3)) THEN
					red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
					green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
					blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';			
			END IF;
		-- fine M
		--E
			IF (((v_cnt = writePosition OR v_cnt = 310)) AND ((h_cnt >= gameOver_e_Position) AND (h_cnt <= gameOver_e_Position+4))) OR
			(((v_cnt = writePosition+5)) AND ((h_cnt >= gameOver_e_Position) AND (h_cnt <= gameOver_e_Position+3)))OR 
			(((h_cnt = gameOver_e_Position)) AND ((v_cnt >= writePosition) AND (v_cnt <= 310)))THEN
					red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
					green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
					blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';			
			END IF;
		-- fine E
		--0
			IF (((v_cnt = writePosition OR v_cnt = 310)) AND ((h_cnt >= gameOver_o_Position+1) AND (h_cnt <= gameOver_o_Position+3))) OR
				(((h_cnt = gameOver_o_Position OR h_cnt = gameOver_o_Position+4)) AND ((v_cnt >= writePosition+1) AND (v_cnt <= writePosition+9))) THEN
					red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
					green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
					blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';			
			END IF;
		-- fine 0
		--V
			IF ((v_cnt >= writePosition AND v_cnt <= writePosition+5) AND ((h_cnt = gameOver_v_Position) OR (h_cnt = gameOver_v_Position+4))) OR
				((v_cnt >= writePosition+5 AND v_cnt <= writePosition+7) AND ((h_cnt = gameOver_v_Position+1) OR (h_cnt = gameOver_v_Position+3))) OR 
				((v_cnt >= writePosition+8 AND v_cnt <= 310) AND ((h_cnt = gameOver_v_Position+2))) THEN
					red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
					green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
					blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';			
			END IF;
		-- fine V
		--E
			IF (((v_cnt = writePosition OR v_cnt = 310)) AND ((h_cnt >= gameOver_e2_Position) AND (h_cnt <= gameOver_e2_Position+4))) OR
			(((v_cnt = writePosition+5)) AND ((h_cnt >= gameOver_e2_Position) AND (h_cnt <= gameOver_e2_Position+3))) OR
			(((h_cnt = gameOver_e2_Position)) AND ((v_cnt >= writePosition) AND (v_cnt <= 310))) THEN
					red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
					green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
					blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';			
			END IF;
		-- fine E
		--R
			IF ((v_cnt >= writePosition AND v_cnt<=310) AND ((h_cnt = gameOver_r_Position))) OR
				((v_cnt = writePosition OR v_cnt = writePosition+5  OR v_cnt = writePosition+7 ) AND ((h_cnt = gameOver_r_Position+1))) OR
				((v_cnt = writePosition OR v_cnt = writePosition+5  OR v_cnt = writePosition+8 ) AND ((h_cnt = gameOver_r_Position+2))) OR
				((v_cnt = writePosition OR v_cnt = writePosition+4  OR v_cnt = writePosition+9 ) AND ((h_cnt = gameOver_r_Position+3))) OR
				((v_cnt = writePosition+1 OR v_cnt = writePosition+2 OR v_cnt = writePosition+3  OR v_cnt = 310 ) AND ((h_cnt = gameOver_r_Position+4))) THEN
					red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
					green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
					blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';			
			END IF;
		-- fine R
		
		END IF;
		-- fine GAME OVER draw
		
		-- You Win
		IF(victory='1') 
		THEN
		--Y
			IF (((v_cnt = writePosition)) AND ((h_cnt = youWin_y_Position) OR (h_cnt = youWin_y_Position+4))) OR
			(((v_cnt = writePosition+1)) AND ((h_cnt = youWin_y_Position+1) OR (h_cnt = youWin_y_Position+3)))OR 
			(((h_cnt = youWin_y_Position+2)) AND ((v_cnt >= writePosition+2) AND (v_cnt <= 310)))THEN
				red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
				green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
				blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';			
			END IF;
		-- fine Y
	--0
		IF (((v_cnt = writePosition OR v_cnt = 310)) AND ((h_cnt >= youWin_o_Position+1) AND (h_cnt <= youWin_o_Position+3))) OR
			(((h_cnt = youWin_o_Position OR h_cnt = youWin_o_Position+4)) AND ((v_cnt >= writePosition+1) AND (v_cnt <= writePosition+9))) THEN
				red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
				green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
				blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';			
		END IF;
	-- fine 0			
		--U
			IF (((v_cnt = 310)) AND ((h_cnt >= youWin_u_Position+1) AND (h_cnt <= youWin_u_Position+3))) OR 
			(((h_cnt = youWin_u_Position OR h_cnt = youWin_u_Position+4)) AND ((v_cnt >= writePosition) AND (v_cnt <= writePosition+9))) THEN
				red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
				green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
				blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';			
			END IF;
		-- fine U		
		--W
			IF (((h_cnt = youWin_w_Position OR h_cnt = youWin_w_Position+4)) AND ((v_cnt >= writePosition) AND (v_cnt <= writePosition+9))) OR
				(((h_cnt = youWin_w_Position+1 OR h_cnt = youWin_w_Position+3)) AND ((v_cnt = 310)))OR 
				(((h_cnt = youWin_w_Position+2)) AND ((v_cnt >= writePosition+6) AND v_cnt<=writePosition+9))THEN
					red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
					green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
					blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';			
			END IF;

		-- fine W	
		--I
			IF (((v_cnt = writePosition OR v_cnt = 310)) AND ((h_cnt >= youWin_i_Position+1) AND (h_cnt <= youWin_i_Position+3))) OR
				(((h_cnt = youWin_i_Position+2)) AND ((v_cnt >= writePosition) AND (v_cnt <= 310))) THEN
				red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
				green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
				blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';			
			END IF;
		-- fine I	
		--N
			IF (((h_cnt = youWin_n_Position OR h_cnt = youWin_n_Position+4)) AND ((v_cnt >=writePosition) AND (v_cnt <= 310))) OR
				((h_cnt = youWin_n_Position+1) AND (v_cnt >= writePosition+1) AND (v_cnt <= writePosition+2)) OR
				(((h_cnt = youWin_n_Position+2) AND (v_cnt >= writePosition+3) AND (v_cnt <= writePosition+4))) OR
				((h_cnt = youWin_n_Position+3) AND (v_cnt >= writePosition+5) AND (v_cnt <= writePosition+6)) THEN
				red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
				green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
				blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';	
			END IF;
		-- fine N			
		--!
			IF (((v_cnt >= writePosition AND v_cnt<writePosition+8)) AND ((h_cnt = youWin_e_Position+3) )) OR
				(((v_cnt = 310)) AND ((h_cnt = youWin_e_Position+3) )) THEN
				red_signal(3) := '0';		red_signal(2) := '0';		red_signal(1) := '0';		red_signal(0) := '0';		
				green_signal(3) := '1';	green_signal(2) := '0';	green_signal(1) := '0';	green_signal(0) := '0';
				blue_signal(3) := '1';	blue_signal(2) := '0';	blue_signal(1) := '0';	blue_signal(0) := '0';			
			END IF;
		-- fine !
						
		END IF;
		--You Win

------- FINE SCRITTE
-----------------------------------------------------------------------		


---BORDO SCHERMO

	--BORDO LEFT
		IF ((h_cnt <= leftBorder)  AND ((v_cnt >= upBorder) AND (v_cnt <= downBorder))) 
		THEN
			red_signal(3) 	:= '1'; red_signal(2) 	:= '0';	red_signal(1) 	:= '0'; red_signal(0) 	:= '0';		
			green_signal(3) := '1'; green_signal(2) := '0'; green_signal(1) := '0'; green_signal(0) := '0';
			blue_signal(3) 	:= '1'; blue_signal(2) 	:= '0';	blue_signal(1) 	:= '0';	blue_signal(0) 	:= '0';		
		END IF;
	-- fine LEFT
			
			
	-- RIGHT
		IF ((h_cnt >= RightBorder)  AND ((v_cnt >= upBorder) AND (v_cnt <= downBorder))) 
		THEN
			red_signal(3) 	:= '1'; red_signal(2) 	:= '0';	red_signal(1) 	:= '0'; red_signal(0) 	:= '0';		
			green_signal(3) := '1'; green_signal(2) := '0'; green_signal(1) := '0'; green_signal(0) := '0';
			blue_signal(3) 	:= '1'; blue_signal(2) 	:= '0';	blue_signal(1) 	:= '0';	blue_signal(0) 	:= '0';		
		END IF;
	-- fine RIGHT
			
	-- UP				
		IF ((v_cnt <= upBorder)) 
		THEN
			red_signal(3) 	:= '1'; red_signal(2) 	:= '0';	red_signal(1) 	:= '0'; red_signal(0) 	:= '0';		
			green_signal(3) := '1'; green_signal(2) := '0'; green_signal(1) := '0'; green_signal(0) := '0';
			blue_signal(3) 	:= '1'; blue_signal(2) 	:= '0';	blue_signal(1) 	:= '0';	blue_signal(0) 	:= '0';			
		END IF;
	-- fine UP

	--DOWN
		IF ((v_cnt >= downBorder)) THEN
			red_signal(3) 	:= '1'; red_signal(2) 	:= '0';	red_signal(1) 	:= '0'; red_signal(0) 	:= '0';		
			green_signal(3) := '1'; green_signal(2) := '0'; green_signal(1) := '0'; green_signal(0) := '0';
			blue_signal(3) 	:= '1'; blue_signal(2) 	:= '0';	blue_signal(1) 	:= '0';	blue_signal(0) 	:= '0';			
		END IF;
	-- fine DOWN

--- fine BORDO SCHERMO

---------------------------------------------------------------
-- 			Draw Grid Logic
---------------------------------------------------------------

--gridOn <= '1' when ((unsigned(pixel_y) > 40 and unsigned(pixel_y) <= 440) and (unsigned(pixel_x) > 120 and unsigned(pixel_x) <=520)) 
	--else '0';


	--Generazione segnale hsync (rispettando la specifica temporale di avere un ritardo "a" di 3.8 us fra un segnale e l'altro)
	--Infatti (659-639)/25000000 = 0.6 us, ossia il tempo di Front Porch "d". (755-659)/25000000 = 3.8, ossia il tempo "a"
	IF (h_cnt <= 755) AND (h_cnt >= 659) THEN
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

	-- prova A
	--leds2 <= not"1110111";
	-- prova C
	--leds4 <= not"0111001";
	
	case gameover is
		when '0' => -- CIAO
			leds1 <= not"0111111"; -- C
			leds2 <= not"1110111"; -- I
			leds3 <= not"0000110"; -- A
			leds4 <= not"0111001"; -- O
		when '1' => -- OVER
			leds1 <= not"1010000"; -- O
			leds2 <= not"1111001"; -- U
			leds3 <= not"0111110"; -- E
			leds4 <= not"0111111"; -- P
		when others => 
			NULL;
	end case;
	
END PROCESS;
END behavior;