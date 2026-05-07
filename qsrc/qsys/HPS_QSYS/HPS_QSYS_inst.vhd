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

	u0 : component HPS_QSYS
		port map (
			test_lpddr4b               => CONNECTED_TO_test_lpddr4b,               --       test_lpddr4b.test_complete
			button_in                  => CONNECTED_TO_button_in,                  --          button_in.button_in
			s0_axi4_ctrl_ready_reset_n => CONNECTED_TO_s0_axi4_ctrl_ready_reset_n, -- s0_axi4_ctrl_ready.reset_n
			mem_0_mem_cs               => CONNECTED_TO_mem_0_mem_cs,               --              mem_0.mem_cs
			mem_0_mem_ca               => CONNECTED_TO_mem_0_mem_ca,               --                   .mem_ca
			mem_0_mem_cke              => CONNECTED_TO_mem_0_mem_cke,              --                   .mem_cke
			mem_0_mem_dq               => CONNECTED_TO_mem_0_mem_dq,               --                   .mem_dq
			mem_0_mem_dqs_t            => CONNECTED_TO_mem_0_mem_dqs_t,            --                   .mem_dqs_t
			mem_0_mem_dqs_c            => CONNECTED_TO_mem_0_mem_dqs_c,            --                   .mem_dqs_c
			mem_0_mem_dmi              => CONNECTED_TO_mem_0_mem_dmi,              --                   .mem_dmi
			mem_ck_0_mem_ck_t          => CONNECTED_TO_mem_ck_0_mem_ck_t,          --           mem_ck_0.mem_ck_t
			mem_ck_0_mem_ck_c          => CONNECTED_TO_mem_ck_0_mem_ck_c,          --                   .mem_ck_c
			mem_reset_n_mem_reset_n    => CONNECTED_TO_mem_reset_n_mem_reset_n,    --        mem_reset_n.mem_reset_n
			oct_0_oct_rzqin            => CONNECTED_TO_oct_0_oct_rzqin,            --              oct_0.oct_rzqin
			ref_clk_clk                => CONNECTED_TO_ref_clk_clk,                --            ref_clk.clk
			hps_io_gpio41              => CONNECTED_TO_hps_io_gpio41,              --             hps_io.gpio41
			refclk_clk                 => CONNECTED_TO_refclk_clk,                 --             refclk.clk
			locked_export              => CONNECTED_TO_locked_export,              --             locked.export
			reset_reset                => CONNECTED_TO_reset_reset,                --              reset.reset
			in_reset_reset_n           => CONNECTED_TO_in_reset_reset_n,           --           in_reset.reset_n
			ninit_done_ninit_done      => CONNECTED_TO_ninit_done_ninit_done,      --         ninit_done.ninit_done
			test_lwh2f                 => CONNECTED_TO_test_lwh2f                  --         test_lwh2f.test_complete
		);

