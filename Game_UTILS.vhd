LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.GAME_TYPES.ALL;

-- Definizioni delle funzioni e delle procedure contenute nel package
PACKAGE GAME_UTILS IS
	FUNCTION digit_to7seg (A: INTEGER) 
		RETURN STD_LOGIC_VECTOR;
	FUNCTION reverse (A: STD_LOGIC_VECTOR) 
		RETURN STD_LOGIC_VECTOR;
	FUNCTION isGameOver (values: GAME_GRID)
		RETURN STD_LOGIC;
	FUNCTION isVictory (values: GAME_GRID)
		RETURN STD_LOGIC;
	PROCEDURE convertCoord 
	(
		SIGNAL position: IN INTEGER; 
		VARIABLE X, Y: OUT INTEGER RANGE 0 TO 3
	);
END GAME_UTILS;
 
PACKAGE BODY GAME_UTILS IS

-- Conversione da cifra a vettore di bit per 7 segmenti
FUNCTION digit_to7seg (A: INTEGER) RETURN STD_LOGIC_VECTOR IS
	-- Risultato: uscita 7 bit per 7 segmenti
	VARIABLE RESULT: STD_LOGIC_VECTOR(6 downto 0);
BEGIN
	CASE A IS
		-- Logica negativa
		WHEN 0 	=> RESULT := NOT"0111111";
		WHEN 1 	=> RESULT := NOT"0000110";
		WHEN 2 	=> RESULT := NOT"1011011";
		WHEN 3 	=> RESULT := NOT"1001111";
		WHEN 4 	=> RESULT := NOT"1100110";
		WHEN 5 	=> RESULT := NOT"1101101";
		WHEN 6 	=> RESULT := NOT"1111101";
		WHEN 7 	=> RESULT := NOT"0000111";
		WHEN 8 	=> RESULT := NOT"1111111";
		WHEN 9 	=> RESULT := NOT"1101111";
		WHEN 
		OTHERS 	=> RESULT := NOT"0000000";
	END CASE;
	RETURN RESULT;
END digit_to7seg;

-- Inversione di un generico vettore
FUNCTION reverse (A: STD_LOGIC_VECTOR) RETURN STD_LOGIC_VECTOR IS
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
	variable result			: STD_LOGIC	:= '1';
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
	variable result			: STD_LOGIC := '0';
	constant victory_score 	: INTEGER 	:= 2048;
BEGIN
	-- Controlla in tutte le celle se � stato raggiunto il valore necessario per la vittoria
	for i in 0 to 3 loop
		for j in 0 to 3 loop
			if(values(i,j) = victory_score)
			then
				result := '1';
			end if;
		end loop;
	end loop;
	return result;
END FUNCTION isVictory;

PROCEDURE convertCoord (SIGNAL position: IN INTEGER; VARIABLE X, Y: OUT INTEGER RANGE 0 TO 3) IS
BEGIN
	case position is
		when 1 =>
			x := 0;
			y := 0;
		when 2 =>
			x := 0;
			y := 1;
		when 3 =>
			x := 0;
			y := 2;
		when 4 =>
			x := 0;
			y := 3;
		when 5 =>
			x := 1;
			y := 0;
		when 6 =>
			x := 1;
			y := 1;
		when 7 =>
			x := 1;
			y := 2;
		when 8 =>
			x := 1;
			y := 3;
		when 9 =>
			x := 2;
			y := 0;
		when 10 =>
			x := 2;
			y := 1;
		when 11 =>
			x := 2;
			y := 2;
		when 12 =>
			x := 2;
			y := 3;
		when 13 =>
			x := 3;
			y := 0;
		when 14 =>
			x := 3;
			y := 1;
		when 15 =>
			x := 3;
			y := 2;
		when 16 =>
			x := 3;
			y := 3;
		when others =>
			NULL;
	end case;
END convertCoord;

END GAME_UTILS;