LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.GAME_TYPES.ALL;

-- Definizioni delle funzioni contenute nel package
PACKAGE GAME_UTILS IS
	FUNCTION digit_to7seg (A:INTEGER) 
		RETURN STD_LOGIC_VECTOR;
	FUNCTION reverse (A: IN STD_LOGIC_VECTOR) 
		RETURN STD_LOGIC_VECTOR;
	FUNCTION isGameOver (values: GAME_GRID)
		RETURN STD_LOGIC;
	FUNCTION isVictory (values: GAME_GRID)
		RETURN STD_LOGIC;
END GAME_UTILS;
 
PACKAGE BODY GAME_UTILS IS

-- Conversione da cifra a vettore di bit per 7 segmenti
FUNCTION digit_to7seg (A:INTEGER) RETURN STD_LOGIC_VECTOR IS
	-- Risultato: uscita 7 bit per 7 segmenti
	VARIABLE RESULT: STD_LOGIC_VECTOR(6 downto 0);
BEGIN
	CASE A IS
		WHEN 0 => RESULT:="1000000";
		WHEN 1 => RESULT:="1111001";
		WHEN 2 => RESULT:="0100100";
		WHEN 3 => RESULT:="0110000";
		WHEN 4 => RESULT:="0011001";
		WHEN 5 => RESULT:="0010010";
		WHEN 6 => RESULT:="0000010";
		WHEN 7 => RESULT:="1111000";
		WHEN 8 => RESULT:="0000000";
		WHEN 9 => RESULT:="0010000";
		WHEN OTHERS => RESULT:=(OTHERS=>'0');
	END CASE;
	RETURN RESULT;
END digit_to7seg;

-- Inversione di un generico vettore
FUNCTION reverse (A: IN STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
	-- Risultato: vettore della stessa dimensione del vettore d'ingresso
	VARIABLE RESULT	: STD_LOGIC_VECTOR(A'RANGE);
	ALIAS AA		: STD_LOGIC_VECTOR(A'REVERSE_RANGE) IS A;
BEGIN
	FOR i IN AA'RANGE LOOP
		RESULT(i) := AA(i);
	END LOOP;
	RETURN RESULT;
END reverse;

-- Funz. che stabilisce se la partita � stata persa oppure no
FUNCTION isGameOver(values: GAME_GRID) RETURN std_logic IS
variable result: std_logic := '1';
BEGIN
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			if(values(i,j) = 0)
			then
				result := '0';
			end if;
		end loop;
	end loop;
	return result;
END FUNCTION isGameOver;

--Funz. che stabilisce se la partita � terminata con la vittoria
FUNCTION isVictory(values: GAME_GRID) RETURN std_logic IS
variable result: std_logic := '0';
BEGIN
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			if(values(i,j) = 2048)
			then
				result := '1';
			end if;
		end loop;
	end loop;
	return result;
END FUNCTION isVictory;

END GAME_UTILS;