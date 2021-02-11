library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity main is

port(

rst_n : in std_logic;
load : in std_logic;
clk : in std_logic;

hex_0_sig_n : out std_logic;
hex_1_sig_n : out std_logic;
hex_2_sig_n : out std_logic;
hex_3_sig_n : out std_logic;
hex_4_sig_n : out std_logic;
hex_5_sig_n : out std_logic;
hex_6_sig_n : out std_logic;
hex_7_sig_n : out std_logic;

hex_10_sig_n : out std_logic;
hex_11_sig_n : out std_logic;
hex_12_sig_n : out std_logic;
hex_13_sig_n : out std_logic;
hex_14_sig_n : out std_logic;
hex_15_sig_n : out std_logic;
hex_16_sig_n : out std_logic;
hex_17_sig_n : out std_logic;

hex_20_sig_n : out std_logic;
hex_21_sig_n : out std_logic;
hex_22_sig_n : out std_logic;
hex_23_sig_n : out std_logic;
hex_24_sig_n : out std_logic;
hex_25_sig_n : out std_logic;
hex_26_sig_n : out std_logic;
hex_27_sig_n : out std_logic;

hex_30_sig_n : out std_logic;
hex_31_sig_n : out std_logic;
hex_32_sig_n : out std_logic;
hex_33_sig_n : out std_logic;
hex_34_sig_n : out std_logic;
hex_35_sig_n : out std_logic;
hex_36_sig_n : out std_logic;
hex_37_sig_n : out std_logic;

hex_40_sig_n : out std_logic;
hex_41_sig_n : out std_logic;
hex_42_sig_n : out std_logic;
hex_43_sig_n : out std_logic;
hex_44_sig_n : out std_logic;
hex_45_sig_n : out std_logic;
hex_46_sig_n : out std_logic;
hex_47_sig_n : out std_logic;

hex_50_sig_n : out std_logic;
hex_51_sig_n : out std_logic;
hex_52_sig_n : out std_logic;
hex_53_sig_n : out std_logic;
hex_54_sig_n : out std_logic;
hex_55_sig_n : out std_logic;
hex_56_sig_n : out std_logic;
hex_57_sig_n : out std_logic


);
end entity;

architecture behave of main is
 
 signal data : std_logic_vector(127 downto 0);
 signal hex_data_0 : std_logic_vector(7 downto 0);
 signal hex_data_1 : std_logic_vector(7 downto 0);
 signal hex_data_2 : std_logic_vector(7 downto 0);


	component byteSub_display_sys is
		port (
			bytesub_0_avalon_streaming_sink_data : in  std_logic_vector(127 downto 0) := (others => 'X'); -- data
			clk_clk                              : in  std_logic                      := 'X';             -- clk
			reset_reset_n                        : in  std_logic                      := 'X';             -- reset_n
			byte_div_0_data_out_0_data           : out std_logic_vector(7 downto 0);                      -- data
			byte_div_0_data_out_1_data           : out std_logic_vector(7 downto 0);                      -- data
			byte_div_0_data_out_2_data           : out std_logic_vector(7 downto 0)                       -- data
		);
	end component byteSub_display_sys;
 
	component control_display
		port(
			rst_n : in std_logic := 'X';
			clk : in std_logic := 'X';
			
			data_in : in std_logic_vector(7 downto 0) := (others => 'X');

			hex_0_sig : out std_logic;
			hex_1_sig : out std_logic;
			hex_2_sig : out std_logic;
			hex_3_sig : out std_logic;
			hex_4_sig : out std_logic;
			hex_5_sig : out std_logic;
			hex_6_sig : out std_logic;
			hex_7_sig : out std_logic;

			hex_10_sig : out std_logic;
			hex_11_sig : out std_logic;
			hex_12_sig : out std_logic;
			hex_13_sig : out std_logic;
			hex_14_sig : out std_logic;
			hex_15_sig : out std_logic;
			hex_16_sig : out std_logic;
			hex_17_sig : out std_logic
		);
	end component;

 begin
 
 u0 : component byteSub_display_sys
		port map (
			bytesub_0_avalon_streaming_sink_data => data, -- bytesub_0_avalon_streaming_sink.data
			clk_clk                              => clk,                              --                             clk.clk
			reset_reset_n                        => rst_n,                        --                           reset.reset_n
			byte_div_0_data_out_0_data           => hex_data_0,           --           byte_div_0_data_out_0.data
			byte_div_0_data_out_1_data           => hex_data_1,           --           byte_div_0_data_out_1.data
			byte_div_0_data_out_2_data           => hex_data_2            --           byte_div_0_data_out_2.data
		);
 
 d0 : control_display port map (
					rst_n => rst_n,
					clk => clk,
			
					data_in => hex_data_0,

					hex_0_sig => hex_0_sig_n,
					hex_1_sig => hex_1_sig_n,
					hex_2_sig => hex_2_sig_n,
					hex_3_sig => hex_3_sig_n,
					hex_4_sig => hex_4_sig_n,
					hex_5_sig => hex_5_sig_n,
					hex_6_sig => hex_6_sig_n,
					hex_7_sig => hex_7_sig_n,

					hex_10_sig => hex_10_sig_n,
					hex_11_sig => hex_11_sig_n,
					hex_12_sig => hex_12_sig_n,
					hex_13_sig => hex_13_sig_n,
					hex_14_sig => hex_14_sig_n,
					hex_15_sig => hex_15_sig_n,
					hex_16_sig => hex_16_sig_n,
					hex_17_sig => hex_17_sig_n
				);
