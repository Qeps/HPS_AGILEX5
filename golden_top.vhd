library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity golden_top is
   port (
      ------- CLOCK -------
      CLOCK0_50             : in    std_logic;
      CLOCK1_50             : in    std_logic;
      CLOCK2_50             : in    std_logic;

      ------- KEY -------
      KEY                   : in    std_logic_vector( 1 downto 0);  -- BUTTON is Low-Active

      ------- SW -------
      SW                    : in    std_logic_vector( 3 downto 0);

      ------- LED -------
      LED                   : out   std_logic_vector( 7 downto 0);

      ------- SDRAM -------
      DRAM_CLK              : out   std_logic;
      DRAM_CKE              : out   std_logic;
      DRAM_ADDR             : out   std_logic_vector(12 downto 0);
      DRAM_BA               : out   std_logic_vector( 1 downto 0);
      DRAM_DQ               : inout std_logic_vector(15 downto 0);
      DRAM_LDQM             : out   std_logic;
      DRAM_UDQM             : out   std_logic;
      DRAM_CS_n             : out   std_logic_vector( 1 downto 0);
      DRAM_WE_n             : out   std_logic;
      DRAM_CAS_n            : out   std_logic;
      DRAM_RAS_n            : out   std_logic;

      -- ENABLE_LPDDR4A ---------------------------------------------------
      ------- LPDDR4A -------
      LPDDR4A_REFCLK_p      : in    std_logic;
      LPDDR4A_CS_n          : out   std_logic;
      LPDDR4A_CA            : out   std_logic_vector( 5 downto 0);
      LPDDR4A_CK            : out   std_logic;
      LPDDR4A_CKE           : out   std_logic;
      LPDDR4A_CK_n          : out   std_logic;
      LPDDR4A_DM            : inout std_logic_vector( 3 downto 0);
      LPDDR4A_DQ            : inout std_logic_vector(31 downto 0);
      LPDDR4A_DQS           : inout std_logic_vector( 3 downto 0);
      LPDDR4A_DQS_n         : inout std_logic_vector( 3 downto 0);
      LPDDR4A_RESET_n       : out   std_logic;
      LPDDR4A_RZQ           : in    std_logic;
      -- end ENABLE_LPDDR4A -----------------------------------------------

      -- ENABLE_LPDDR4B ---------------------------------------------------
      ------- LPDDR4B -------
      LPDDR4B_REFCLK_p      : in    std_logic;
      LPDDR4B_CS_n          : out   std_logic;
      LPDDR4B_CA            : out   std_logic_vector( 5 downto 0);
      LPDDR4B_CK            : out   std_logic;
      LPDDR4B_CKE           : out   std_logic;
      LPDDR4B_CK_n          : out   std_logic;
      LPDDR4B_DM            : inout std_logic_vector( 3 downto 0);
      LPDDR4B_DQ            : inout std_logic_vector(31 downto 0);
      LPDDR4B_DQS           : inout std_logic_vector( 3 downto 0);
      LPDDR4B_DQS_n         : inout std_logic_vector( 3 downto 0);
      LPDDR4B_RESET_n       : out   std_logic;
      LPDDR4B_RZQ           : in    std_logic;
      -- end ENABLE_LPDDR4B -----------------------------------------------

      ------- HDMI -------
      HDMI_LRCLK            : inout std_logic;
      HDMI_MCLK             : inout std_logic;
      HDMI_SCLK             : inout std_logic;
      HDMI_TX_CLK           : out   std_logic;
      HDMI_TX_HS            : out   std_logic;
      HDMI_TX_VS            : out   std_logic;
      HDMI_TX_D             : out   std_logic_vector(23 downto 0);
      HDMI_TX_DE            : out   std_logic;
      HDMI_I2C_SCL          : inout std_logic;
      HDMI_I2C_SDA          : inout std_logic;
      HDMI_TX_INT           : in    std_logic;
      HDMI_I2S              : inout std_logic;

      ------- FPGA UART -------
      FPGA_UART_TX          : out   std_logic;
      FPGA_UART_RX          : in    std_logic;

      ------- ADC -------
      ADC_SCK               : out   std_logic;
      ADC_SDO               : in    std_logic;
      ADC_SDI               : out   std_logic;
      ADC_CS_n              : out   std_logic;

      ------- GPIO -------
      GPIO0_D               : inout std_logic_vector(35 downto 0);
      GPIO1_D               : inout std_logic_vector(35 downto 0);

      -- ENABLE_HPS -------------------------------------------------------
      ------- HPS -------
      HPS_CLK_25            : in    std_logic;
      HPS_ENET_MDC          : out   std_logic;
      HPS_ENET_MDIO         : inout std_logic;
      HPS_ENET_RX_CLK       : in    std_logic;
      HPS_ENET_RX_CTL       : in    std_logic;
      HPS_ENET_RX_DATA      : in    std_logic_vector( 3 downto 0);
      HPS_ENET_TX_CLK       : out   std_logic;
      HPS_ENET_TX_CTL       : out   std_logic;
      HPS_ENET_TX_DATA      : out   std_logic_vector( 3 downto 0);
      HPS_GSENSOR_I2C_EN    : inout std_logic;
      HPS_GSENSOR_INT       : inout std_logic;
      HPS_I2C_SCL           : inout std_logic;
      HPS_I2C_SDA           : inout std_logic;
      HPS_KEY               : inout std_logic;
      HPS_LED               : inout std_logic;
      HPS_SD_CLK            : out   std_logic;
      HPS_SD_CMD            : inout std_logic;
      HPS_SD_DATA           : inout std_logic_vector( 3 downto 0);
      HPS_UART_RX           : in    std_logic;
      HPS_UART_TX           : out   std_logic;
      HPS_USB_CLK           : in    std_logic;
      HPS_USB_DATA          : inout std_logic_vector( 7 downto 0);
      HPS_USB_DIR           : in    std_logic;
      HPS_USB_NXT           : in    std_logic;
      HPS_USB_STP           : out   std_logic;
      -- end ENABLE_HPS ---------------------------------------------------

      ------- FAN -------
      FAN_ALERT_n           : in    std_logic
   );
