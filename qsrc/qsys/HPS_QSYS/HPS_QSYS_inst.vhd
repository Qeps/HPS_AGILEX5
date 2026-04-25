	component HPS_QSYS is
		port (
			hps2fpga_awid         : out   std_logic_vector(3 downto 0);                      -- awid
			hps2fpga_awaddr       : out   std_logic_vector(27 downto 0);                     -- awaddr
			hps2fpga_awlen        : out   std_logic_vector(7 downto 0);                      -- awlen
			hps2fpga_awsize       : out   std_logic_vector(2 downto 0);                      -- awsize
			hps2fpga_awburst      : out   std_logic_vector(1 downto 0);                      -- awburst
			hps2fpga_awlock       : out   std_logic;                                         -- awlock
			hps2fpga_awcache      : out   std_logic_vector(3 downto 0);                      -- awcache
			hps2fpga_awprot       : out   std_logic_vector(2 downto 0);                      -- awprot
			hps2fpga_awvalid      : out   std_logic;                                         -- awvalid
			hps2fpga_awready      : in    std_logic                      := 'X';             -- awready
			hps2fpga_wdata        : out   std_logic_vector(127 downto 0);                    -- wdata
			hps2fpga_wstrb        : out   std_logic_vector(15 downto 0);                     -- wstrb
			hps2fpga_wlast        : out   std_logic;                                         -- wlast
			hps2fpga_wvalid       : out   std_logic;                                         -- wvalid
			hps2fpga_wready       : in    std_logic                      := 'X';             -- wready
			hps2fpga_bid          : in    std_logic_vector(3 downto 0)   := (others => 'X'); -- bid
			hps2fpga_bresp        : in    std_logic_vector(1 downto 0)   := (others => 'X'); -- bresp
			hps2fpga_bvalid       : in    std_logic                      := 'X';             -- bvalid
			hps2fpga_bready       : out   std_logic;                                         -- bready
			hps2fpga_arid         : out   std_logic_vector(3 downto 0);                      -- arid
			hps2fpga_araddr       : out   std_logic_vector(27 downto 0);                     -- araddr
			hps2fpga_arlen        : out   std_logic_vector(7 downto 0);                      -- arlen
			hps2fpga_arsize       : out   std_logic_vector(2 downto 0);                      -- arsize
			hps2fpga_arburst      : out   std_logic_vector(1 downto 0);                      -- arburst
			hps2fpga_arlock       : out   std_logic;                                         -- arlock
			hps2fpga_arcache      : out   std_logic_vector(3 downto 0);                      -- arcache
			hps2fpga_arprot       : out   std_logic_vector(2 downto 0);                      -- arprot
			hps2fpga_arvalid      : out   std_logic;                                         -- arvalid
			hps2fpga_arready      : in    std_logic                      := 'X';             -- arready
			hps2fpga_rid          : in    std_logic_vector(3 downto 0)   := (others => 'X'); -- rid
			hps2fpga_rdata        : in    std_logic_vector(127 downto 0) := (others => 'X'); -- rdata
			hps2fpga_rresp        : in    std_logic_vector(1 downto 0)   := (others => 'X'); -- rresp
			hps2fpga_rlast        : in    std_logic                      := 'X';             -- rlast
			hps2fpga_rvalid       : in    std_logic                      := 'X';             -- rvalid
			hps2fpga_rready       : out   std_logic;                                         -- rready
			hps_io_gpio41         : inout std_logic                      := 'X';             -- gpio41
			refclk_clk            : in    std_logic                      := 'X';             -- clk
			locked_export         : out   std_logic;                                         -- export
			reset_reset           : in    std_logic                      := 'X';             -- reset
			in_reset_reset_n      : in    std_logic                      := 'X';             -- reset_n
			read_bt               : in    std_logic                      := 'X';             -- read_bt
			test_complete         : out   std_logic;                                         -- test_complete
			ninit_done_ninit_done : out   std_logic                                          -- ninit_done
		);
	end component HPS_QSYS;

	u0 : component HPS_QSYS
		port map (
			hps2fpga_awid         => CONNECTED_TO_hps2fpga_awid,         --      hps2fpga.awid
			hps2fpga_awaddr       => CONNECTED_TO_hps2fpga_awaddr,       --              .awaddr
			hps2fpga_awlen        => CONNECTED_TO_hps2fpga_awlen,        --              .awlen
			hps2fpga_awsize       => CONNECTED_TO_hps2fpga_awsize,       --              .awsize
			hps2fpga_awburst      => CONNECTED_TO_hps2fpga_awburst,      --              .awburst
			hps2fpga_awlock       => CONNECTED_TO_hps2fpga_awlock,       --              .awlock
			hps2fpga_awcache      => CONNECTED_TO_hps2fpga_awcache,      --              .awcache
			hps2fpga_awprot       => CONNECTED_TO_hps2fpga_awprot,       --              .awprot
			hps2fpga_awvalid      => CONNECTED_TO_hps2fpga_awvalid,      --              .awvalid
			hps2fpga_awready      => CONNECTED_TO_hps2fpga_awready,      --              .awready
			hps2fpga_wdata        => CONNECTED_TO_hps2fpga_wdata,        --              .wdata
			hps2fpga_wstrb        => CONNECTED_TO_hps2fpga_wstrb,        --              .wstrb
			hps2fpga_wlast        => CONNECTED_TO_hps2fpga_wlast,        --              .wlast
			hps2fpga_wvalid       => CONNECTED_TO_hps2fpga_wvalid,       --              .wvalid
			hps2fpga_wready       => CONNECTED_TO_hps2fpga_wready,       --              .wready
			hps2fpga_bid          => CONNECTED_TO_hps2fpga_bid,          --              .bid
			hps2fpga_bresp        => CONNECTED_TO_hps2fpga_bresp,        --              .bresp
			hps2fpga_bvalid       => CONNECTED_TO_hps2fpga_bvalid,       --              .bvalid
			hps2fpga_bready       => CONNECTED_TO_hps2fpga_bready,       --              .bready
			hps2fpga_arid         => CONNECTED_TO_hps2fpga_arid,         --              .arid
			hps2fpga_araddr       => CONNECTED_TO_hps2fpga_araddr,       --              .araddr
			hps2fpga_arlen        => CONNECTED_TO_hps2fpga_arlen,        --              .arlen
			hps2fpga_arsize       => CONNECTED_TO_hps2fpga_arsize,       --              .arsize
			hps2fpga_arburst      => CONNECTED_TO_hps2fpga_arburst,      --              .arburst
			hps2fpga_arlock       => CONNECTED_TO_hps2fpga_arlock,       --              .arlock
			hps2fpga_arcache      => CONNECTED_TO_hps2fpga_arcache,      --              .arcache
			hps2fpga_arprot       => CONNECTED_TO_hps2fpga_arprot,       --              .arprot
			hps2fpga_arvalid      => CONNECTED_TO_hps2fpga_arvalid,      --              .arvalid
			hps2fpga_arready      => CONNECTED_TO_hps2fpga_arready,      --              .arready
			hps2fpga_rid          => CONNECTED_TO_hps2fpga_rid,          --              .rid
			hps2fpga_rdata        => CONNECTED_TO_hps2fpga_rdata,        --              .rdata
			hps2fpga_rresp        => CONNECTED_TO_hps2fpga_rresp,        --              .rresp
			hps2fpga_rlast        => CONNECTED_TO_hps2fpga_rlast,        --              .rlast
			hps2fpga_rvalid       => CONNECTED_TO_hps2fpga_rvalid,       --              .rvalid
			hps2fpga_rready       => CONNECTED_TO_hps2fpga_rready,       --              .rready
			hps_io_gpio41         => CONNECTED_TO_hps_io_gpio41,         --        hps_io.gpio41
			refclk_clk            => CONNECTED_TO_refclk_clk,            --        refclk.clk
			locked_export         => CONNECTED_TO_locked_export,         --        locked.export
			reset_reset           => CONNECTED_TO_reset_reset,           --         reset.reset
			in_reset_reset_n      => CONNECTED_TO_in_reset_reset_n,      --      in_reset.reset_n
			read_bt               => CONNECTED_TO_read_bt,               --       read_bt.read_bt
			test_complete         => CONNECTED_TO_test_complete,         -- test_complete.test_complete
			ninit_done_ninit_done => CONNECTED_TO_ninit_done_ninit_done  --    ninit_done.ninit_done
		);

