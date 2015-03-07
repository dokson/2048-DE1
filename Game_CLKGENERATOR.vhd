library ieee;
use  ieee.std_logic_1164.all;
use  ieee.std_logic_arith.all;
use  ieee.std_logic_unsigned.all;

ENTITY GAME_CLKGENERATOR  IS

	PORT(	clock : IN STD_LOGIC;
			clock_mezzi : OUT STD_LOGIC
		);
END GAME_CLKGENERATOR;

ARCHITECTURE Behavioral  OF GAME_CLKGENERATOR  IS

SIGNAL cnt : STD_LOGIC_VECTOR(0 DOWNTO 0);

BEGIN
	PROCESS (clock)
		BEGIN
			IF clock = '0' AND clock'event THEN 
				cnt <= cnt + 1;
			END IF;
	END PROCESS;
	
	clock_mezzi <= cnt(0);

END Behavioral;