LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.GAME_TYPES.ALL;

ENTITY GAME_RANDOMGEN IS
PORT
	( 
		clk : IN  STD_LOGIC;
		random_num : OUT INTEGER
	 );
			 
END GAME_RANDOMGEN;

ARCHITECTURE behavior of GAME_RANDOMGEN IS

BEGIN

PROCESS(clk)
variable rand_temp : std_logic_vector(GRID_WIDTH-1 downto 0):=("1000");
variable temp : std_logic := '0';
BEGIN
	if(rising_edge(clk)) then
		temp := rand_temp(GRID_WIDTH-1) xor rand_temp(GRID_WIDTH-2);
		rand_temp(GRID_WIDTH-1 downto 1) := rand_temp(GRID_WIDTH-2 downto 0);
		rand_temp(0) := temp;
	end if;
	random_num <= to_integer(unsigned(rand_temp));
end process;

end behavior;