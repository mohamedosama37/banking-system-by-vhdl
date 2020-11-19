library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;

	entity ROM_READ_FILE is 
		generic ( n:	integer :=5;
			  m:	integer :=8);
		port(   ENABLE : in STD_LOGIC ; 
         		ADDRESS: in std_logic_vector (n-1 downto 0);
		        OUT_DATA: out std_logic_vector (m-1 downto 0));
	end entity ROM_READ_FILE;
	
		architecture ROM_BEHAVIOURAL of ROM_READ_FILE is 
			type rm is array (0 to 2**n-1) of std_logic_vector (m-1 downto 0);
				 impure function rom_fill return rm is 
					variable memory: rm;
					file f: text open READ_MODE is "rom.txt";
					variable l : line;
				begin
					for index in memory' range loop
						readline(f,l);
						read(l, memory(index));
					end loop;
					return memory;
				end function rom_fill;
			constant word: rm := rom_fill ;
		begin
			memory: process (ENABLE, ADDRESS) is begin
				if ENABLE = '1' then
					OUT_DATA <= word (conv_integer (ADDRESS));
				else
					OUT_DATA <= (others => 'Z');
				end if;
			end process memory;
		end architecture ROM_BEHAVIOURAL;
		