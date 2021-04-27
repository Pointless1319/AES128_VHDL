-- this is a temporary working file 
-- need to implement a fifo for master read ( i think)
-- detect if fifo is full or empty
-- read from fifo must be controlled

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity interface_controller is
  generic (
    INTERFACE_WIDTH : integer := 8; -- change in tcl file [8,16,32]
    INTERFACE_LENGTH : natural := 1; -- change in tcl file [0-n]
    INTERFACE_ADDR_WIDTH : natural := 3;
  );
  port (
    clk, rst : in std_logic;
	
	-- control & status registers (CSR) slave
	interface_0_avalon_slave_1_read          : in std_logic;
	interface_0_avalon_slave_1_write         : in std_logic;
	interface_0_avalon_slave_1_waitrequest   : out std_logic;  
	interface_0_avalon_slave_1_address       : in std_logic_vector(INTERFACE_ADDR_WIDTH - 1 downto 0);                  -- address
	interface_0_avalon_slave_1_byteenable    : in std_logic_vector(INTERFACE_BYTE_ENABLE - 1 downto 0);                 -- byteenable
	interface_0_avalon_slave_1_readdata      : out  std_logic_vector(INTERFACE_WIDTH - 1 downto 0) := (others => 'X'); 	-- readdata
	interface_0_avalon_slave_1_writedata     : in  std_logic_vector(INTERFACE_WIDTH - 1 downto 0) := (others => 'X'); 	-- readdata
	
	key        : out  std_logic_vector(127 downto 0);
	plaintext  : out  std_logic_vector(127 downto 0);
	ciphertext : in std_logic_vector(127 downto 0);
	done       : in std_logic														-- valid st
  
  );
end interface_controller;


architecture behave of interface_controller is

subtype word_t is std_logic_vector(INTERFACE_WIDTH - 1  downto 0);
type register_t is array(integer range <>) of word_t;


-- state machine states
type read_states_T is (idle, running, stopping);
type write_states_T is (idle, running, stopping);
signal read_state : read_states_T;
signal write_state : write_states_T;

signal data_temp : std_logic_vector (INTERFACE_WIDTH - 1 downto 0); 
signal data_temp_AES : std_logic_vector (127 downto 0);

--CSR initial values
function init_csr
  return register_t is
  variable temp: register_t(INTERFACE_LENGTH - 1 downto 0);
  begin
	--entire table set to '0'
    temp := (others => (others => '0'));
    return temp;
  end init_csr;

signal csr_reg: register_t := init_csr;

-- aliasy do obszarów w csr
alias control_reg:   std_logic_vector(INTERFACE_WIDTH - 1 downto 0)  is csr_reg(0);
alias key_reg:  std_logic_vector(INTERFACE_WIDTH - 1 downto 0)  is csr_reg(4 downto 1);
alias  plain_text_reg :  std_logic_vector(INTERFACE_WIDTH - 1 downto 0)	is csr_reg(8 downto 5);

-- aliasy do bitów w obrzarach
alias encrypt_decrypt : std_logic_vector is control_reg(0);         -- used to start the DMA (when logic 1)
alias start_flag : std_logic_vector is control_reg(2);         -- logic 1 if either state machines are active
alias end_flag : std_logic_vector is control_reg(3);         -- logic 1 if either state machines are active
alias csr_rl ead : std_logic_vector is control_reg(4);         -- logic 1 if either state machines are active
alias engaged : std_logic_vector is control_reg(5);         -- if 1 then controller is busy

signal out_waitrequest : std_logic;

begin

-------------------------------------------------------------------------------
-- THE READ SLAVE STATE MACHINE
-------------------------------------------------------------------------------
read_master_fifo: process (clk, rst)
begin
	if rst = '1' then
		read_state <= idle;
	elsif rising_edge (clk) then
	
		case read_state is
			
			when idle =>
				if write_state = idle and interface_0_avalon_slave_1_read = '1' then
					master_fifo_read_state <= running;
					interface_0_avalon_slave_1_waitrequest <= '1';
					data_temp <= csr_reg(to_integer(unsigned(interface_0_avalon_slave_1_address)))
				end if;
				
			when running =>
				interface_0_avalon_slave_1_waitrequest <= '0';
				interface_0_avalon_slave_1_readdata < data_temp;
				master_fifo_read_state <= stopping;
				
			when stopping =>
				data_temp <= (others => '0')
				master_fifo_read_state <= idle;
		
		end case;
	end if;
end process;

-------------------------------------------------------------------------------
-- THE WRITE SLAVE STATE MACHINE
-------------------------------------------------------------------------------

read_master: process (clk, rst)
begin
	if rst = '1' then
		write_state <= idle;
		
	elsif rising_edge (clk) then
		case master_read_state is
		
			when idle =>
			
					interface_0_avalon_master_1_readdata
				if read_state = idle and interface_0_avalon_slave_1_write = '1' then
					write_state <= running;			
					interface_0_avalon_slave_1_waitrequest <= '1';
				end if;
	
			when running =>	
			
				interface_0_avalon_slave_1_waitrequest <= '0';			
				csr_reg(to_integer(unsigned(interface_0_avalon_slave_1_address))) <= interface_0_avalon_slave_1_writedata;
								
			when stopping =>
		
				master_read_state <= idle;
		
		end case;
	end if;
end process;

-------------------------------------------------------------------------------
-- THE WRITE MASTER STATE MACHINE
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- CSR PROCESS
-------------------------------------------------------------------------------

csr: process (clk, rst)
begin
	if rst = '1' then
		csr_reg = init_csr;
	elsif rising_edge (clk) then
		case encrypt_decrypt is
			when '1' =>
				if start_flag = '1' then
					key <= key_reg;
					plaintext <= plain_text_reg;
				end if;
					
			when '0' =>
				if start_flag = '1' then
				end if;


			end case;
	end if;
end process;	

end architecture behave;
