LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

ENTITY RAM128_32 IS
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END RAM128_32;

ARCHITECTURE behavior OF RAM128_32 IS
	TYPE memory_type IS ARRAY(0 to 127) of STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL memory : memory_type ;
BEGIN
	-- Read Memory and convert array index to an integer with TO_INTEGER
	q <= memory( TO_INTEGER( UNSIGNED( address ) ) );
	
	PROCESS -- Write Memory
	BEGIN
		WAIT UNTIL rising_edge(clock);
		IF ( wren = '1' ) THEN
		-- convert array index to an integer with TO_INTEGER
		memory( TO_INTEGER( UNSIGNED( address ) ) ) <= data;
		END IF;
	END PROCESS;
END behavior;