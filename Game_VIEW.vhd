LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY GAME_VIEW IS
PORT
	(
		-- INPUTs
		clk			: IN STD_LOGIC;	
		
		upBorder 	: IN INTEGER RANGE 0 to 500;
		downBorder 	: IN INTEGER RANGE 0 to 500;
		leftBorder 	: IN INTEGER RANGE 0 to 1000;
		rightBorder : IN INTEGER RANGE 0 to 1000;
		
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

-- Segnali per il disegno dei caratteri su schermo
signal charAddr : STD_LOGIC_VECTOR(6 downto 0); -- Indirizzo del carattere sulla ROM
signal rowAddr	: STD_LOGIC_VECTOR(3 downto 0); -- Numero della riga di pixel del singolo carattere (0-15)
signal charOut 	: STD_LOGIC_VECTOR(7 downto 0); -- Vettore di visualizzazione del carattere alla linea impostata

BEGIN

CHROM: entity work.GAME_CHROM
	port map
	(
		char_addr 	=> charAddr,
		row_addr	=> rowAddr,
		data 		=> charOut
	);

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
	-- RESET
	IF (bootstrap='1')  
		THEN
		leds1 <= "0000000";
		leds2 <= "0000000";
		leds3 <= "0000000";
		leds4 <= "0000000";
	END IF;

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
		red_signal 	:= "1011";
		green_signal:= "1011";
		blue_signal	:= "1011";	
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
-----------------------------------------------------------------------

	IF(	v_cnt >= writePositionV AND -- limite alto del carattere
		v_cnt < writePositionV+16 AND -- limite basso del carattere
		h_cnt >= writeColaceH AND -- limite sinistro del carattere
		h_cnt < writeColaceH+9) -- limite destro del carattere
	THEN
		rowAddr	 <= std_logic_vector(to_unsigned(v_cnt-writePositionV, 4)); 
		charAddr <= "1000011"; -- C
		
		if(charOut(h_cnt-writeColaceH-1) = '1')
		then
			red_signal 	:= "0101";
			green_signal:= "1111";
			blue_signal	:= "0101";
		end if;
	END IF;
	
	IF(	v_cnt >= writePositionV AND -- limite alto del carattere
		v_cnt < writePositionV+16 AND -- limite basso del carattere
		h_cnt >= writeColaceH+distanceChar AND -- limite sinistro del carattere
		h_cnt < writeColaceH+distanceChar+9) -- limite destro del carattere
	THEN
		rowAddr	 <= std_logic_vector(to_unsigned(v_cnt-writePositionV, 4)); 
		charAddr <= "1000111"; -- G
		
		if(charOut(h_cnt-writeColaceH+distanceChar-1) = '1')
		then
			red_signal 	:= "0101";
			green_signal:= "1111";
			blue_signal	:= "0101";
		end if;
	END IF;

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