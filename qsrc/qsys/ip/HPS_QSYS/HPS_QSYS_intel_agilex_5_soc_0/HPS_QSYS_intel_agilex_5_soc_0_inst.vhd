	component HPS_QSYS_intel_agilex_5_soc_0 is
		port (
			h2f_reset_reset            : out   std_logic;                                         -- reset
			hps2fpga_axi_clock_clk     : in    std_logic                      := 'X';             -- clk
			hps2fpga_axi_reset_reset   : in    std_logic                      := 'X';             -- reset
			hps2fpga_awid              : out   std_logic_vector(3 downto 0);                      -- awid
			hps2fpga_awaddr            : out   std_logic_vector(27 downto 0);                     -- awaddr
			hps2fpga_awlen             : out   std_logic_vector(7 downto 0);                      -- awlen
			hps2fpga_awsize            : out   std_logic_vector(2 downto 0);                      -- awsize
			hps2fpga_awburst           : out   std_logic_vector(1 downto 0);                      -- awburst
			hps2fpga_awlock            : out   std_logic;                                         -- awlock
			hps2fpga_awcache           : out   std_logic_vector(3 downto 0);                      -- awcache
			hps2fpga_awprot            : out   std_logic_vector(2 downto 0);                      -- awprot
			hps2fpga_awvalid           : out   std_logic;                                         -- awvalid
			hps2fpga_awready           : in    std_logic                      := 'X';             -- awready
			hps2fpga_wdata             : out   std_logic_vector(127 downto 0);                    -- wdata
			hps2fpga_wstrb             : out   std_logic_vector(15 downto 0);                     -- wstrb
			hps2fpga_wlast             : out   std_logic;                                         -- wlast
			hps2fpga_wvalid            : out   std_logic;                                         -- wvalid
			hps2fpga_wready            : in    std_logic                      := 'X';             -- wready
			hps2fpga_bid               : in    std_logic_vector(3 downto 0)   := (others => 'X'); -- bid
			hps2fpga_bresp             : in    std_logic_vector(1 downto 0)   := (others => 'X'); -- bresp
			hps2fpga_bvalid            : in    std_logic                      := 'X';             -- bvalid
			hps2fpga_bready            : out   std_logic;                                         -- bready
			hps2fpga_arid              : out   std_logic_vector(3 downto 0);                      -- arid
			hps2fpga_araddr            : out   std_logic_vector(27 downto 0);                     -- araddr
			hps2fpga_arlen             : out   std_logic_vector(7 downto 0);                      -- arlen
			hps2fpga_arsize            : out   std_logic_vector(2 downto 0);                      -- arsize
			hps2fpga_arburst           : out   std_logic_vector(1 downto 0);                      -- arburst
			hps2fpga_arlock            : out   std_logic;                                         -- arlock
			hps2fpga_arcache           : out   std_logic_vector(3 downto 0);                      -- arcache
			hps2fpga_arprot            : out   std_logic_vector(2 downto 0);                      -- arprot
			hps2fpga_arvalid           : out   std_logic;                                         -- arvalid
			hps2fpga_arready           : in    std_logic                      := 'X';             -- arready
			hps2fpga_rid               : in    std_logic_vector(3 downto 0)   := (others => 'X'); -- rid
			hps2fpga_rdata             : in    std_logic_vector(127 downto 0) := (others => 'X'); -- rdata
			hps2fpga_rresp             : in    std_logic_vector(1 downto 0)   := (others => 'X'); -- rresp
			hps2fpga_rlast             : in    std_logic                      := 'X';             -- rlast
			hps2fpga_rvalid            : in    std_logic                      := 'X';             -- rvalid
			hps2fpga_rready            : out   std_logic;                                         -- rready
			lwhps2fpga_axi_clock_clk   : in    std_logic                      := 'X';             -- clk
			lwhps2fpga_axi_reset_reset : in    std_logic                      := 'X';             -- reset
			lwhps2fpga_awid            : out   std_logic_vector(3 downto 0);                      -- awid
			lwhps2fpga_awaddr          : out   std_logic_vector(23 downto 0);                     -- awaddr
			lwhps2fpga_awlen           : out   std_logic_vector(7 downto 0);                      -- awlen
			lwhps2fpga_awsize          : out   std_logic_vector(2 downto 0);                      -- awsize
			lwhps2fpga_awburst         : out   std_logic_vector(1 downto 0);                      -- awburst
			lwhps2fpga_awlock          : out   std_logic;                                         -- awlock
			lwhps2fpga_awcache         : out   std_logic_vector(3 downto 0);                      -- awcache
			lwhps2fpga_awprot          : out   std_logic_vector(2 downto 0);                      -- awprot
			lwhps2fpga_awvalid         : out   std_logic;                                         -- awvalid
			lwhps2fpga_awready         : in    std_logic                      := 'X';             -- awready
			lwhps2fpga_wdata           : out   std_logic_vector(31 downto 0);                     -- wdata
			lwhps2fpga_wstrb           : out   std_logic_vector(3 downto 0);                      -- wstrb
			lwhps2fpga_wlast           : out   std_logic;                                         -- wlast
			lwhps2fpga_wvalid          : out   std_logic;                                         -- wvalid
			lwhps2fpga_wready          : in    std_logic                      := 'X';             -- wready
			lwhps2fpga_bid             : in    std_logic_vector(3 downto 0)   := (others => 'X'); -- bid
			lwhps2fpga_bresp           : in    std_logic_vector(1 downto 0)   := (others => 'X'); -- bresp
			lwhps2fpga_bvalid          : in    std_logic                      := 'X';             -- bvalid
			lwhps2fpga_bready          : out   std_logic;                                         -- bready
			lwhps2fpga_arid            : out   std_logic_vector(3 downto 0);                      -- arid
			lwhps2fpga_araddr          : out   std_logic_vector(23 downto 0);                     -- araddr
			lwhps2fpga_arlen           : out   std_logic_vector(7 downto 0);                      -- arlen
			lwhps2fpga_arsize          : out   std_logic_vector(2 downto 0);                      -- arsize
			lwhps2fpga_arburst         : out   std_logic_vector(1 downto 0);                      -- arburst
			lwhps2fpga_arlock          : out   std_logic;                                         -- arlock
			lwhps2fpga_arcache         : out   std_logic_vector(3 downto 0);                      -- arcache
			lwhps2fpga_arprot          : out   std_logic_vector(2 downto 0);                      -- arprot
			lwhps2fpga_arvalid         : out   std_logic;                                         -- arvalid
			lwhps2fpga_arready         : in    std_logic                      := 'X';             -- arready
			lwhps2fpga_rid             : in    std_logic_vector(3 downto 0)   := (others => 'X'); -- rid
			lwhps2fpga_rdata           : in    std_logic_vector(31 downto 0)  := (others => 'X'); -- rdata
			lwhps2fpga_rresp           : in    std_logic_vector(1 downto 0)   := (others => 'X'); -- rresp
			lwhps2fpga_rlast           : in    std_logic                      := 'X';             -- rlast
			lwhps2fpga_rvalid          : in    std_logic                      := 'X';             -- rvalid
			lwhps2fpga_rready          : out   std_logic;                                         -- rready
			hps_io_gpio41              : inout std_logic                      := 'X'              -- gpio41
		);
	end component HPS_QSYS_intel_agilex_5_soc_0;

	u0 : component HPS_QSYS_intel_agilex_5_soc_0
		port map (
			h2f_reset_reset            => CONNECTED_TO_h2f_reset_reset,            --            h2f_reset.reset
			hps2fpga_axi_clock_clk     => CONNECTED_TO_hps2fpga_axi_clock_clk,     --   hps2fpga_axi_clock.clk
			hps2fpga_axi_reset_reset   => CONNECTED_TO_hps2fpga_axi_reset_reset,   --   hps2fpga_axi_reset.reset
			hps2fpga_awid              => CONNECTED_TO_hps2fpga_awid,              --             hps2fpga.awid
			hps2fpga_awaddr            => CONNECTED_TO_hps2fpga_awaddr,            --                     .awaddr
			hps2fpga_awlen             => CONNECTED_TO_hps2fpga_awlen,             --                     .awlen
			hps2fpga_awsize            => CONNECTED_TO_hps2fpga_awsize,            --                     .awsize
			hps2fpga_awburst           => CONNECTED_TO_hps2fpga_awburst,           --                     .awburst
			hps2fpga_awlock            => CONNECTED_TO_hps2fpga_awlock,            --                     .awlock
			hps2fpga_awcache           => CONNECTED_TO_hps2fpga_awcache,           --                     .awcache
			hps2fpga_awprot            => CONNECTED_TO_hps2fpga_awprot,            --                     .awprot
			hps2fpga_awvalid           => CONNECTED_TO_hps2fpga_awvalid,           --                     .awvalid
			hps2fpga_awready           => CONNECTED_TO_hps2fpga_awready,           --                     .awready
			hps2fpga_wdata             => CONNECTED_TO_hps2fpga_wdata,             --                     .wdata
			hps2fpga_wstrb             => CONNECTED_TO_hps2fpga_wstrb,             --                     .wstrb
			hps2fpga_wlast             => CONNECTED_TO_hps2fpga_wlast,             --                     .wlast
			hps2fpga_wvalid            => CONNECTED_TO_hps2fpga_wvalid,            --                     .wvalid
			hps2fpga_wready            => CONNECTED_TO_hps2fpga_wready,            --                     .wready
			hps2fpga_bid               => CONNECTED_TO_hps2fpga_bid,               --                     .bid
			hps2fpga_bresp             => CONNECTED_TO_hps2fpga_bresp,             --                     .bresp
			hps2fpga_bvalid            => CONNECTED_TO_hps2fpga_bvalid,            --                     .bvalid
			hps2fpga_bready            => CONNECTED_TO_hps2fpga_bready,            --                     .bready
			hps2fpga_arid              => CONNECTED_TO_hps2fpga_arid,              --                     .arid
			hps2fpga_araddr            => CONNECTED_TO_hps2fpga_araddr,            --                     .araddr
			hps2fpga_arlen             => CONNECTED_TO_hps2fpga_arlen,             --                     .arlen
			hps2fpga_arsize            => CONNECTED_TO_hps2fpga_arsize,            --                     .arsize
			hps2fpga_arburst           => CONNECTED_TO_hps2fpga_arburst,           --                     .arburst
			hps2fpga_arlock            => CONNECTED_TO_hps2fpga_arlock,            --                     .arlock
			hps2fpga_arcache           => CONNECTED_TO_hps2fpga_arcache,           --                     .arcache
			hps2fpga_arprot            => CONNECTED_TO_hps2fpga_arprot,            --                     .arprot
			hps2fpga_arvalid           => CONNECTED_TO_hps2fpga_arvalid,           --                     .arvalid
			hps2fpga_arready           => CONNECTED_TO_hps2fpga_arready,           --                     .arready
			hps2fpga_rid               => CONNECTED_TO_hps2fpga_rid,               --                     .rid
			hps2fpga_rdata             => CONNECTED_TO_hps2fpga_rdata,             --                     .rdata
			hps2fpga_rresp             => CONNECTED_TO_hps2fpga_rresp,             --                     .rresp
			hps2fpga_rlast             => CONNECTED_TO_hps2fpga_rlast,             --                     .rlast
			hps2fpga_rvalid            => CONNECTED_TO_hps2fpga_rvalid,            --                     .rvalid
			hps2fpga_rready            => CONNECTED_TO_hps2fpga_rready,            --                     .rready
			lwhps2fpga_axi_clock_clk   => CONNECTED_TO_lwhps2fpga_axi_clock_clk,   -- lwhps2fpga_axi_clock.clk
			lwhps2fpga_axi_reset_reset => CONNECTED_TO_lwhps2fpga_axi_reset_reset, -- lwhps2fpga_axi_reset.reset
			lwhps2fpga_awid            => CONNECTED_TO_lwhps2fpga_awid,            --           lwhps2fpga.awid
			lwhps2fpga_awaddr          => CONNECTED_TO_lwhps2fpga_awaddr,          --                     .awaddr
			lwhps2fpga_awlen           => CONNECTED_TO_lwhps2fpga_awlen,           --                     .awlen
			lwhps2fpga_awsize          => CONNECTED_TO_lwhps2fpga_awsize,          --                     .awsize
			lwhps2fpga_awburst         => CONNECTED_TO_lwhps2fpga_awburst,         --                     .awburst
			lwhps2fpga_awlock          => CONNECTED_TO_lwhps2fpga_awlock,          --                     .awlock
			lwhps2fpga_awcache         => CONNECTED_TO_lwhps2fpga_awcache,         --                     .awcache
			lwhps2fpga_awprot          => CONNECTED_TO_lwhps2fpga_awprot,          --                     .awprot
			lwhps2fpga_awvalid         => CONNECTED_TO_lwhps2fpga_awvalid,         --                     .awvalid
			lwhps2fpga_awready         => CONNECTED_TO_lwhps2fpga_awready,         --                     .awready
			lwhps2fpga_wdata           => CONNECTED_TO_lwhps2fpga_wdata,           --                     .wdata
			lwhps2fpga_wstrb           => CONNECTED_TO_lwhps2fpga_wstrb,           --                     .wstrb
			lwhps2fpga_wlast           => CONNECTED_TO_lwhps2fpga_wlast,           --                     .wlast
			lwhps2fpga_wvalid          => CONNECTED_TO_lwhps2fpga_wvalid,          --                     .wvalid
			lwhps2fpga_wready          => CONNECTED_TO_lwhps2fpga_wready,          --                     .wready
			lwhps2fpga_bid             => CONNECTED_TO_lwhps2fpga_bid,             --                     .bid
			lwhps2fpga_bresp           => CONNECTED_TO_lwhps2fpga_bresp,           --                     .bresp
			lwhps2fpga_bvalid          => CONNECTED_TO_lwhps2fpga_bvalid,          --                     .bvalid
			lwhps2fpga_bready          => CONNECTED_TO_lwhps2fpga_bready,          --                     .bready
			lwhps2fpga_arid            => CONNECTED_TO_lwhps2fpga_arid,            --                     .arid
			lwhps2fpga_araddr          => CONNECTED_TO_lwhps2fpga_araddr,          --                     .araddr
			lwhps2fpga_arlen           => CONNECTED_TO_lwhps2fpga_arlen,           --                     .arlen
			lwhps2fpga_arsize          => CONNECTED_TO_lwhps2fpga_arsize,          --                     .arsize
			lwhps2fpga_arburst         => CONNECTED_TO_lwhps2fpga_arburst,         --                     .arburst
			lwhps2fpga_arlock          => CONNECTED_TO_lwhps2fpga_arlock,          --                     .arlock
			lwhps2fpga_arcache         => CONNECTED_TO_lwhps2fpga_arcache,         --                     .arcache
			lwhps2fpga_arprot          => CONNECTED_TO_lwhps2fpga_arprot,          --                     .arprot
			lwhps2fpga_arvalid         => CONNECTED_TO_lwhps2fpga_arvalid,         --                     .arvalid
			lwhps2fpga_arready         => CONNECTED_TO_lwhps2fpga_arready,         --                     .arready
			lwhps2fpga_rid             => CONNECTED_TO_lwhps2fpga_rid,             --                     .rid
			lwhps2fpga_rdata           => CONNECTED_TO_lwhps2fpga_rdata,           --                     .rdata
			lwhps2fpga_rresp           => CONNECTED_TO_lwhps2fpga_rresp,           --                     .rresp
			lwhps2fpga_rlast           => CONNECTED_TO_lwhps2fpga_rlast,           --                     .rlast
			lwhps2fpga_rvalid          => CONNECTED_TO_lwhps2fpga_rvalid,          --                     .rvalid
			lwhps2fpga_rready          => CONNECTED_TO_lwhps2fpga_rready,          --                     .rready
			hps_io_gpio41              => CONNECTED_TO_hps_io_gpio41               --               hps_io.gpio41
		);

