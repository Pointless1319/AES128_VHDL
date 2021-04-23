-- this is a temporary working file
-- need to implement a fifo for master read ( i think)
-- detect if fifo is full or empty
-- read from fifo must be controlled

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity interface_controller is
  generic (
    INTERFACE_WIDTH : integer := 32; -- change in tcl file [8,16,32]
    INTERFACE_LENGTH : natural := 32; -- change in tcl file [0-n]
    INTERFACE_ADDR_WIDTH : natural := 4;
	INTERFACE_BYTE_ENABLE : integer := 4
  );
  port (
    clk, rst : in std_logic;
	-- master connected to AES
	interface_0_avalon_master_1_read          : out std_logic;  	
	interface_0_avalon_master_1_waitrequest   : in std_logic;  
	interface_0_avalon_master_1_address       : out std_logic_vector(INTERFACE_ADDR_WIDTH - 1 downto 0);                -- address
	interface_0_avalon_master_1_byteenable    : out std_logic_vector(INTERFACE_BYTE_ENABLE - 1 downto 0);               -- byteenable
	interface_0_avalon_master_1_readdata      : in  std_logic_vector(INTERFACE_WIDTH - 1 downto 0) := (others => 'X');  -- readdata
	
	
	-- control & status registers (CSR) slave
	interface_0_avalon_slave_1_write          : in std_logic;
	interface_0_avalon_slave_1_waitrequest   : out std_logic :='1';  
	interface_0_avalon_slave_1_address       : in std_logic_vector(INTERFACE_ADDR_WIDTH - 1 downto 0);                  -- address
	interface_0_avalon_slave_1_byteenable    : in std_logic_vector(INTERFACE_BYTE_ENABLE - 1 downto 0);                 -- byteenable
	interface_0_avalon_slave_1_writedata      : in  std_logic_vector(INTERFACE_WIDTH - 1 downto 0) := (others => 'X') 	-- readdata
	
	--interface_0_avalon_streaming_source_data  : out std_logic_vector(INTERFACE_ADDR_WIDTH - 1 downto 0);                -- data st
	--interface_0_avalon_streaming_source_ready : in  std_logic                      := 'X';             					-- ready st
	--interface_0_avalon_streaming_source_valid : out std_logic															-- valid st
  
  );
end interface_controller;


architecture behave of interface_controller is

subtype word_t is std_logic_vector(INTERFACE_WIDTH - 1  downto 0);
type register_t is array(integer range <>) of word_t;


-- state machine states
type read_states_T is (idle, running, stopping);
type write_states_T is (idle, running);
signal master_read_state : read_states_T;
signal master_write_state : write_states_T;

signal slave_write_state : read_states_T;

type data_states is (first, second, third, fourth);--for reading 128 bit data
signal data_state : data_states;

-- extra read master signals
signal master_read_address : std_logic_vector (INTERFACE_ADDR_WIDTH - 1 downto 0);         -- the current read address
signal master_words_read : std_logic_vector (8 downto 0);            					   -- tracks the words read
-- extra write master signals
signal master_write_address : std_logic_vector (INTERFACE_ADDR_WIDTH - 1 downto 0);        -- the current write address
signal data_plain : std_logic_vector (127 downto 0);
signal data_key : std_logic_vector (127 downto 0);



--CSR initial values
function init_csr
  return register_t is
  variable temp: register_t(INTERFACE_LENGTH - 1 downto 0);
  begin
	--entire table set to '0'
    temp := (others => (others => '0'));
  	return temp;
  end init_csr;

--signal csr_reg: register_t := init_csr;
-------------------------------------------------------------------------------------------
----------TEMPORATY SOLUTION---------------------------------------------------------------
type reg_t is array (INTERFACE_LENGTH - 1 downto 0) of word_t;
signal csr_reg : reg_t := (others => (others => '0'));
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

-- aliasy do obszarów w csr
alias status_reg:   std_logic_vector(INTERFACE_WIDTH - 1 downto 0)  is csr_reg(0);
alias control_reg:  std_logic_vector(INTERFACE_WIDTH - 1 downto 0)  is csr_reg(1);
alias csr_plain_addr:  std_logic_vector(INTERFACE_WIDTH - 1 downto 0)	is csr_reg(2); 
alias csr_key_addr:  std_logic_vector(INTERFACE_WIDTH - 1 downto 0)	is csr_reg(3); 
-- aliasy do bitów w obrzarach
alias csr_status : std_logic is status_reg(0);           -- the status word that will be read from the status register
alias csr_go_key : std_logic is control_reg(1);         -- used to start the DMA (when logic 1)
alias csr_go_plain : std_logic is control_reg(2);         -- used to start the DMA (when logic 1)