end entity golden_top;

architecture rtl of golden_top is

   --=======================================================
   --  Component declarations
   --=======================================================
   component pll is
      port (
         refclk   : in  std_logic;
         locked   : out std_logic;
         rst      : in  std_logic;
         outclk_0 : out std_logic
      );
   end component pll;

   component qsys_top is
      port (
         clk_100_clk                                    : in    std_logic;
         reset_reset_n                                  : in    std_logic;
         ninit_done_ninit_done                          : out   std_logic;
         led_pio_external_connection_in_port            : in    std_logic_vector( 2 downto 0);
         led_pio_external_connection_out_port           : out   std_logic_vector( 2 downto 0);
         dipsw_pio_external_connection_export           : in    std_logic_vector( 3 downto 0);
         button_pio_external_connection_export          : in    std_logic_vector( 3 downto 0);

         hps_io_hps_osc_clk                             : in    std_logic;
         emif_hps_emif_mem_0_mem_cs                     : out   std_logic_vector( 0 downto 0);
         emif_hps_emif_mem_0_mem_ca                     : out   std_logic_vector( 5 downto 0);
         emif_hps_emif_mem_0_mem_cke                    : out   std_logic_vector( 0 downto 0);
         emif_hps_emif_mem_0_mem_dq                     : inout std_logic_vector(31 downto 0);
         emif_hps_emif_mem_0_mem_dqs_t                  : inout std_logic_vector( 3 downto 0);
         emif_hps_emif_mem_0_mem_dqs_c                  : inout std_logic_vector( 3 downto 0);
         emif_hps_emif_mem_0_mem_dmi                    : inout std_logic_vector( 3 downto 0);
         emif_hps_emif_mem_ck_0_mem_ck_t                : out   std_logic_vector( 0 downto 0);
         emif_hps_emif_mem_ck_0_mem_ck_c                : out   std_logic_vector( 0 downto 0);
         emif_hps_emif_mem_reset_n_mem_reset_n          : out   std_logic;
         emif_hps_emif_oct_0_oct_rzqin                  : in    std_logic;
         emif_hps_emif_ref_clk_0_clk                    : in    std_logic;
         hps_io_emac0_tx_clk                            : out   std_logic;
         hps_io_emac0_rx_clk                            : in    std_logic;
         hps_io_emac0_tx_ctl                            : out   std_logic;
         hps_io_emac0_rx_ctl                            : in    std_logic;
         hps_io_emac0_txd0                              : out   std_logic;
         hps_io_emac0_txd1                              : out   std_logic;
         hps_io_emac0_rxd0                              : in    std_logic;
         hps_io_emac0_rxd1                              : in    std_logic;
         hps_io_emac0_txd2                              : out   std_logic;
         hps_io_emac0_txd3                              : out   std_logic;
         hps_io_emac0_rxd2                              : in    std_logic;
         hps_io_emac0_rxd3                              : in    std_logic;
         hps_io_mdio0_mdio                              : inout std_logic;
         hps_io_mdio0_mdc                               : out   std_logic;
         hps_io_sdmmc_cclk                              : out   std_logic;
         hps_io_sdmmc_cmd                               : inout std_logic;
         hps_io_sdmmc_data0                             : inout std_logic;
         hps_io_sdmmc_data1                             : inout std_logic;
         hps_io_sdmmc_data2                             : inout std_logic;
         hps_io_sdmmc_data3                             : inout std_logic;
         hps_io_uart1_rx                                : in    std_logic;
         hps_io_uart1_tx                                : out   std_logic;
         hps_io_usb0_clk                                : in    std_logic;
         hps_io_usb0_stp                                : out   std_logic;
         hps_io_usb0_dir                                : in    std_logic;
         hps_io_usb0_nxt                                : in    std_logic;
         hps_io_usb0_data0                              : inout std_logic;
         hps_io_usb0_data1                              : inout std_logic;
         hps_io_usb0_data2                              : inout std_logic;
         hps_io_usb0_data3                              : inout std_logic;
         hps_io_usb0_data4                              : inout std_logic;
         hps_io_usb0_data5                              : inout std_logic;
         hps_io_usb0_data6                              : inout std_logic;
         hps_io_usb0_data7                              : inout std_logic;
         hps_io_i2c1_sda                                : inout std_logic;
         hps_io_i2c1_scl                                : inout std_logic;
         hps_io_gpio28                                  : inout std_logic;
         hps_io_gpio34                                  : inout std_logic;
         hps_io_gpio40                                  : inout std_logic;
         hps_io_gpio41                                  : inout std_logic;
         emif_io96b_lpddr4_0_s0_axi4_ctrl_ready_reset_n : out   std_logic;
         emif_io96b_lpddr4_0_mem_0_mem_cs               : out   std_logic_vector( 0 downto 0);
         emif_io96b_lpddr4_0_mem_0_mem_ca               : out   std_logic_vector( 5 downto 0);
         emif_io96b_lpddr4_0_mem_0_mem_cke              : out   std_logic_vector( 0 downto 0);
         emif_io96b_lpddr4_0_mem_0_mem_dq               : inout std_logic_vector(31 downto 0);
         emif_io96b_lpddr4_0_mem_0_mem_dqs_t            : inout std_logic_vector( 3 downto 0);
         emif_io96b_lpddr4_0_mem_0_mem_dqs_c            : inout std_logic_vector( 3 downto 0);
         emif_io96b_lpddr4_0_mem_0_mem_dmi              : inout std_logic_vector( 3 downto 0);
         emif_io96b_lpddr4_0_mem_ck_0_mem_ck_t          : out   std_logic_vector( 0 downto 0);
         emif_io96b_lpddr4_0_mem_ck_0_mem_ck_c          : out   std_logic_vector( 0 downto 0);
         emif_io96b_lpddr4_0_mem_reset_n_mem_reset_n    : out   std_logic;
         emif_io96b_lpddr4_0_oct_0_oct_rzqin            : in    std_logic;
         emif_io96b_lpddr4_0_ref_clk_clk                : in    std_logic;
			f2h_test_complete_export                       : out   std_logic;
         f2sdram_test_complete_export                   : out   std_logic
      );
   end component qsys_top;

   component debounce is
      generic (
         WIDTH         : integer := 1;
         POLARITY      : string  := "HIGH";
         TIMEOUT       : integer := 1;
         TIMEOUT_WIDTH : integer := 1
      );
      port (
         clk      : in  std_logic;
         reset_n  : in  std_logic;
         data_in  : in  std_logic_vector(WIDTH-1 downto 0);
         data_out : out std_logic_vector(WIDTH-1 downto 0)
      );
   end component debounce;

   --=======================================================
   --  REG/WIRE declarations
   --=======================================================
   signal system_clk_50           : std_logic;
   signal system_clk_100_internal : std_logic;
   signal ninit_done              : std_logic;
   signal system_reset_n          : std_logic;
   signal fpga_led_pio            : std_logic_vector(7 downto 0);
   signal fpga_dipsw_pio          : std_logic_vector(3 downto 0);
   signal fpga_button_pio         : std_logic_vector(1 downto 0);
   signal fpga_debounced_buttons  : std_logic_vector(1 downto 0);
   -- button_pio is 4 bits wide in qsys_top but the board only has 2 keys;
   -- the unused bits are tied to the inactive (high) level.
   signal fpga_button_pio_padded  : std_logic_vector(3 downto 0);
   signal fpga_led_internal       : std_logic_vector(2 downto 0);
   signal heartbeat_led           : std_logic;
   signal heartbeat_count         : unsigned(24 downto 0);
   signal f2h_test_complete       : std_logic;
   signal f2sdram_test_complete   : std_logic;

   -- Start delay before the AXI testers issue their first transaction.
   constant START_DELAY_CYCLES    : natural := 1000000000;  -- 10 s at 100 MHz
   constant START_DELAY_LAST      : natural := START_DELAY_CYCLES - 1;
   constant START_DELAY_WIDTH     : natural := 30;          -- ceil(log2(1e9))

   signal start_counter           : unsigned(START_DELAY_WIDTH-1 downto 0);
   signal tests_armed             : std_logic;

