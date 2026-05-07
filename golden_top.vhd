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
		  HPS_LED          	: inout std_logic;
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
			test_lpddr4b               : out   std_logic;                                        -- test_complete
			button_in                  : in    std_logic                     := 'X';             -- button_in
			s0_axi4_ctrl_ready_reset_n : out   std_logic;                                        -- reset_n
			mem_0_mem_cs               : out   std_logic_vector(0 downto 0);                     -- mem_cs
			mem_0_mem_ca               : out   std_logic_vector(5 downto 0);                     -- mem_ca
			mem_0_mem_cke              : out   std_logic_vector(0 downto 0);                     -- mem_cke
			mem_0_mem_dq               : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			mem_0_mem_dqs_t            : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_t
			mem_0_mem_dqs_c            : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_c
			mem_0_mem_dmi              : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dmi
			mem_ck_0_mem_ck_t          : out   std_logic_vector(0 downto 0);                     -- mem_ck_t
			mem_ck_0_mem_ck_c          : out   std_logic_vector(0 downto 0);                     -- mem_ck_c
			mem_reset_n_mem_reset_n    : out   std_logic;                                        -- mem_reset_n
			oct_0_oct_rzqin            : in    std_logic                     := 'X';             -- oct_rzqin
			ref_clk_clk                : in    std_logic                     := 'X';             -- clk
			hps_io_gpio41              : inout std_logic                     := 'X';             -- gpio41
			refclk_clk                 : in    std_logic                     := 'X';             -- clk
			locked_export              : out   std_logic;                                        -- export
			reset_reset                : in    std_logic                     := 'X';             -- reset
			in_reset_reset_n           : in    std_logic                     := 'X';             -- reset_n
			ninit_done_ninit_done      : out   std_logic;                                        -- ninit_done
			test_lwh2f                 : out   std_logic                                         -- test_complete
		);
	end component HPS_QSYS;

    signal mem_cs_v            : std_logic_vector(0 downto 0);
    signal mem_cke_v           : std_logic_vector(0 downto 0);
    signal mem_ck_t_v          : std_logic_vector(0 downto 0);
    signal mem_ck_c_v          : std_logic_vector(0 downto 0);

	-- Reset signals
    signal user_reset      : std_logic;  -- active high
    signal pll_locked      : std_logic;
    signal ninit_done      : std_logic;  -- high = hold reset, low = safe to run
    signal pll_reset       : std_logic;  -- active high, only for PLL reset input
    signal fabric_reset    : std_logic;  -- active high, for the rest of the system
    signal fabric_reset_n  : std_logic;  -- active low version for in_reset_reset_n

    signal read_test       : std_logic;
    signal test_result     : std_logic;
    signal axi_ctrl_rdy    : std_logic;
    signal test_lpddr4b    : std_logic;
    signal test_lwh2f      : std_logic; 

begin

    user_reset 	 <= not KEY(0);
	 pll_reset 	    <= user_reset or ninit_done;
    fabric_reset   <= user_reset or ninit_done or (not pll_locked);
    fabric_reset_n <= not fabric_reset;
	 
	 LPDDR4B_CS_n <= mem_cs_v(0);
    LPDDR4B_CKE  <= mem_cke_v(0);
    LPDDR4B_CK   <= mem_ck_t_v(0);
    LPDDR4B_CK_n <= mem_ck_c_v(0);

    read_test  	   <= KEY(1);

    LED(0)     	   <= not pll_locked;
    LED(1)     	   <= not axi_ctrl_rdy;
    LED(2)     	   <= not test_lpddr4b;
    LED(3)     	   <= not test_lwh2f;
    LED(4)     	   <= '1';
    LED(5)     	   <= '1';
    LED(6)     	   <= '1';
    LED(7)     	   <= '1';
    
    u0 : component HPS_QSYS
		port map (
         test_lpddr4b               => test_lpddr4b,
			button_in                  => read_test,
         s0_axi4_ctrl_ready_reset_n => axi_ctrl_rdy,
         mem_0_mem_cs               => mem_cs_v,
			mem_0_mem_ca               => LPDDR4B_CA,
			mem_0_mem_cke              => mem_cke_v,
			mem_0_mem_dq               => LPDDR4B_DQ,
			mem_0_mem_dqs_t            => LPDDR4B_DQS,
			mem_0_mem_dqs_c            => LPDDR4B_DQS_n,
			mem_0_mem_dmi              => LPDDR4B_DM,
			mem_ck_0_mem_ck_t          => mem_ck_t_v,
			mem_ck_0_mem_ck_c          => mem_ck_c_v,
			mem_reset_n_mem_reset_n    => LPDDR4B_RESET_n,
			oct_0_oct_rzqin            => LPDDR4B_RZQ,
			ref_clk_clk                => LPDDR4B_REFCLK_p,
         hps_io_gpio41              => HPS_LED,
			refclk_clk                 => CLOCK1_50,
         locked_export              => pll_locked,
         reset_reset                => pll_reset,
         in_reset_reset_n           => fabric_reset_n,
         ninit_done_ninit_done      => ninit_done,
         test_lwh2f                 => test_lwh2f
		);

end architecture;