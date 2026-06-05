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
--		  HPS_LED          	: inout std_logic;
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
			pll_locked_export                              : out   std_logic;                                        -- export
			reset_reset_n                                  : in    std_logic                     := 'X';             -- reset
         s10_user_rst_clkgate_0_ninit_done_reset        : out   std_logic;                                        -- reset
			test_lpddr4b_0_test_lpddr4b_export             : out   std_logic                                         -- export
		);
	end component HPS_QSYS;

    -- EMIF signals
    signal mem_cs_v            : std_logic_vector(0 downto 0);
    signal mem_cke_v           : std_logic_vector(0 downto 0);
    signal mem_ck_t_v          : std_logic_vector(0 downto 0);
    signal mem_ck_c_v          : std_logic_vector(0 downto 0);

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
                pll_locked_export                              => pll_locked,
                reset_reset_n                                  => fabric_reset_n,
                s10_user_rst_clkgate_0_ninit_done_reset        => ninit_done,
                test_lpddr4b_0_test_lpddr4b_export             => test_lpddr4b
            );

end architecture;