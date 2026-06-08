library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity golden_top is
    port (
        -- clocks / keys / leds
        CLOCK1_50        : in    std_logic;
        KEY              : in    std_logic_vector(1 downto 0);
        LED              : out   std_logic_vector(7 downto 0);
        
        -- HPS dedicated I/O
        HPS_CLK_25		 	: in std_logic;
        HPS_ENET_MDC		: out std_logic;
        HPS_ENET_MDIO    	: inout std_logic;
        HPS_ENET_RX_CLK  	: in std_logic;
        HPS_ENET_RX_CTL  	: in std_logic;
        HPS_ENET_RX_DATA 	: in std_logic_vector(3 downto 0);
        HPS_ENET_TX_CLK  	: out std_logic;
        HPS_ENET_TX_CTL     : out std_logic;
        HPS_ENET_TX_DATA    : out std_logic_vector(3 downto 0);
--        HPS_GSENSOR_I2C_EN  : inout std_logic;
--        HPS_GSENSOR_INT     : inout std_logic;
        HPS_I2C_SCL         : inout std_logic;
        HPS_I2C_SDA         : inout std_logic;
--        HPS_KEY          	: inout std_logic;
--        HPS_LED          	: inout std_logic;
        HPS_SD_CLK  		: out std_logic;
        HPS_SD_CMD          : inout std_logic;
        HPS_SD_DATA 		: inout std_logic_vector(3 downto 0);
        HPS_UART_RX  		: in std_logic;
        HPS_UART_TX  		: out std_logic;
        HPS_USB_CLK			: in std_logic;
        HPS_USB_DATA 		: inout std_logic_vector(7 downto 0);
        HPS_USB_DIR  		: in std_logic;
        HPS_USB_NXT  		: in std_logic;
        HPS_USB_STP			: out std_logic;

		  -- LPDDR4A
        LPDDR4A_REFCLK_p : in    std_logic;
        LPDDR4A_CS_n     : out   std_logic;
        LPDDR4A_CA       : out   std_logic_vector(5 downto 0);
        LPDDR4A_CK       : out   std_logic;
        LPDDR4A_CKE      : out   std_logic;
        LPDDR4A_CK_n     : out   std_logic;
        LPDDR4A_DM       : inout std_logic_vector(3 downto 0);
        LPDDR4A_DQ       : inout std_logic_vector(31 downto 0);
        LPDDR4A_DQS      : inout std_logic_vector(3 downto 0);
        LPDDR4A_DQS_n    : inout std_logic_vector(3 downto 0);
        LPDDR4A_RESET_n  : out   std_logic;
        LPDDR4A_RZQ      : in    std_logic;
		  
        -- LPDDR4B
        LPDDR4B_REFCLK_p : in    std_logic;
        LPDDR4B_CS_n     : out   std_logic;
        LPDDR4B_CA       : out   std_logic_vector(5 downto 0);
        LPDDR4B_CK       : out   std_logic;
        LPDDR4B_CKE      : out   std_logic;
        LPDDR4B_CK_n     : out   std_logic;
        LPDDR4B_DM       : inout std_logic_vector(3 downto 0);
        LPDDR4B_DQ       : inout std_logic_vector(31 downto 0);
        LPDDR4B_DQS      : inout std_logic_vector(3 downto 0);
        LPDDR4B_DQS_n    : inout std_logic_vector(3 downto 0);
        LPDDR4B_RESET_n  : out   std_logic;
        LPDDR4B_RZQ      : in    std_logic
    );
end entity;

