library ieee;
use ieee.std_logic_1164.all;

entity FSM is
port(In1  : in    std_logic;
     RST  : in    std_logic;
     CLK  : in    std_logic;
     Out1 : inout std_logic);
end FSM;

ARCHITECTURE behavior OF FSM IS
	-- Enumerated Data Type for State
	TYPE STATE_TYPE IS ( state_A, state_B, state_C );
SIGNAL state: STATE_TYPE;
BEGIN
	PROCESS ( RST, CLK )
		BEGIN
		IF RST = '1' THEN             -- Reset State
		state <= state_A;
		ELSIF CLK 'EVENT AND CLK = '1' THEN
			CASE state IS               -- Define Next State Transitions using a Case
				WHEN state_A =>
				IF In1 = '0' THEN
				state <= state_A;
				ELSE
					state <= state_B;
				END IF;
				
				WHEN state_B =>
				IF In1 = '0' THEN
				state <= state_C;
				ELSE
					state <= state_B;
				END IF;
				
				WHEN state_C =>
				IF In1 = '0' THEN
				state <= state_C;
				ELSE
					state <= state_A;
				END IF;
				
				WHEN OTHERS =>
				state <= state_A;
			END CASE;
		END IF;
	END PROCESS;
	
	WITH state SELECT                   -- Define State Machine Outputs
	Out1 <= '0' WHEN state_A,
			'0' WHEN state_B,
			'1' WHEN state_C;
END behavior;