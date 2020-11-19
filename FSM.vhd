library ieee;
use ieee.std_logic_1164.all;

	entity FSM is
	port( CLK, RESET : in std_logic ;
	      EDGE_DETECTOR_INPUT   : in std_logic_vector  (1 downto 0) ;
	      COUNTER_INPUT_STAGE  : out std_logic_vector (1 downto 0));
	end entity FSM ;

		architecture FSM of FSM is
		
		type state_type is ( init,first,sec,third,fourth,fifth,six,full);
		
		signal current_state : state_type;
		signal  next_state   : state_type;
		
		begin
			cs : process (CLK,RESET) is begin
				if  RESET = '1' then current_state <=init;
				elsif  rising_edge (CLK) then current_state <= next_state;
				end if;
				end process cs;
			ns : process (current_state,EDGE_DETECTOR_INPUT) is begin
			
			case current_state is
				
				when init=>
				if EDGE_DETECTOR_INPUT="00" then
				COUNTER_INPUT_STAGE <= "00" ;
				next_state<= init;

				elsif EDGE_DETECTOR_INPUT="01" then
				COUNTER_INPUT_STAGE <= "01"; 
				next_state<= init;

				elsif EDGE_DETECTOR_INPUT="10" then
				COUNTER_INPUT_STAGE <= "10";
				next_state<= first;

				else 
				COUNTER_INPUT_STAGE  <= "11";
				next_state<= init;
				end if ;

				when first=>
				if EDGE_DETECTOR_INPUT="00" then
				COUNTER_INPUT_STAGE <= "00"; 
				next_state<= first;

				elsif EDGE_DETECTOR_INPUT="01" then
				COUNTER_INPUT_STAGE <= "01"; 
				next_state<= init;

				elsif EDGE_DETECTOR_INPUT="10" then
				COUNTER_INPUT_STAGE <= "10"; 
				next_state<= sec;

				else 
				COUNTER_INPUT_STAGE <= "00";
				next_state<= first;
				end if ;

				when sec=>
				if  EDGE_DETECTOR_INPUT="00" then
				COUNTER_INPUT_STAGE <= "00"; 
				next_state<= sec;

				elsif EDGE_DETECTOR_INPUT="01" then
				COUNTER_INPUT_STAGE <= "01";
				next_state<= first;

				elsif EDGE_DETECTOR_INPUT="10" then
				COUNTER_INPUT_STAGE <= "10"; 
				next_state<= third;

				else 
				COUNTER_INPUT_STAGE <="00";
				next_state<= sec;
				end if ;

				when third=>
				if  EDGE_DETECTOR_INPUT="00" then
				COUNTER_INPUT_STAGE <= "00";
				next_state<= third;

				elsif EDGE_DETECTOR_INPUT="01" then
				COUNTER_INPUT_STAGE <= "01";
				next_state<= sec;

				elsif EDGE_DETECTOR_INPUT="10" then
				COUNTER_INPUT_STAGE <= "10";
				next_state<= fourth;

				else 
				COUNTER_INPUT_STAGE <="00"; 
				next_state<= third;
				end if ;

				when fourth=>
				if EDGE_DETECTOR_INPUT="00" then
				COUNTER_INPUT_STAGE <= "00";
				next_state<= fourth;

				elsif EDGE_DETECTOR_INPUT="01" then
				COUNTER_INPUT_STAGE <= "01"; 
				next_state<= third;

				elsif EDGE_DETECTOR_INPUT="10" then
				COUNTER_INPUT_STAGE <= "10";
				next_state<= fifth;

				else 
				COUNTER_INPUT_STAGE <="00"; 
				next_state<= fourth;
				end if ;

				when fifth=>
				if EDGE_DETECTOR_INPUT="00" then
				COUNTER_INPUT_STAGE <= "00";
				next_state<= fifth; 

				elsif EDGE_DETECTOR_INPUT="01" then
				COUNTER_INPUT_STAGE <= "01"; 
				next_state<= fourth;

				elsif EDGE_DETECTOR_INPUT="10" then
				COUNTER_INPUT_STAGE <= "10";
				next_state<= six;

				else 
				COUNTER_INPUT_STAGE <= "00"; 
				next_state<= fifth;
				end if ;

				when six=>
				if EDGE_DETECTOR_INPUT="00" then
				COUNTER_INPUT_STAGE <= "00";
				next_state<= six;

				elsif EDGE_DETECTOR_INPUT="01" then
				COUNTER_INPUT_STAGE <= "01";
				next_state<= fifth;

				elsif EDGE_DETECTOR_INPUT="10" then
				COUNTER_INPUT_STAGE <= "10"; 
				next_state<= full;

				else 
				COUNTER_INPUT_STAGE <="00"; 
				next_state<= six;
				end if ;

				when full=>
				if  EDGE_DETECTOR_INPUT="00" then
				COUNTER_INPUT_STAGE <= "00";
				next_state<= full;

				elsif EDGE_DETECTOR_INPUT="01" then
				COUNTER_INPUT_STAGE <= "01"; 
				next_state<= six;

				elsif EDGE_DETECTOR_INPUT="10" then
				COUNTER_INPUT_STAGE <= "10";
				next_state<= full;

				else 
				COUNTER_INPUT_STAGE <= "10"; 
				next_state<= full;
				end if ;

			end case;
		end process ns;
	end architecture FSM;