architecture rtl of golden_top is

    component HPS_QSYS is
		port (
			clk_clk                                        : in    std_logic                     := 'X';             -- clk
			emif_io96b_hps_0_mem_0_mem_cs                  : out   std_logic_vector(0 downto 0);                     -- mem_cs
			emif_io96b_hps_0_mem_0_mem_ca                  : out   std_logic_vector(5 downto 0);                     -- mem_ca
			emif_io96b_hps_0_mem_0_mem_cke                 : out   std_logic_vector(0 downto 0);                     -- mem_cke
			emif_io96b_hps_0_mem_0_mem_dq                  : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			emif_io96b_hps_0_mem_0_mem_dqs_t               : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_t
			emif_io96b_hps_0_mem_0_mem_dqs_c               : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_c
			emif_io96b_hps_0_mem_0_mem_dmi                 : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dmi
			emif_io96b_hps_0_mem_ck_0_mem_ck_t             : out   std_logic_vector(0 downto 0);                     -- mem_ck_t
			emif_io96b_hps_0_mem_ck_0_mem_ck_c             : out   std_logic_vector(0 downto 0);                     -- mem_ck_c
			emif_io96b_hps_0_mem_reset_n_mem_reset_n       : out   std_logic;                                        -- mem_reset_n
			emif_io96b_hps_0_oct_0_oct_rzqin               : in    std_logic                     := 'X';             -- oct_rzqin
			emif_io96b_hps_0_ref_clk_clk                   : in    std_logic                     := 'X';             -- clk
			emif_io96b_lpddr4_0_core_init_n_reset_n        : in    std_logic                     := 'X';             -- reset_n
			emif_io96b_lpddr4_0_s0_axi4_ctrl_ready_reset_n : out   std_logic;                                        -- reset_n
			emif_io96b_lpddr4_0_mem_0_mem_cs               : out   std_logic_vector(0 downto 0);                     -- mem_cs
			emif_io96b_lpddr4_0_mem_0_mem_ca               : out   std_logic_vector(5 downto 0);                     -- mem_ca
			emif_io96b_lpddr4_0_mem_0_mem_cke              : out   std_logic_vector(0 downto 0);                     -- mem_cke
			emif_io96b_lpddr4_0_mem_0_mem_dq               : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			emif_io96b_lpddr4_0_mem_0_mem_dqs_t            : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_t
			emif_io96b_lpddr4_0_mem_0_mem_dqs_c            : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_c
			emif_io96b_lpddr4_0_mem_0_mem_dmi              : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dmi
			emif_io96b_lpddr4_0_mem_ck_0_mem_ck_t          : out   std_logic_vector(0 downto 0);                     -- mem_ck_t
			emif_io96b_lpddr4_0_mem_ck_0_mem_ck_c          : out   std_logic_vector(0 downto 0);                     -- mem_ck_c
			emif_io96b_lpddr4_0_mem_reset_n_mem_reset_n    : out   std_logic;                                        -- mem_reset_n
			emif_io96b_lpddr4_0_oct_0_oct_rzqin            : in    std_logic                     := 'X';             -- oct_rzqin
			emif_io96b_lpddr4_0_ref_clk_clk                : in    std_logic                     := 'X';             -- clk
			intel_agilex_5_soc_0_hps_io_hps_osc_clk        : in    std_logic                     := 'X';             -- hps_osc_clk
			intel_agilex_5_soc_0_hps_io_sdmmc_data0        : inout std_logic                     := 'X';             -- sdmmc_data0
			intel_agilex_5_soc_0_hps_io_sdmmc_data1        : inout std_logic                     := 'X';             -- sdmmc_data1
			intel_agilex_5_soc_0_hps_io_sdmmc_cclk         : out   std_logic;                                        -- sdmmc_cclk
			intel_agilex_5_soc_0_hps_io_sdmmc_data2        : inout std_logic                     := 'X';             -- sdmmc_data2
			intel_agilex_5_soc_0_hps_io_sdmmc_data3        : inout std_logic                     := 'X';             -- sdmmc_data3
			intel_agilex_5_soc_0_hps_io_sdmmc_cmd          : inout std_logic                     := 'X';             -- sdmmc_cmd
			intel_agilex_5_soc_0_hps_io_usb0_clk           : in    std_logic                     := 'X';             -- usb0_clk
			intel_agilex_5_soc_0_hps_io_usb0_stp           : out   std_logic;                                        -- usb0_stp
			intel_agilex_5_soc_0_hps_io_usb0_dir           : in    std_logic                     := 'X';             -- usb0_dir
			intel_agilex_5_soc_0_hps_io_usb0_data0         : inout std_logic                     := 'X';             -- usb0_data0
			intel_agilex_5_soc_0_hps_io_usb0_data1         : inout std_logic                     := 'X';             -- usb0_data1
			intel_agilex_5_soc_0_hps_io_usb0_nxt           : in    std_logic                     := 'X';             -- usb0_nxt
			intel_agilex_5_soc_0_hps_io_usb0_data2         : inout std_logic                     := 'X';             -- usb0_data2
			intel_agilex_5_soc_0_hps_io_usb0_data3         : inout std_logic                     := 'X';             -- usb0_data3
			intel_agilex_5_soc_0_hps_io_usb0_data4         : inout std_logic                     := 'X';             -- usb0_data4
			intel_agilex_5_soc_0_hps_io_usb0_data5         : inout std_logic                     := 'X';             -- usb0_data5
			intel_agilex_5_soc_0_hps_io_usb0_data6         : inout std_logic                     := 'X';             -- usb0_data6
			intel_agilex_5_soc_0_hps_io_usb0_data7         : inout std_logic                     := 'X';             -- usb0_data7
			intel_agilex_5_soc_0_hps_io_emac0_tx_clk       : out   std_logic;                                        -- emac0_tx_clk
			intel_agilex_5_soc_0_hps_io_emac0_tx_ctl       : out   std_logic;                                        -- emac0_tx_ctl
			intel_agilex_5_soc_0_hps_io_emac0_rx_clk       : in    std_logic                     := 'X';             -- emac0_rx_clk
			intel_agilex_5_soc_0_hps_io_emac0_rx_ctl       : in    std_logic                     := 'X';             -- emac0_rx_ctl
			intel_agilex_5_soc_0_hps_io_emac0_txd0         : out   std_logic;                                        -- emac0_txd0
			intel_agilex_5_soc_0_hps_io_emac0_txd1         : out   std_logic;                                        -- emac0_txd1
			intel_agilex_5_soc_0_hps_io_emac0_rxd0         : in    std_logic                     := 'X';             -- emac0_rxd0
			intel_agilex_5_soc_0_hps_io_emac0_rxd1         : in    std_logic                     := 'X';             -- emac0_rxd1
			intel_agilex_5_soc_0_hps_io_emac0_txd2         : out   std_logic;                                        -- emac0_txd2
			intel_agilex_5_soc_0_hps_io_emac0_txd3         : out   std_logic;                                        -- emac0_txd3
			intel_agilex_5_soc_0_hps_io_emac0_rxd2         : in    std_logic                     := 'X';             -- emac0_rxd2
			intel_agilex_5_soc_0_hps_io_emac0_rxd3         : in    std_logic                     := 'X';             -- emac0_rxd3
			intel_agilex_5_soc_0_hps_io_mdio0_mdio         : inout std_logic                     := 'X';             -- mdio0_mdio
			intel_agilex_5_soc_0_hps_io_mdio0_mdc          : out   std_logic;                                        -- mdio0_mdc
			intel_agilex_5_soc_0_hps_io_uart1_tx           : out   std_logic;                                        -- uart1_tx
			intel_agilex_5_soc_0_hps_io_uart1_rx           : in    std_logic                     := 'X';             -- uart1_rx
			intel_agilex_5_soc_0_hps_io_i2c1_sda           : inout std_logic                     := 'X';             -- i2c1_sda
			intel_agilex_5_soc_0_hps_io_i2c1_scl           : inout std_logic                     := 'X';             -- i2c1_scl
			pll_locked_export                              : out   std_logic;                                        -- export
			reset_reset_n                                  : in    std_logic                     := 'X';             -- reset_n
			s10_user_rst_clkgate_0_ninit_done_reset        : out   std_logic;                                        -- reset
			test_lpddr4b_0_test_lpddr4b_export             : out   std_logic                                         -- export
		);
	end component HPS_QSYS;


    -- EMIF signals
    signal mem_cs_v            : std_logic_vector(0 downto 0);
    signal mem_cke_v           : std_logic_vector(0 downto 0);
    signal mem_ck_t_v          : std_logic_vector(0 downto 0);
    signal mem_ck_c_v          : std_logic_vector(0 downto 0);

    -- HPS EMIF signals
    signal hps_mem_cs_v            : std_logic_vector(0 downto 0);
    signal hps_mem_cke_v           : std_logic_vector(0 downto 0);
    signal hps_mem_ck_t_v          : std_logic_vector(0 downto 0);
    signal hps_mem_ck_c_v          : std_logic_vector(0 downto 0);

	-- Reset signals
    signal user_reset      : std_logic;  -- active high
    signal pll_locked      : std_logic;
    signal ninit_done      : std_logic;  -- high = hold reset, low = safe to run
    signal fabric_reset    : std_logic;  -- active high, for the rest of the system
    signal fabric_reset_n  : std_logic;  -- active low version for in_reset_reset_n

    -- HPS_QSYS signals
    signal axi_ctrl_rdy    : std_logic;
    signal test_lpddr4b    : std_logic;

