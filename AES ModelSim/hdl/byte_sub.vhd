library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity byte_sub is 
port(

	data_in : in std_logic_vector(127 downto 0);
	data_out : out std_logic_vector(127 downto 0)
);
end entity;


architecture behave of byte_sub is

begin

	gen: for i in 0 to 15 generate
		s_box_inst : entity work.s_box
			port map (
				input_byte  => data_in((i + 1)*8 - 1 downto i*8),
				output_byte => data_out((i + 1)*8 - 1 downto i*8)
			);
	end generate gen;


end behave;