library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity main is

port(

rst_n : in std_logic;
load : in std_logic;
clk : in std_logic;

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
hex_17_sig : out std_logic;

hex_20_sig : out std_logic;
hex_21_sig : out std_logic;
hex_22_sig : out std_logic;
hex_23_sig : out std_logic;
hex_24_sig : out std_logic;
hex_25_sig : out std_logic;
hex_26_sig : out std_logic;
hex_27_sig : out std_logic;

hex_30_sig : out std_logic;
hex_31_sig : out std_logic;
hex_32_sig : out std_logic;
hex_33_sig : out std_logic;
hex_34_sig : out std_logic;
hex_35_sig : out std_logic;
hex_36_sig : out std_logic;
hex_37_sig : out std_logic;

hex_40_sig : out std_logic;
hex_41_sig : out std_logic;
hex_42_sig : out std_logic;
hex_43_sig : out std_logic;
hex_44_sig : out std_logic;
hex_45_sig : out std_logic;
hex_46_sig : out std_logic;
hex_47_sig : out std_logic;

hex_50_sig : out std_logic;
hex_51_sig : out std_logic;
hex_52_sig : out std_logic;
hex_53_sig : out std_logic;
hex_54_sig : out std_logic;
hex_55_sig : out std_logic;
hex_56_sig : out std_logic;
hex_57_sig : out std_logic


);
end entity;

architecture behave of main is
 
 signal data : std_logic_vector(127 downto 0);
 signal hex_data_0 : std_logic_vector(3 downto 0);
 signal hex_data_1 : std_logic_vector(3 downto 0);
 signal hex_data_2 : std_logic_vector(3 downto 0);
 signal hex_data_3 : std_logic_vector(3 downto 0);
 signal hex_data_4 : std_logic_vector(3 downto 0);
 signal hex_data_5 : std_logic_vector(3 downto 0);
 signal hex_data_6 : std_logic_vector(3 downto 0);

	component byteSub_display_sys is
		port (
			bytesub_0_avalon_streaming_sink_data : in  std_logic_vector(127 downto 0) := (others => 'X'); -- data
			clk_clk                              : in  std_logic                      := 'X';             -- clk
			reset_reset_n                        : in  std_logic                      := 'X';             -- reset_n
			divider_0_data_out_1_data            : out std_logic_vector(3 downto 0);                      -- data
			divider_0_data_out_2_data            : out std_logic_vector(3 downto 0);                      -- data
			divider_0_data_out_3_data            : out std_logic_vector(3 downto 0);                      -- data
			divider_0_data_out_4_data            : out std_logic_vector(3 downto 0);                      -- data
			divider_0_data_out_5_data            : out std_logic_vector(3 downto 0);                      -- data
			divider_0_data_out_6_data            : out std_logic_vector(3 downto 0)                       -- data
		);
	end component byteSub_display_sys; 
 
	component display
		port(
			data_in : in std_logic_vector(3 downto 0);
			hex_0 : out std_logic;
			hex_1 : out std_logic;
			hex_2 : out std_logic;
			hex_3 : out std_logic;
			hex_4 : out std_logic;
			hex_5 : out std_logic;
			hex_6 : out std_logic;
			hex_7 : out std_logic
		);
	end component;

 begin
 
 u0 : component byteSub_display_sys
		port map (
			bytesub_0_avalon_streaming_sink_data => data, -- bytesub_0_avalon_streaming_sink.data
			clk_clk                              => clk,                              --                             clk.clk
			reset_reset_n                        => rst_n,                        --                           reset.reset_n
			divider_0_data_out_1_data            => hex_data_0,            --            divider_0_data_out_1.data
			divider_0_data_out_2_data            => hex_data_1,            --            divider_0_data_out_2.data
			divider_0_data_out_3_data            => hex_data_2,            --            divider_0_data_out_3.data
			divider_0_data_out_4_data            => hex_data_3,            --            divider_0_data_out_4.data
			divider_0_data_out_5_data            => hex_data_4,            --            divider_0_data_out_5.data
			divider_0_data_out_6_data            => hex_data_5             --            divider_0_data_out_6.data
		);
 
 d0 : display port map (
					data_in => hex_data_0, 
					hex_0 => hex_0_sig,
					hex_1 => hex_1_sig,
					hex_2 => hex_2_sig,
					hex_3 => hex_3_sig,
					hex_4 => hex_4_sig,
					hex_5 => hex_5_sig,
					hex_6 => hex_6_sig,
					hex_7 => hex_7_sig
				);
 d1 : display port map (
					data_in => hex_data_1, 
					hex_0 => hex_10_sig,
					hex_1 => hex_11_sig,
					hex_2 => hex_12_sig,
					hex_3 => hex_13_sig,
					hex_4 => hex_14_sig,
					hex_5 => hex_15_sig,
					hex_6 => hex_16_sig,
					hex_7 => hex_17_sig
				);

 d2 : display port map (
					data_in => hex_data_2, 
					hex_0 => hex_20_sig,
					hex_1 => hex_21_sig,
					hex_2 => hex_22_sig,
					hex_3 => hex_23_sig,
					hex_4 => hex_24_sig,
					hex_5 => hex_25_sig,
					hex_6 => hex_26_sig,
					hex_7 => hex_27_sig
				);
 d3 : display port map (
					data_in => hex_data_3, 
					hex_0 => hex_30_sig,
					hex_1 => hex_31_sig,
					hex_2 => hex_32_sig,
					hex_3 => hex_33_sig,
					hex_4 => hex_34_sig,
					hex_5 => hex_35_sig,
					hex_6 => hex_36_sig,
					hex_7 => hex_37_sig
				);
 d4 : display port map (
					data_in => hex_data_4, 
					hex_0 => hex_40_sig,
					hex_1 => hex_41_sig,
					hex_2 => hex_42_sig,
					hex_3 => hex_43_sig,
					hex_4 => hex_44_sig,
					hex_5 => hex_45_sig,
					hex_6 => hex_46_sig,
					hex_7 => hex_47_sig
				);
 d5 : display port map (
					data_in => hex_data_5, 
					hex_0 => hex_50_sig,
					hex_1 => hex_51_sig,
					hex_2 => hex_52_sig,
					hex_3 => hex_53_sig,
					hex_4 => hex_54_sig,
					hex_5 => hex_55_sig,
					hex_6 => hex_56_sig,
					hex_7 => hex_57_sig
				);
 
hex_0_sig <= hex_data_0(0);
hex_1_sig <= hex_data_0(1);
hex_2_sig <= hex_data_0(2);
hex_3_sig <= hex_data_0(3);
hex_4_sig <= hex_data_0(4);
hex_5_sig <= hex_data_0(5);


	process (clk)
	begin
	if rising_edge(clk) then
		if rst_n = '0' then
			
			hex_data_5 <= (others => '0');
		else

		end if;
	end if;
	
	end process;
	


end behave;