begin

    user_reset 	 <= not KEY(0);
    fabric_reset   <= user_reset or ninit_done;
    fabric_reset_n <= not fabric_reset;
	 
	LPDDR4B_CS_n <= mem_cs_v(0);
    LPDDR4B_CKE  <= mem_cke_v(0);
    LPDDR4B_CK   <= mem_ck_t_v(0);
    LPDDR4B_CK_n <= mem_ck_c_v(0);

    LPDDR4A_CS_n <= hps_mem_cs_v(0);
    LPDDR4A_CKE  <= hps_mem_cke_v(0);
    LPDDR4A_CK   <= hps_mem_ck_t_v(0);
    LPDDR4A_CK_n <= hps_mem_ck_c_v(0);

    LED(0)     	   <= not pll_locked;
    LED(1)     	   <= not axi_ctrl_rdy;
    LED(2)     	   <= not test_lpddr4b;
    LED(3)     	   <= '1';
    LED(4)     	   <= '1';
    LED(5)     	   <= '1';
    LED(6)     	   <= '1';
    LED(7)     	   <= '1';

    u0 : component HPS_QSYS
            port map (
                clk_clk                                        => CLOCK1_50,
                emif_io96b_hps_0_mem_0_mem_cs                  => hps_mem_cs_v,
			    emif_io96b_hps_0_mem_0_mem_ca                  => LPDDR4A_CA,
			    emif_io96b_hps_0_mem_0_mem_cke                 => hps_mem_cke_v,
			    emif_io96b_hps_0_mem_0_mem_dq                  => LPDDR4A_DQ,
			    emif_io96b_hps_0_mem_0_mem_dqs_t               => LPDDR4A_DQS,
			    emif_io96b_hps_0_mem_0_mem_dqs_c               => LPDDR4A_DQS_n,
			    emif_io96b_hps_0_mem_0_mem_dmi                 => LPDDR4A_DM,
			    emif_io96b_hps_0_mem_ck_0_mem_ck_t             => hps_mem_ck_t_v,
			    emif_io96b_hps_0_mem_ck_0_mem_ck_c             => hps_mem_ck_c_v,
			    emif_io96b_hps_0_mem_reset_n_mem_reset_n       => LPDDR4A_RESET_n,
			    emif_io96b_hps_0_oct_0_oct_rzqin               => LPDDR4A_RZQ,
			    emif_io96b_hps_0_ref_clk_clk                   => LPDDR4A_REFCLK_p,
                emif_io96b_lpddr4_0_core_init_n_reset_n        => fabric_reset_n,
                emif_io96b_lpddr4_0_s0_axi4_ctrl_ready_reset_n => axi_ctrl_rdy,
                emif_io96b_lpddr4_0_mem_0_mem_cs               => mem_cs_v,
                emif_io96b_lpddr4_0_mem_0_mem_ca               => LPDDR4B_CA,
                emif_io96b_lpddr4_0_mem_0_mem_cke              => mem_cke_v,
                emif_io96b_lpddr4_0_mem_0_mem_dq               => LPDDR4B_DQ,
                emif_io96b_lpddr4_0_mem_0_mem_dqs_t            => LPDDR4B_DQS,
                emif_io96b_lpddr4_0_mem_0_mem_dqs_c            => LPDDR4B_DQS_n,
                emif_io96b_lpddr4_0_mem_0_mem_dmi              => LPDDR4B_DM,
                emif_io96b_lpddr4_0_mem_ck_0_mem_ck_t          => mem_ck_t_v,
                emif_io96b_lpddr4_0_mem_ck_0_mem_ck_c          => mem_ck_c_v,
                emif_io96b_lpddr4_0_mem_reset_n_mem_reset_n    => LPDDR4B_RESET_n,
                emif_io96b_lpddr4_0_oct_0_oct_rzqin            => LPDDR4B_RZQ,
                emif_io96b_lpddr4_0_ref_clk_clk                => LPDDR4B_REFCLK_p,
                intel_agilex_5_soc_0_hps_io_hps_osc_clk        => HPS_CLK_25,
                intel_agilex_5_soc_0_hps_io_sdmmc_data0        => HPS_SD_DATA(0),
                intel_agilex_5_soc_0_hps_io_sdmmc_data1        => HPS_SD_DATA(1),
                intel_agilex_5_soc_0_hps_io_sdmmc_cclk         => HPS_SD_CLK,
                intel_agilex_5_soc_0_hps_io_sdmmc_data2        => HPS_SD_DATA(2),
                intel_agilex_5_soc_0_hps_io_sdmmc_data3        => HPS_SD_DATA(3),
                intel_agilex_5_soc_0_hps_io_sdmmc_cmd          => HPS_SD_CMD,
                intel_agilex_5_soc_0_hps_io_usb0_clk           => HPS_USB_CLK,
                intel_agilex_5_soc_0_hps_io_usb0_stp           => HPS_USB_STP,
                intel_agilex_5_soc_0_hps_io_usb0_dir           => HPS_USB_DIR,
                intel_agilex_5_soc_0_hps_io_usb0_data0         => HPS_USB_DATA(0),
                intel_agilex_5_soc_0_hps_io_usb0_data1         => HPS_USB_DATA(1),
                intel_agilex_5_soc_0_hps_io_usb0_nxt           => HPS_USB_NXT,
                intel_agilex_5_soc_0_hps_io_usb0_data2         => HPS_USB_DATA(2),
                intel_agilex_5_soc_0_hps_io_usb0_data3         => HPS_USB_DATA(3),
                intel_agilex_5_soc_0_hps_io_usb0_data4         => HPS_USB_DATA(4),
                intel_agilex_5_soc_0_hps_io_usb0_data5         => HPS_USB_DATA(5),
                intel_agilex_5_soc_0_hps_io_usb0_data6         => HPS_USB_DATA(6),
                intel_agilex_5_soc_0_hps_io_usb0_data7         => HPS_USB_DATA(7),
                intel_agilex_5_soc_0_hps_io_emac0_tx_clk       => HPS_ENET_TX_CLK,
                intel_agilex_5_soc_0_hps_io_emac0_tx_ctl       => HPS_ENET_TX_CTL,
                intel_agilex_5_soc_0_hps_io_emac0_rx_clk       => HPS_ENET_RX_CLK,
                intel_agilex_5_soc_0_hps_io_emac0_rx_ctl       => HPS_ENET_RX_CTL,
                intel_agilex_5_soc_0_hps_io_emac0_txd0         => HPS_ENET_TX_DATA(0),
                intel_agilex_5_soc_0_hps_io_emac0_txd1         => HPS_ENET_TX_DATA(1),
                intel_agilex_5_soc_0_hps_io_emac0_rxd0         => HPS_ENET_RX_DATA(0),
                intel_agilex_5_soc_0_hps_io_emac0_rxd1         => HPS_ENET_RX_DATA(1),
                intel_agilex_5_soc_0_hps_io_emac0_txd2         => HPS_ENET_TX_DATA(2),
                intel_agilex_5_soc_0_hps_io_emac0_txd3         => HPS_ENET_TX_DATA(3),
                intel_agilex_5_soc_0_hps_io_emac0_rxd2         => HPS_ENET_RX_DATA(2),
                intel_agilex_5_soc_0_hps_io_emac0_rxd3         => HPS_ENET_RX_DATA(3),
                intel_agilex_5_soc_0_hps_io_mdio0_mdio         => HPS_ENET_MDIO,
                intel_agilex_5_soc_0_hps_io_mdio0_mdc          => HPS_ENET_MDC,
                intel_agilex_5_soc_0_hps_io_uart1_tx           => HPS_UART_TX,
                intel_agilex_5_soc_0_hps_io_uart1_rx           => HPS_UART_RX,
                intel_agilex_5_soc_0_hps_io_i2c1_sda           => HPS_I2C_SDA,
                intel_agilex_5_soc_0_hps_io_i2c1_scl           => HPS_I2C_SCL,
                pll_locked_export                              => pll_locked,
                reset_reset_n                                  => fabric_reset_n,
                s10_user_rst_clkgate_0_ninit_done_reset        => ninit_done,
                test_lpddr4b_0_test_lpddr4b_export             => test_lpddr4b
            );

end architecture;