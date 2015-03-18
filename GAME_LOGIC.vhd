LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.GAME_TYPES.ALL;

PACKAGE GAME_LOGIC IS
	FUNCTION moveRight (values: GAME_GRID)
		RETURN GAME_GRID;
	FUNCTION moveLeft (values: GAME_GRID) 
		RETURN GAME_GRID;
	FUNCTION moveUp (values: GAME_GRID)
		RETURN GAME_GRID;
	FUNCTION moveDown (values: GAME_GRID)
		RETURN GAME_GRID;
END GAME_LOGIC;


PACKAGE BODY GAME_LOGIC IS

FUNCTION moveRight(values: GAME_GRID) return GAME_GRID IS
variable result : GAME_GRID;
BEGIN
	result := values;
	return result;
END moveRight;

FUNCTION moveLeft(values: GAME_GRID) return GAME_GRID IS
variable result : GAME_GRID;
BEGIN
	result := values;
	return result;
END moveLeft;

FUNCTION moveUp(values: GAME_GRID) return GAME_GRID IS
variable result : GAME_GRID;
BEGIN
	result := values;
	return result;
END moveUp;

FUNCTION moveDown(values: GAME_GRID) return GAME_GRID IS
variable result : GAME_GRID;
BEGIN
	result := values;
	return result;
END moveDown;


END GAME_LOGIC;