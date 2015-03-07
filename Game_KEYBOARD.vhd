library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity GAME_KEYBOARD is
    Port 
		( 	
			clk : in STD_LOGIC;
			keyboardClock : in  STD_LOGIC;
			keyboardData : in  STD_LOGIC;
			keyCode: out std_logic_vector(7 downto 0)
		);
end GAME_KEYBOARD;

architecture Behavioral of GAME_KEYBOARD is

signal bitCount : integer range 0 to 100 := 0;
signal scancodeReady : STD_LOGIC := '0';
signal scancode : STD_LOGIC_VECTOR(7 downto 0);
signal breakReceived : STD_LOGIC_VECTOR(1 downto 0) := "00";

begin

	Keyboard : process(keyboardClock)
	begin
		if falling_edge(keyboardClock) then
			if bitCount = 0 and keyboardData = '0' then -- la tastiera vuole mandare dati
				scancodeReady <= '0';
				bitCount <= bitCount + 1;
			elsif bitCount > 0 and bitCount < 9 then -- shift di un bit nello scancode da sinistra
				scancode <= keyboardData & scancode(7 downto 1);
				bitCount <= bitCount + 1;
			elsif bitCount = 9 then -- bit di parità
				bitCount <= bitCount + 1;
			elsif bitCount = 10 then -- fine messaggio
				scancodeReady <= '1';
				bitCount <= 0;
			end if;
		end if;		
	end process Keyboard;
	
	
	DataSend : process(scancodeReady, scancode)
	begin
		if scancodeReady'event and scancodeReady = '1' then
			-- breakcode interrompe lo scancode corrente (sollevamento dito dal tasto)
			case breakReceived is
			when "00" => 
				if scancode = "11110000" 
				then -- segno il breakcode per il prossimo scancode
					breakReceived <= "01";
				end if;
				keyCode<=scancode;			
			when "01" =>
				breakReceived <= "10";
				keyCode <= "11110000";
			when "10" => 
				breakReceived <= "00";
				keyCode <= "11110000";
			when others => 
				keyCode<=scancode;
			end case;
		end if;
	end process DataSend;
	
	
end Behavioral;
