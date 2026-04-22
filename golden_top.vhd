library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity golden_top is
    port (
        -- clocks / keys / leds
        CLOCK1_50        : in    std_logic;
        KEY              : in    std_logic_vector(1 downto 0);
        
        -- HPS dedicated I/O
--		  HPS_CLK_25		 	: in std_logic;
--		  HPS_ENET_MDC		 	: out std_logic;
--		  HPS_ENET_MDIO    	: inout std_logic
--		  HPS_ENET_RX_CLK  	: in std_logic;
--		  HPS_ENET_RX_CTL  	: in std_logic;
--		  HPS_ENET_RX_DATA 	: in std_logic_vector(3 downto 0);
--		  HPS_ENET_TX_CLK  	: out std_logic;
--		  HPS_ENET_TX_CTL    : out std_logic;
--		  HPS_ENET_TX_DATA   : out std_logic_vector(3 downto 0);
--		  HPS_GSENSOR_I2C_EN : inout std_logic;
--		  HPS_GSENSOR_INT    : inout std_logic;
--		  HPS_I2C_SCL        : inout std_logic;
--		  HPS_I2C_SDA        : inout std_logic;
--		  HPS_KEY          	: inout std_logic;
		  HPS_LED          	: inout std_logic
--		  HPS_SD_CLK  			: out std_logic;
--		  HPS_SD_CMD         : inout std_logic;
--		  HPS_SD_DATA 			: inout std_logic_vector(3 downto 0);
--		  HPS_UART_RX  		: in std_logic;
--		  HPS_UART_TX  		: out std_logic;
--		  HPS_USB_CLK			: input std_logic;
--		  HPS_USB_DATA 		: inout std_logic_vector(7 downto 0);
--		  HPS_USB_DIR  		: in std_logic;
--		  HPS_USB_NXT  		: in std_logic;
--		  HPS_USB_STP			: out std_logic;
    );
end entity;

architecture rtl of golden_top is

    component HPS_QSYS is
		port (
			hps2fpga_awid      : out   std_logic_vector(3 downto 0);                      -- awid
			hps2fpga_awaddr    : out   std_logic_vector(27 downto 0);                     -- awaddr
			hps2fpga_awlen     : out   std_logic_vector(7 downto 0);                      -- awlen
			hps2fpga_awsize    : out   std_logic_vector(2 downto 0);                      -- awsize
			hps2fpga_awburst   : out   std_logic_vector(1 downto 0);                      -- awburst
			hps2fpga_awlock    : out   std_logic;                                         -- awlock
			hps2fpga_awcache   : out   std_logic_vector(3 downto 0);                      -- awcache
			hps2fpga_awprot    : out   std_logic_vector(2 downto 0);                      -- awprot
			hps2fpga_awvalid   : out   std_logic;                                         -- awvalid
			hps2fpga_awready   : in    std_logic                      := 'X';             -- awready
			hps2fpga_wdata     : out   std_logic_vector(127 downto 0);                    -- wdata
			hps2fpga_wstrb     : out   std_logic_vector(15 downto 0);                     -- wstrb
			hps2fpga_wlast     : out   std_logic;                                         -- wlast
			hps2fpga_wvalid    : out   std_logic;                                         -- wvalid
			hps2fpga_wready    : in    std_logic                      := 'X';             -- wready
			hps2fpga_bid       : in    std_logic_vector(3 downto 0)   := (others => 'X'); -- bid
			hps2fpga_bresp     : in    std_logic_vector(1 downto 0)   := (others => 'X'); -- bresp
			hps2fpga_bvalid    : in    std_logic                      := 'X';             -- bvalid
			hps2fpga_bready    : out   std_logic;                                         -- bready
			hps2fpga_arid      : out   std_logic_vector(3 downto 0);                      -- arid
			hps2fpga_araddr    : out   std_logic_vector(27 downto 0);                     -- araddr
			hps2fpga_arlen     : out   std_logic_vector(7 downto 0);                      -- arlen
			hps2fpga_arsize    : out   std_logic_vector(2 downto 0);                      -- arsize
			hps2fpga_arburst   : out   std_logic_vector(1 downto 0);                      -- arburst
			hps2fpga_arlock    : out   std_logic;                                         -- arlock
			hps2fpga_arcache   : out   std_logic_vector(3 downto 0);                      -- arcache
			hps2fpga_arprot    : out   std_logic_vector(2 downto 0);                      -- arprot
			hps2fpga_arvalid   : out   std_logic;                                         -- arvalid
			hps2fpga_arready   : in    std_logic                      := 'X';             -- arready
			hps2fpga_rid       : in    std_logic_vector(3 downto 0)   := (others => 'X'); -- rid
			hps2fpga_rdata     : in    std_logic_vector(127 downto 0) := (others => 'X'); -- rdata
			hps2fpga_rresp     : in    std_logic_vector(1 downto 0)   := (others => 'X'); -- rresp
			hps2fpga_rlast     : in    std_logic                      := 'X';             -- rlast
			hps2fpga_rvalid    : in    std_logic                      := 'X';             -- rvalid
			hps2fpga_rready    : out   std_logic;                                         -- rready
			hps_io_gpio41      : inout std_logic                      := 'X';             -- gpio41
			refclk_clk         : in    std_logic                      := 'X';             -- clk
			locked_export      : out   std_logic;                                         -- export
			reset_reset        : in    std_logic                      := 'X';             -- reset
			in_reset_reset_n   : in    std_logic                      := 'X'              -- reset_n
		);
	end component HPS_QSYS;

    signal rst_n : std_logic;
    signal rst   : std_logic;

begin
    rst   <= not KEY(0);
    rst_n <= KEY(0);

    u0 : component HPS_QSYS
		port map (
			hps2fpga_awid      => open,
            hps2fpga_awaddr    => open,
            hps2fpga_awlen     => open,
            hps2fpga_awsize    => open,
            hps2fpga_awburst   => open,
            hps2fpga_awlock    => open,
            hps2fpga_awcache   => open,
            hps2fpga_awprot    => open,
            hps2fpga_awvalid   => open,
            hps2fpga_awready   => '0',
			hps2fpga_wdata     => open,
            hps2fpga_wstrb     => open,
            hps2fpga_wlast     => open,
            hps2fpga_wvalid    => open,
            hps2fpga_wready    => '0',
			hps2fpga_bid       => (others => '0'),
            hps2fpga_bresp     => (others => '0'),
            hps2fpga_bvalid    => '0',
            hps2fpga_bready    => open,
            hps2fpga_arid      => open,
            hps2fpga_araddr    => open,
            hps2fpga_arlen     => open,
            hps2fpga_arsize    => open,
            hps2fpga_arburst   => open,
            hps2fpga_arlock    => open,
            hps2fpga_arcache   => open,
            hps2fpga_arprot    => open,
            hps2fpga_arvalid   => open,
            hps2fpga_arready   => '0',
			hps2fpga_rid       => (others => '0'),
            hps2fpga_rdata     => (others => '0'),
            hps2fpga_rresp     => (others => '0'),
            hps2fpga_rlast     => '0',
            hps2fpga_rvalid    => '0',
            hps2fpga_rready    => open,
            hps_io_gpio41      => HPS_LED,
			refclk_clk         => CLOCK1_50,
            locked_export      => open,
            reset_reset        => rst,
            in_reset_reset_n   => rst_n
		);

end architecture;