d1 : control_display port map (
					rst_n => rst_n,
					clk => clk,
			
					data_in => hex_data_1,

					hex_0_sig => hex_20_sig_n,
					hex_1_sig => hex_21_sig_n,
					hex_2_sig => hex_22_sig_n,
					hex_3_sig => hex_23_sig_n,
					hex_4_sig => hex_24_sig_n,
					hex_5_sig => hex_25_sig_n,
					hex_6_sig => hex_26_sig_n,
					hex_7_sig => hex_27_sig_n,

					hex_10_sig => hex_30_sig_n,
					hex_11_sig => hex_31_sig_n,
					hex_12_sig => hex_32_sig_n,
					hex_13_sig => hex_33_sig_n,
					hex_14_sig => hex_34_sig_n,
					hex_15_sig => hex_35_sig_n,
					hex_16_sig => hex_36_sig_n,
					hex_17_sig => hex_37_sig_n
				);
d2 : control_display port map (
					rst_n => rst_n,
					clk => clk,
			
					data_in => hex_data_2,

					hex_0_sig => hex_40_sig_n,
					hex_1_sig => hex_41_sig_n,
					hex_2_sig => hex_42_sig_n,
					hex_3_sig => hex_43_sig_n,
					hex_4_sig => hex_44_sig_n,
					hex_5_sig => hex_45_sig_n,
					hex_6_sig => hex_46_sig_n,
					hex_7_sig => hex_47_sig_n,

					hex_10_sig => hex_50_sig_n,
					hex_11_sig => hex_51_sig_n,
					hex_12_sig => hex_52_sig_n,
					hex_13_sig => hex_53_sig_n,
					hex_14_sig => hex_54_sig_n,
					hex_15_sig => hex_55_sig_n,
					hex_16_sig => hex_56_sig_n,
					hex_17_sig => hex_57_sig_n
				);

 --data<=x"01010202010102020101020201010202";

	process (clk)
	begin
	if rising_edge(clk) then
		if rst_n = '0' then
			hex_data_0 <= "00000000";
			--hex_data_1 <= "00000000";
			--hex_data_2 <= "00000000";
		else
			hex_data_0 <= data(7 downto 0);
			--hex_data_1 <= data(15 downto 8);
			--hex_data_2 <= data(23 downto 16);
		end if;
	end if;
	
	end process;
	


end behave;