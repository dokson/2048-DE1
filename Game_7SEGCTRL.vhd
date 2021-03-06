LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.GAME_UTILS.ALL;

entity Game_7SEGCTRL is
	port
	(
		-- INPUT
		num			: IN INTEGER RANGE 0 TO 9999;
		
		-- OUTPUT 
		seven_segs4,
		seven_segs3,
		seven_segs2,
		seven_segs1	: OUT STD_LOGIC_VECTOR(6 downto 0)
	);
end Game_7SEGCTRL;

architecture arch of Game_7SEGCTRL is
	
begin
	numChange : process(num)
		variable digit4, digit3, digit2, digit1	: integer range 0 to 9;
	begin
		splitNumber(num, digit4, digit3, digit2, digit1);
		
		seven_segs4 <= digit_to_7seg(digit4);
		seven_segs3 <= digit_to_7seg(digit3);
		seven_segs2 <= digit_to_7seg(digit2);
		seven_segs1 <= digit_to_7seg(digit1);
	end process numChange;
END arch;