LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY GAME_CONTROL IS
PORT
	(   
		clk		: IN STD_LOGIC;
		
		keyboardData: IN STD_LOGIC_VECTOR (7 downto 0);
		goingReady: IN STD_LOGIC;
		
		enable: OUT STD_LOGIC;
		boot: OUT STD_LOGIC;
		movepadDirection: OUT STD_LOGIC_VECTOR(3 downto 0) -- usiamo 4 bit anche se ne basterebbero 2 per descrivere le 4 direzioni
	);
end  GAME_CONTROL;

ARCHITECTURE behavior of  GAME_CONTROL IS

BEGIN
	
	
PROCESS

constant BOOTSTRAP: STD_LOGIC_VECTOR (1 downto 0):="00";
constant PLAYING: STD_LOGIC_VECTOR (1 downto 0):="01";
constant PAUSED: STD_LOGIC_VECTOR (1 downto 0):="11";
constant READY: STD_LOGIC_VECTOR (1 downto 0):="10";

variable state: STD_LOGIC_VECTOR (1 downto 0):=BOOTSTRAP;

variable start: std_logic:='0';

constant keyRESET: std_logic_vector(7 downto 0):="00101101";
constant keyPLAY: std_logic_vector(7 downto 0):="00101001";
constant keyPAUSE: std_logic_vector(7 downto 0):="01001101";
constant keyRIGHT: std_logic_vector(7 downto 0):="01110100";
constant keyLEFT: std_logic_vector(7 downto 0):="01101011";
constant keyUP 	: std_logic_vector(7 downto 0):="01110010";
constant keyDOWN : std_logic_vector(7 downto 0):="01110101";

constant dirUP : std_logic_vector(3 downto 0):="1000";
constant dirDOWN : std_logic_vector(3 downto 0):="0001";
constant dirLEFT : std_logic_vector(3 downto 0):="0100";
constant dirRIGHT : std_logic_vector(3 downto 0):="0010";


BEGIN
WAIT UNTIL(clk'EVENT) AND (clk = '1');
		
	case state IS
		when BOOTSTRAP => 
			boot<='1';
			IF(keyboardData=keyPLAY) THEN
				state:=PLAYING;
				boot<='0';
				enable<='1';
			END IF;
		
		when PLAYING =>
			case keyboardData is
				when keyRIGHT => -- do move right
					movepadDirection <= dirRIGHT;
				when keyLEFT => -- do move left
					movepadDirection <= dirLEFT;
				when KEYUP => -- do move right
					movepadDirection <= dirUP;
				when KEYDOWN => -- do move left
					movepadDirection <= dirDOWN;
				when others => -- do nothing
					NULL;
			end case;	
			
			IF(keyboardData=keyRESET) 
			THEN
				enable<='0';
				boot<='1';
				state:=BOOTSTRAP;
			END IF;
			
			IF(keyboardData=keyPAUSE) 
			THEN
				enable<='0';
				state:=PAUSED;
			END IF;	
			
			IF (goingReady='1') THEN state:=READY; END IF;
			
		when PAUSED =>
			IF(keyboardData=keyRESET)
			THEN
				enable<='0';
				boot<='1';
				state:=BOOTSTRAP;
			END IF;
			
			IF(keyboardData=keyPLAY)
			THEN
				enable<='1';
				state:=PLAYING;
				boot<='0';
			END IF;
			
			IF (goingReady='1') 
			THEN
				state:=READY; 
			END IF;
			
		when READY => 
			enable<='0';
			IF(keyboardData=keyPLAY) THEN
				state:=PLAYING;
				boot<='0';
				enable<='1';
			END IF;
			IF(keyboardData=keyRESET) THEN
				enable<='0';
				boot<='1';
				state:=BOOTSTRAP;
			END IF;
	END case;
	
END PROCESS;
END behavior;