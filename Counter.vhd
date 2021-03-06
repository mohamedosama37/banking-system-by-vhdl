library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

	entity counter is
		
		port(up_down : in std_logic_VECTOR(1 DOWNTO 0);
			d_out: out STD_LOGIC_VECTOR (2 downto 0);
		      CLK : std_logic);
	end entity counter;

		architecture behav of counter is
			signal s_counter: STD_LOGIC_VECTOR (2 downto 0):="000";
		begin
			ct: process (CLK) is begin
					
					if up_down = "00"  then
						s_counter <= s_counter;
				
					elsif up_down = "10" THEN 
						if s_counter ="111" then
							s_counter <=s_counter;
						else
						s_counter <= s_counter + "1";
						end if ;
					elsif up_down = "01"  then
						if s_counter ="000" then
							s_counter <=s_counter;
						else
						s_counter <= s_counter - "1" ;
						end if ;
					elsif up_down = "11"   then
						s_counter <= "000";
					end if;
				
			end process ct;
		        d_out <= s_counter ;
		end architecture behav;
					