signal out_waitrequest : std_logic;

begin
-------------------------------------------------------------------------------
-- THE READ SLAVE STATE MACHINE
-------------------------------------------------------------------------------
write_slave: process (clk, rst)
begin
	if rst = '1' then
		slave_write_state <= idle;	
	elsif rising_edge (clk) then

		case slave_write_state is
			
			when idle =>
				if master_write_state = idle and interface_0_avalon_slave_1_write = '1'  then
					slave_write_state <= running;
					interface_0_avalon_slave_1_waitrequest <= '0';
				end if;
				
			when running =>
				
				csr_reg(to_integer(unsigned(interface_0_avalon_slave_1_address))) <=  interface_0_avalon_slave_1_writedata(to_integer(unsigned(interface_0_avalon_slave_1_byteenable)) * 8 downto 0);
				slave_write_state <= stopping;			
			when stopping =>
				interface_0_avalon_slave_1_waitrequest <= '1';
				slave_write_state <= idle;		
		end case;
	end if;
end process;



-------------------------------------------------------------------------------
-- THE READ MASTER STATE MACHINE
-------------------------------------------------------------------------------

read_master: process (clk, rst)
begin
	if rst = '1' then
		master_read_state <= idle;	
		
	elsif rising_edge (clk) then
		case master_read_state is
		
			when idle =>
				if slave_write_state = idle then
					master_read_state <= running;			
				end if;
	
			when running =>	

				if csr_go_key = '1' then
					if data_state = first then
						data_key(127 downto 96) <= interface_0_avalon_master_1_readdata;
						csr_key_addr <= master_read_address;
						master_read_address <= std_logic_vector(to_unsigned(to_integer(unsigned(master_read_address)) + 32,master_read_address'length ));
						data_state <= second;
					elsif data_state = second then
						data_key(95 downto 64) <= interface_0_avalon_master_1_readdata;
						master_read_address <= std_logic_vector(to_unsigned(to_integer(unsigned(master_read_address)) + 32,master_read_address'length ));
						data_state <= third;
					elsif data_state = third then
						data_key(63 downto 32) <= interface_0_avalon_master_1_readdata;
						master_read_address <= std_logic_vector(to_unsigned(to_integer(unsigned(master_read_address)) + 32,master_read_address'length ));
						data_state <= fourth;
					elsif data_state = fourth then
						data_key(31 downto 0) <= interface_0_avalon_master_1_readdata;
						master_read_state <= stopping;
					end if;
				elsif csr_go_plain = '1' then
					if data_state = first then
						data_plain(127 downto 96) <= interface_0_avalon_master_1_readdata;
						csr_plain_addr <= master_read_address;
						master_read_address <= std_logic_vector(to_unsigned(to_integer(unsigned(master_read_address)) + 32,master_read_address'length ));
						data_state <= second;
					elsif data_state = second then
						data_plain(95 downto 64) <= interface_0_avalon_master_1_readdata;
						master_read_address <= std_logic_vector(to_unsigned(to_integer(unsigned(master_read_address)) + 32,master_read_address'length ));
						data_state <= third;
					elsif data_state = third then
						data_plain(63 downto 32) <= interface_0_avalon_master_1_readdata;
						master_read_address <= std_logic_vector(to_unsigned(to_integer(unsigned(master_read_address)) + 32,master_read_address'length ));
						data_state <= fourth;
					elsif data_state = fourth then
						data_plain(31 downto 0) <= interface_0_avalon_master_1_readdata;
						master_read_state <= stopping;
					end if;
					
				end if;			
			when stopping =>
				data_state <= first;			
				master_read_state <= idle;
		
		end case;
	end if;
end process;


-------------------------------------------------------------------------------
-- CSR PROCESS
-------------------------------------------------------------------------------

csr: process (clk, rst)
begin
	if rst = '1' then
		csr_plain_addr <= (others => '0');
		csr_key_addr <= (others => '0');
	--elsif rising_edge (clk) then
		--if csr_status = '1' then
		--	case control_reg is
			--	when "10" =>
					--asd
			--	when "11" =>

			--	when others =>
		--	end case;
	--	end if;
	end if;
end process;	


 out_waitrequest_proc: process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        out_waitrequest <= '1';
      else
        -- reset sygnału waitrequest
        if csr_go_key = '1' or csr_go_plain = '1' then
          out_waitrequest <= '0';
        end if;

        -- ponowne ustawienie waitrequest po pojedynczym transferze
        if out_waitrequest = '0' and (csr_go_key = '1' or csr_go_plain = '1') then
          out_waitrequest <= '1';
        end if;

      end if;
    end if;
  end process out_waitrequest_proc; 
end architecture behave;
