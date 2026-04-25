library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axi4_master is
    generic (
        AXI_ADDR_WIDTH     : integer                       := 30;
        AXI_DATA_WIDTH     : integer                       := 32;
        AXI_ID_WIDTH       : integer                       := 4
    );
    port (
        aclk    : in std_logic;
        aresetn : in std_logic;
		  read_bt : in std_logic;

        -- AXI4 write address channel
        awaddr  : out std_logic_vector(AXI_ADDR_WIDTH-1 downto 0);     -- Start burst address
        awburst : out std_logic_vector(1 downto 0);                    -- Burst type
		  awcache : out std_logic_vector(3 downto 0);
        awid    : out std_logic_vector(AXI_ID_WIDTH-1 downto 0);       -- Transaction ID
        awlen   : out std_logic_vector(7 downto 0);                    -- Number of writes
        awlock  : out std_logic;                                       -- Atomic Access, 0 - Normal Access, 1 - Exclusive Access
        awqos   : out std_logic_vector(3 downto 0);                    -- User defined QOS
        awsize  : out std_logic_vector(2 downto 0);                    -- Size of single write (log2 - number of bytes)
        awvalid : out std_logic;                                       -- Address write valid from master
        awprot  : out std_logic_vector(2 downto 0);                    -- Access Protections
        awready : in  std_logic;                                       -- Ready to accept write address from slave

        -- AXI4 read address channel
        araddr  : out std_logic_vector(AXI_ADDR_WIDTH-1 downto 0);     -- Read address, base address for burst
		  arburst : out std_logic_vector(1 downto 0);                    -- Burst type
		  arcache : out std_logic_vector(3 downto 0);
		  arid    : out std_logic_vector(AXI_ID_WIDTH-1 downto 0);       -- Transaction ID
		  arlen   : out std_logic_vector(7 downto 0);                    -- Number of reads
		  arlock  : out std_logic;                                       -- Atomic Access
		  arqos   : out std_logic_vector(3 downto 0);                    -- User defined QOS
		  arsize  : out std_logic_vector(2 downto 0);                    -- Size of single read (log2 - number of bytes)
		  arvalid : out std_logic;                                       -- Address read valid from master
		  arprot  : out std_logic_vector(2 downto 0);                    -- Access Protections
		  arready : in  std_logic;                                       -- Ready to accept read address from slave

        -- AXI4 write data channel
        wdata   : out std_logic_vector(AXI_DATA_WIDTH-1 downto 0);     -- The write Data
        wstrb   : out std_logic_vector((AXI_DATA_WIDTH/8)-1 downto 0); -- Identifies which bytes of the data are valid, one bit for each byte
        wlast   : out std_logic;                                       -- Last word of the burst
        wvalid  : out std_logic;                                       -- Write data valid from master
        wready  : in  std_logic;                                       -- Slave ready to accept data

        -- AXI4 write response channel
        bready : out std_logic;                                        -- Master ready to accept data
		  bid    : in  std_logic_vector(AXI_ID_WIDTH-1 downto 0);        -- Transaction ID
		  bresp  : in  std_logic_vector(1 downto 0);                     -- Response info from Slave, 00 - OK, 01 - Exclusive Access is OK, 10 - Error (address in range), 11 - Address not in range
		  bvalid : in  std_logic;                                        -- Write response is valid, from slave

        -- AXI4 read data channel
        rready : out std_logic;                                        -- Master is ready to accept read data
		  rdata  : in  std_logic_vector(AXI_DATA_WIDTH-1 downto 0);      -- Read data from slave
		  rid    : in  std_logic_vector(AXI_ID_WIDTH-1 downto 0);        -- Transaction ID
		  rlast  : in  std_logic;                                        -- Last word of the burst
		  rresp  : in  std_logic_vector(1 downto 0);                     -- Response info from Slave, 00 - OK, 01 - Exclusive Access is OK, 10 - Error (address in range), 11 - Address not in range
		  rvalid : in  std_logic;                                        -- Read data from slave is valid

        -- Output signal on LED
        test_complete : out std_logic
    );
	 attribute altera_ip                                 : string; 
	 attribute altera_ip of axi4_master                  : entity is "altera.com:ip:axi4_master:1.0"; 

    -- Visual Designer Studio / Platform Designer interface metadata.
    -- AXI interface mode is "manager" for an AXI master.
    -- If your VDS build still uses old terms, replace "manager" with "master".
	 attribute altera_interface 				: string;
    attribute altera_interface of aclk    : signal is "altera.com:interfaces:altera_clock:1.0 in aclk clk";
    attribute altera_interface of aresetn : signal is "altera.com:interfaces:altera_reset:1.0 in aresetn reset_n";
    attribute altera_port                 : string;
    attribute altera_port      of awaddr  : signal is "clockref:aclk, resetref:aresetn";

    -- AXI4 memory-mapped manager interface: axi_m
    attribute altera_interface of awaddr : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m awaddr";
    attribute altera_interface of awburst: signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m awburst";
    attribute altera_interface of awcache: signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m awcache";
    attribute altera_interface of awid   : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m awid";
    attribute altera_interface of awlen  : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m awlen";
    attribute altera_interface of awlock : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m awlock";
    attribute altera_interface of awqos  : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m awqos";
    attribute altera_interface of awsize : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m awsize";
    attribute altera_interface of awvalid: signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m awvalid";
    attribute altera_interface of awprot : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m awprot";
    attribute altera_interface of awready: signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m awready";
    attribute altera_interface of araddr : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m araddr";
    attribute altera_interface of arburst: signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m arburst";
    attribute altera_interface of arcache: signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m arcache";
    attribute altera_interface of arid   : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m arid";
    attribute altera_interface of arlen  : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m arlen";
    attribute altera_interface of arlock : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m arlock";
    attribute altera_interface of arqos  : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m arqos";
    attribute altera_interface of arsize : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m arsize";
    attribute altera_interface of arvalid: signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m arvalid";
    attribute altera_interface of arprot : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m arprot";
    attribute altera_interface of arready: signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m arready";
    attribute altera_interface of wdata  : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m wdata";
    attribute altera_interface of wstrb  : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m wstrb";
    attribute altera_interface of wlast  : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m wlast";
    attribute altera_interface of wvalid : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m wvalid";
    attribute altera_interface of wready : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m wready";
    attribute altera_interface of bready : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m bready";
    attribute altera_interface of bid    : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m bid";
    attribute altera_interface of bresp  : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m bresp";
    attribute altera_interface of bvalid : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m bvalid";
    attribute altera_interface of rready : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m rready";
    attribute altera_interface of rdata  : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m rdata";
    attribute altera_interface of rid    : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m rid";
    attribute altera_interface of rlast  : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m rlast";
    attribute altera_interface of rresp  : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m rresp";
    attribute altera_interface of rvalid : signal is "altera.com:interfaces:altera_axi4:1.0 manager axi_m rvalid";
    
