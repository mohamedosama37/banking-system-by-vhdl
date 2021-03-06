LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


			ENTITY SBQM_SYSTEM IS
			GENERIC( 
			N : POSITIVE :=3
			);

			PORT	(
			RESET, CLK: IN STD_LOGIC;
			PHOTOCELL	:IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			ROM_OUT_DECODER_1: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
			ROM_OUT_DECODER_2: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
			PCOUNT_OUT_DECODER_3: OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
			TCOUNT_IN_ENCODER: IN STD_LOGIC_VECTOR (1 DOWNTO 0)
			);

			END SBQM_SYSTEM ;

	ARCHITECTURE BEHAV OF  SBQM_SYSTEM  IS
		
	
			COMPONENT ROM_READ_FILE
			PORT	(  
			ENABLE   : IN  STD_LOGIC ;   --READ SIGNAL
			ADDRESS  : IN  STD_LOGIC_VECTOR ( 4 DOWNTO 0);
			OUT_DATA : OUT STD_LOGIC_VECTOR( 7 DOWNTO 0));
				END COMPONENT ROM_READ_FILE;
			FOR ALL: ROM_READ_FILE USE ENTITY work.ROM_READ_FILE (ROM_BEHAVIOURAL);
			
			COMPONENT counter
					port(
					up_down : in std_logic_VECTOR(1 DOWNTO 0);
					d_out: out STD_LOGIC_VECTOR ((n-1) downto 0);
					CLK : std_logic);
					end COMPONENT counter;
			FOR ALL: counter USE ENTITY work.counter (behav);
			
			COMPONENT EDGE_DETECTOR
				port (
				CLK              : in  std_logic;
				RESET            : in  std_logic;
				IN_PHOTOCELL     : in  std_logic_VECTOR(1 DOWNTO 0);
				OUTPUT_EDGE      : out std_logic_VECTOR(1 DOWNTO 0));

				end COMPONENT EDGE_DETECTOR;
			FOR ALL :EDGE_DETECTOR USE ENTITY work.EDGE_DETECTOR (BEHAV);
			

			COMPONENT BCD_7SEGMENT IS 
				
				Port ( 	BCDin : in STD_LOGIC_VECTOR (3 downto 0);
				Seven_Segment : out STD_LOGIC_VECTOR (6 downto 0));
				
				END COMPONENT BCD_7SEGMENT;
			FOR ALL: BCD_7SEGMENT USE ENTITY work.BCD_7SEGMENT (BEHAVIORAL);
			
			COMPONENT FSM
				port( CLK, RESET : in std_logic ;
				EDGE_DETECTOR_INPUT   : in std_logic_VECTOR  (1 downto 0) ;
				COUNTER_INPUT_STAGE  : out std_logic_VECTOR (1 downto 0));
				end COMPONENT FSM ;
			FOR ALL :FSM USE ENTITY work.FSM   (FSM);
			
			
----------------------------------------------------------------------SIGNALS-----------------------------------------------------------------
			
			SIGNAL S_OUT_PHOTOCELL:  std_logic_VECTOR(1 DOWNTO 0);
			SIGNAL S_OUT_FSM      : std_logic_VECTOR (1 downto 0);
			SIGNAL S_OUT_COUNTER  : STD_LOGIC_VECTOR (2 DOWNTO 0);
			SIGNAL S_IN_BCD       : STD_LOGIC_VECTOR (3 DOWNTO 0);
			SIGNAL S_EN_ROM       : STD_LOGIC; 
			SIGNAL S_OUT_ROM      : STD_LOGIC_VECTOR(7 DOWNTO 0); 
			SIGNAL S_ROM_ADDRESS  : STD_LOGIC_VECTOR (4 DOWNTO 0);
			
-----------------------------------------------------------------------------PORT MAPING--------------------------------------------------------------------			
				BEGIN
					ED_DE:EDGE_DETECTOR
					PORT MAP( CLK, RESET,PHOTOCELL, S_OUT_PHOTOCELL);

					FSM_OUT:FSM
					PORT MAP (CLK,RESET,S_OUT_PHOTOCELL,S_OUT_FSM);

					COUNT_IN:counter
					PORT MAP (S_OUT_FSM,S_OUT_COUNTER,CLK);

					S_IN_BCD <= '0' & S_OUT_COUNTER ;

					BCD_OUT :BCD_7SEGMENT
					PORT MAP (S_IN_BCD,PCOUNT_OUT_DECODER_3);

					ROM_1_BDC_7SEG: BCD_7SEGMENT
					PORT MAP(S_OUT_ROM (3 DOWNTO 0), ROM_OUT_DECODER_1(6 DOWNTO 0));

					ROM_2_BDC_7SEG: BCD_7SEGMENT
					PORT MAP(S_OUT_ROM (7 DOWNTO 4), ROM_OUT_DECODER_2(6 DOWNTO 0));

					ROM:ROM_READ_FILE
					PORT MAP(S_EN_ROM, S_ROM_ADDRESS (4 DOWNTO 0),S_OUT_ROM(7 DOWNTO 0));

						S_EN_ROM <= '1';

						S_ROM_ADDRESS <= TCOUNT_IN_ENCODER (1 DOWNTO 0) & S_OUT_COUNTER(2 DOWNTO 0);
 

				
	END ARCHITECTURE BEHAV ;
				
				