begin

   --=======================================================
   --  Structural coding
   --=======================================================
   system_reset_n  <= not ninit_done;
   system_clk_50   <= CLOCK2_50;

   -- LEDs are active low: '0' lights the LED, '1' turns it off.
   -- LED(0) = f2h bridge tester passed, LED(1) = f2sdram bridge tester passed,
   -- LED(2) = start delay expired / testers armed, all other LEDs stay off.
   -- LED(2) dark means the testers have not started yet; LED(2) lit with
   -- LED(0)/LED(1) dark means a test ran and failed.
   LED(0)          <= not f2h_test_complete;
   LED(1)          <= not f2sdram_test_complete;
   LED(2)          <= not tests_armed;
   LED(7 downto 3) <= (others => '1');
   fpga_dipsw_pio  <= SW;
   fpga_button_pio <= KEY;
   heartbeat_led   <= not heartbeat_count(24);
   -- LED(7) = heartbeat, LED(2 downto 0) = led_pio from the SoC, rest unused
   fpga_led_pio    <= heartbeat_led & "0000" & fpga_led_internal;

   fpga_button_pio_padded <= "11" & fpga_debounced_buttons;

   pll_inst : component pll
      port map (
         refclk   => system_clk_50,
         locked   => open,
         rst      => ninit_done,
         outclk_0 => system_clk_100_internal
      );

   soc_inst : component qsys_top
      port map (
         clk_100_clk                               => system_clk_100_internal,
         reset_reset_n                             => system_reset_n,
         ninit_done_ninit_done                     => ninit_done,
         led_pio_external_connection_in_port       => fpga_led_internal,
         led_pio_external_connection_out_port      => fpga_led_internal,
         dipsw_pio_external_connection_export      => fpga_dipsw_pio,
         button_pio_external_connection_export     => fpga_button_pio_padded,

         hps_io_hps_osc_clk                        => HPS_CLK_25,
         emif_hps_emif_mem_0_mem_cs(0)             => LPDDR4A_CS_n,
         emif_hps_emif_mem_0_mem_ca                => LPDDR4A_CA,
         emif_hps_emif_mem_0_mem_cke(0)            => LPDDR4A_CKE,
         emif_hps_emif_mem_0_mem_dq                => LPDDR4A_DQ,
         emif_hps_emif_mem_0_mem_dqs_t             => LPDDR4A_DQS,
         emif_hps_emif_mem_0_mem_dqs_c             => LPDDR4A_DQS_n,
         emif_hps_emif_mem_0_mem_dmi               => LPDDR4A_DM,
         emif_hps_emif_mem_ck_0_mem_ck_t(0)        => LPDDR4A_CK,
         emif_hps_emif_mem_ck_0_mem_ck_c(0)        => LPDDR4A_CK_n,
         emif_hps_emif_mem_reset_n_mem_reset_n     => LPDDR4A_RESET_n,
         emif_hps_emif_oct_0_oct_rzqin             => LPDDR4A_RZQ,
         emif_hps_emif_ref_clk_0_clk               => LPDDR4A_REFCLK_p,
         hps_io_emac0_tx_clk                       => HPS_ENET_TX_CLK,
         hps_io_emac0_rx_clk                       => HPS_ENET_RX_CLK,
         hps_io_emac0_tx_ctl                       => HPS_ENET_TX_CTL,
         hps_io_emac0_rx_ctl                       => HPS_ENET_RX_CTL,
         hps_io_emac0_txd0                         => HPS_ENET_TX_DATA(0),
         hps_io_emac0_txd1                         => HPS_ENET_TX_DATA(1),
         hps_io_emac0_rxd0                         => HPS_ENET_RX_DATA(0),
         hps_io_emac0_rxd1                         => HPS_ENET_RX_DATA(1),
         hps_io_emac0_txd2                         => HPS_ENET_TX_DATA(2),
         hps_io_emac0_txd3                         => HPS_ENET_TX_DATA(3),
         hps_io_emac0_rxd2                         => HPS_ENET_RX_DATA(2),
         hps_io_emac0_rxd3                         => HPS_ENET_RX_DATA(3),
         hps_io_mdio0_mdio                         => HPS_ENET_MDIO,
         hps_io_mdio0_mdc                          => HPS_ENET_MDC,
         hps_io_sdmmc_cclk                         => HPS_SD_CLK,
         hps_io_sdmmc_cmd                          => HPS_SD_CMD,
         hps_io_sdmmc_data0                        => HPS_SD_DATA(0),
         hps_io_sdmmc_data1                        => HPS_SD_DATA(1),
         hps_io_sdmmc_data2                        => HPS_SD_DATA(2),
         hps_io_sdmmc_data3                        => HPS_SD_DATA(3),
         hps_io_uart1_rx                           => HPS_UART_RX,
         hps_io_uart1_tx                           => HPS_UART_TX,
         hps_io_usb0_clk                           => HPS_USB_CLK,
         hps_io_usb0_stp                           => HPS_USB_STP,
         hps_io_usb0_dir                           => HPS_USB_DIR,
         -- Todo clarify for NXT or NXR
         hps_io_usb0_nxt                           => HPS_USB_NXT,
         hps_io_usb0_data0                         => HPS_USB_DATA(0),
         hps_io_usb0_data1                         => HPS_USB_DATA(1),
         hps_io_usb0_data2                         => HPS_USB_DATA(2),
         hps_io_usb0_data3                         => HPS_USB_DATA(3),
         hps_io_usb0_data4                         => HPS_USB_DATA(4),
         hps_io_usb0_data5                         => HPS_USB_DATA(5),
         hps_io_usb0_data6                         => HPS_USB_DATA(6),
         hps_io_usb0_data7                         => HPS_USB_DATA(7),
         hps_io_i2c1_sda                           => HPS_I2C_SDA,
         hps_io_i2c1_scl                           => HPS_I2C_SCL,
         hps_io_gpio28                             => HPS_GSENSOR_INT,
         hps_io_gpio34                             => HPS_GSENSOR_I2C_EN,
         hps_io_gpio40                             => HPS_KEY,
         hps_io_gpio41                             => HPS_LED,
         emif_io96b_lpddr4_0_s0_axi4_ctrl_ready_reset_n => open,
         emif_io96b_lpddr4_0_mem_0_mem_cs(0)            => LPDDR4B_CS_n,
         emif_io96b_lpddr4_0_mem_0_mem_ca               => LPDDR4B_CA,
         emif_io96b_lpddr4_0_mem_0_mem_cke(0)           => LPDDR4B_CKE,
         emif_io96b_lpddr4_0_mem_0_mem_dq               => LPDDR4B_DQ,
         emif_io96b_lpddr4_0_mem_0_mem_dqs_t            => LPDDR4B_DQS,
         emif_io96b_lpddr4_0_mem_0_mem_dqs_c            => LPDDR4B_DQS_n,
         emif_io96b_lpddr4_0_mem_0_mem_dmi              => LPDDR4B_DM,
         emif_io96b_lpddr4_0_mem_ck_0_mem_ck_t(0)       => LPDDR4B_CK,
         emif_io96b_lpddr4_0_mem_ck_0_mem_ck_c(0)       => LPDDR4B_CK_n,
         emif_io96b_lpddr4_0_mem_reset_n_mem_reset_n    => LPDDR4B_RESET_n,
         emif_io96b_lpddr4_0_oct_0_oct_rzqin            => LPDDR4B_RZQ,
         emif_io96b_lpddr4_0_ref_clk_clk                => LPDDR4B_REFCLK_p,
         f2h_test_complete_export                       => f2h_test_complete,
         f2sdram_test_complete_export                   => f2sdram_test_complete
      );

   -- Debounce logic to clean out glitches within 1ms
   debounce_inst : component debounce
      generic map (
         WIDTH         => 2,
         POLARITY      => "LOW",
         TIMEOUT       => 10000,   -- at 100Mhz this is a debounce time of 1ms
         TIMEOUT_WIDTH => 32       -- ceil(log2(TIMEOUT))
      )
      port map (
         clk      => system_clk_100_internal,
         reset_n  => system_reset_n,
         data_in  => fpga_button_pio,
         data_out => fpga_debounced_buttons
      );

   -- Mirrors the start delay counter inside each axi4 tester so the board shows
   -- when the transactions were released.
   start_delay_proc : process (system_clk_100_internal, system_reset_n)
   begin
      if system_reset_n = '0' then
         start_counter <= (others => '0');
         tests_armed   <= '0';
      elsif rising_edge(system_clk_100_internal) then
         if start_counter = to_unsigned(START_DELAY_LAST, START_DELAY_WIDTH) then
            tests_armed <= '1';
         else
            start_counter <= start_counter + 1;
         end if;
      end if;
   end process start_delay_proc;

   heartbeat_proc : process (system_clk_100_internal, system_reset_n)
   begin
      if system_reset_n = '0' then
         heartbeat_count <= (others => '0');
      elsif rising_edge(system_clk_100_internal) then
         heartbeat_count <= heartbeat_count + 1;
      end if;
   end process heartbeat_proc;

end architecture rtl;