end entity;

architecture rtl of axi4_master is

    function clog2(n : positive) return natural is
        variable tmp : natural := 1;
        variable res : natural := 0;
    begin
        while tmp < n loop
            tmp := tmp * 2;
            res := res + 1;
        end loop;
        return res;
    end function;
	 
	 constant AXI_START_ADDR : std_logic_vector(AXI_ADDR_WIDTH-1 downto 0) := (others => '0');
	 constant AXI_BEAT_SIZE  : std_logic_vector(2 downto 0) 					  := "010"; -- log2(32)

    type   read_state_t  is (READ_IDLE, READ_ADDR, READ_DATA, READ_FINISH);
    signal read_state  : read_state_t  := READ_IDLE;

    -- AXI4 signals registers
    signal r_araddr  : std_logic_vector(AXI_ADDR_WIDTH-1 downto 0) := (others => '0');
    signal r_arvalid : std_logic                                   := '0';
    signal r_bready  : std_logic                                   := '1';
    signal r_rready  : std_logic                                   := '0';

    -- Test output signal register
    signal r_test_complete : std_logic;

begin

	 -- AXI4 Write unused
	 awid    <= (others => '0');
	 awaddr  <= (others => '0');
	 awlen   <= (others => '0');
	 awsize  <= (others => '0');
    awburst <= (others => '0'); -- FIXED
    awlock  <= '0';
    awcache <= "0011";			  -- normal non-cacheable bufferable/modifiable
	 awprot  <= (others => '0');
	 awqos   <= (others => '0');
	 awvalid <= '0';
	 wdata   <= (others => '0');
	 wstrb   <= (others => '1');
	 wlast   <= '0';
	 wvalid  <= '0';
	 bready  <= '0';
    
	 -- AXI4 Read
	 arid    <= (others => '0');
	 araddr  <= r_araddr;
	 arlen   <= (others => '0');
	 arsize  <= AXI_BEAT_SIZE;
    arburst <= (others => '0'); -- FIXED
    arlock  <= '0';
	 arcache <= "0011"; 			  -- normal non-cacheable bufferable/modifiable
	 arprot  <= (others => '0');
    arqos   <= (others => '0');
    arvalid <= r_arvalid;
    rready  <= r_rready;
	 
	 -- Test output registered
    test_complete <= r_test_complete;
            
    lpddr4_read_fsm : process(aclk, aresetn)
    begin
        if aresetn = '0' then
            read_state      <= READ_IDLE;
            r_arvalid       <= '0';
            r_araddr        <= AXI_START_ADDR;
            r_rready        <= '0';
            r_test_complete <= '0';

        elsif rising_edge(aclk) then
            case read_state is
                when READ_IDLE =>
                    r_arvalid       <= '0';
                    r_rready        <= '0';
                    r_test_complete <= '0';

                    if read_bt = '0' then
                        r_araddr   <= AXI_START_ADDR;
                        r_arvalid  <= '1';
                        read_state <= READ_ADDR;
                    end if;

                when READ_ADDR =>
                    if arready = '1' then
                        r_arvalid  <= '0';
                        r_rready   <= '1';
                        read_state <= READ_DATA;
                    end if;

                when READ_DATA =>
						 if rvalid = '1' and r_rready = '1' then
							  r_rready <= '0';

							  if rresp = "00" then
									r_test_complete <= rdata(0);
							  else
									r_test_complete <= '0';
							  end if;

							  read_state <= READ_FINISH;
						 end if;

                when READ_FINISH =>
                   if read_bt = '1' then
							  read_state <= READ_IDLE;
						 end if;

                when OTHERS =>
                    read_state <= READ_IDLE;
						  
            end case;
        end if;
    end process;

end architecture;