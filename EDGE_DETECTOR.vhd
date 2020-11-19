 library ieee;
use ieee.std_logic_1164.all;

entity EDGE_DETECTOR is
port (
  CLK              : in  std_logic;
  RESET            : in  std_logic;
  IN_PHOTOCELL     : in  std_logic_VECTOR(1 DOWNTO 0);
  OUTPUT_EDGE      : out std_logic_VECTOR(1 DOWNTO 0));
  
end EDGE_DETECTOR;

architecture BEHAV of EDGE_DETECTOR is
     signal r_input   : std_logic_VECTOR(1 downto 0);
    

	begin

		p_rising_edge_detector : process(CLK,RESET)
		begin
		  if(RESET='1') then
		    r_input    <= "11";
		  elsif(rising_edge(CLK)) then
		    r_input     <= IN_PHOTOCELL;
		   
		  end if;
		end process p_rising_edge_detector;

		OUTPUT_EDGE <= r_input;
	

end BEHAV;
