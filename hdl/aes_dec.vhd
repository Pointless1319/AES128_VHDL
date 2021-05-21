library ieee;
use ieee.std_logic_1164.all;

entity aes_dec is
	port (
		clk : in std_logic;
		rst : in std_logic;
		dec_key : in std_logic_vector(127 downto 0);
		ciphertext : in std_logic_vector(127 downto 0);
		plaintext : out std_logic_vector(127 downto 0);
		done : out std_logic
	);
end aes_dec;

architecture rtl of aes_dec is
	signal mux_output : std_logic_vector(127 downto 0);
	signal reg_output : std_logic_vector(127 downto 0);
	signal dec_mix_input : std_logic_vector(127 downto 0);
	signal dec_mix_output : std_logic_vector(127 downto 0);
	signal invsr_input : std_logic_vector(127 downto 0);
	signal invsb_input : std_logic_vector(127 downto 0);
	signal feedback : std_logic_vector(127 downto 0);
	signal round_key : std_logic_vector(127 downto 0);
	signal round_const : std_logic_vector(7 downto 0);
	signal is_first_round : std_logic;
begin
	mux_output <= ciphertext when rst = '0' else feedback;
	reg_inst : entity work.reg
		generic map(
			size => 128
		)
		port map(
			clk => clk,
			d   => mux_output,
			q   => reg_output
		);
	
	add_round_key_inst : entity work.add_round_key
		port map(
			input1 => reg_output,
			input2 => round_key,
			output => dec_mix_input
		);
	dec_mix_column_inst : entity work.dec_mix_column
		port map(
			input_data  => dec_mix_input,
			output_data => dec_mix_output
		);	
	invsr_input <= dec_mix_input when is_first_round = '1' else dec_mix_output;
	dec_shft_row_inst : entity work.dec_shft_row
		port map(
			input  => invsr_input,
			output => invsb_input
		);
	
	inv_sub_byte_inst : entity work.dec_byte_sub
		port map(
			input_data  => invsb_input,
			output_data => feedback
		);	
	 key_schedule_inst : entity work.key_schedule
	 	port map(
	 		clk         => clk,
	 		rst         => rst,
	 		key         => dec_key,
	 		round_const => round_const,
	 		round_key   => round_key
	 	);
	 controller_inst : entity work.controller
	 	port map(
	 		clk            => clk,
	 		rst            => rst,
	 		rconst         => round_const,
	 		is_final_round => is_first_round,
	 		done           => done
	 	);
	 plaintext <= dec_mix_input;
end architecture rtl;