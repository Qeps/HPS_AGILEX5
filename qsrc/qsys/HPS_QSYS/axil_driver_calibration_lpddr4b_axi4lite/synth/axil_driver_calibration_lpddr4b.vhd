library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity axil_driver_calibration_lpddr4b is
    generic (
        STATUS_REGISTER_ADDRESS   : natural  := 16#05000400#;
        AXIL_DRIVER_ADDRESS_WIDTH : positive := 27
    );
    port (
        clk    : in  std_logic;
        rst_n  : in  std_logic;

        araddr  : out std_logic_vector(AXIL_DRIVER_ADDRESS_WIDTH - 1 downto 0);
        arprot  : out std_logic_vector(2 downto 0);
        arvalid : out std_logic;
        arready : in  std_logic;
        rdata   : in  std_logic_vector(31 downto 0);
        rresp   : in  std_logic_vector(1 downto 0);
        rvalid  : in  std_logic;
        rready  : out std_logic;

        awaddr  : out std_logic_vector(AXIL_DRIVER_ADDRESS_WIDTH - 1 downto 0);
        awprot  : out std_logic_vector(2 downto 0);
        awvalid : out std_logic;
        awready : in  std_logic;
        wdata   : out std_logic_vector(31 downto 0);
        wstrb   : out std_logic_vector(3 downto 0);
        wvalid  : out std_logic;
        wready  : in  std_logic;
        bresp   : in  std_logic_vector(1 downto 0);
        bvalid  : in  std_logic;
        bready  : out std_logic;

        cal_done_rst_n      : out std_logic
    );
	 
	 -- Visual Designer Studio / Platform Designer interface metadata.
    -- AXI4-Lite memory-mapped interface. Interface mode is "manager" for this AXI-Lite master.
    attribute altera_ip : string;
    attribute altera_ip of axil_driver_calibration_lpddr4b : entity is "altera.com:ip:axi4_master:1.0";

    attribute altera_interface : string;
	 attribute altera_port      : string;
	 attribute altera_interface of clk : signal is "altera.com:interfaces:altera_clock:1.0 in clk clk";
	 attribute altera_interface of rst_n : signal is "altera.com:interfaces:altera_reset:1.0 in rst_n reset_n";
	 attribute altera_port of araddr : signal is "clockref:clk, resetref:rst_n";

    -- AXI4-Lite memory-mapped manager interface: axi_m
	 attribute altera_interface of araddr  : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m araddr";
	 attribute altera_interface of arprot  : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m arprot";
	 attribute altera_interface of arvalid : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m arvalid";
	 attribute altera_interface of arready : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m arready";
	 attribute altera_interface of rdata   : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m rdata";
	 attribute altera_interface of rresp   : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m rresp";
	 attribute altera_interface of rvalid  : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m rvalid";
	 attribute altera_interface of rready  : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m rready";
	 
	 
    attribute altera_interface of awaddr  : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m awaddr";
	 attribute altera_interface of awprot  : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m awprot";
	 attribute altera_interface of awvalid : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m awvalid";
	 attribute altera_interface of awready : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m awready";
	 attribute altera_interface of wdata   : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m wdata";
	 attribute altera_interface of wstrb   : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m wstrb";
	 attribute altera_interface of wvalid  : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m wvalid";
	 attribute altera_interface of wready  : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m wready";
	 attribute altera_interface of bresp   : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m bresp";
	 attribute altera_interface of bvalid  : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m bvalid";
	 attribute altera_interface of bready  : signal is "altera.com:interfaces:altera_axi4lite:1.0 manager axi_m bready";
    
end entity;

architecture rtl of axil_driver_calibration_lpddr4b is

    type read_state_type is (
        WAIT_NOC_INIT,
        RD_IDLE,
        RD_INIT_DELAY,
        RD_SEND_ARADDR,
        RD_WAIT_RRESP,
        RD_TERMINATE
    );

    signal r_araddr  : std_logic_vector(AXIL_DRIVER_ADDRESS_WIDTH - 1 downto 0);
    signal r_arprot  : std_logic_vector(2 downto 0);
    signal r_arvalid : std_logic;
    signal r_rready  : std_logic;

    signal r_awaddr  : std_logic_vector(AXIL_DRIVER_ADDRESS_WIDTH - 1 downto 0);
    signal r_awprot  : std_logic_vector(2 downto 0);
    signal r_awvalid : std_logic;
    signal r_wdata   : std_logic_vector(31 downto 0);
    signal r_wstrb   : std_logic_vector(3 downto 0);
    signal r_wvalid  : std_logic;
    signal r_bready  : std_logic;

    signal r_cal_done_rst_n      : std_logic;

    signal r_fsm_cs : read_state_type := WAIT_NOC_INIT;
    signal c_fsm_ns : read_state_type := WAIT_NOC_INIT;

    signal r_read_wait_ctr : unsigned(3 downto 0);

    constant C_STATUS_ADDR : std_logic_vector(AXIL_DRIVER_ADDRESS_WIDTH - 1 downto 0) :=
        std_logic_vector(to_unsigned(STATUS_REGISTER_ADDRESS, AXIL_DRIVER_ADDRESS_WIDTH));

    constant C_INIT_WAIT : unsigned(3 downto 0) := "0111";

begin

    araddr  <= r_araddr;
    arprot  <= r_arprot;
    arvalid <= r_arvalid;
    rready  <= r_rready;

    awaddr  <= r_awaddr;
    awprot  <= r_awprot;
    awvalid <= r_awvalid;
    wdata   <= r_wdata;
    wstrb   <= r_wstrb;
    wvalid  <= r_wvalid;
    bready  <= r_bready;

    cal_done_rst_n <= r_cal_done_rst_n;

    p_regs : process(clk, rst_n)
    begin
        if rst_n = '0' then
            r_araddr  <= C_STATUS_ADDR;
            r_arprot  <= "000";
            r_arvalid <= '0';
            r_rready  <= '0';

            r_awaddr  <= (others => '0');
            r_awprot  <= "000";
            r_awvalid <= '0';
            r_wdata   <= (others => '0');
            r_wstrb   <= (others => '0');
            r_wvalid  <= '0';
            r_bready  <= '0';

            r_cal_done_rst_n      <= '0';

        elsif rising_edge(clk) then
            r_araddr <= C_STATUS_ADDR;
            r_arprot <= "000";

            -- read channel driven from CURRENT state
            if r_fsm_cs = RD_SEND_ARADDR then
                r_arvalid <= '1';
            else
                r_arvalid <= '0';
            end if;

            if r_fsm_cs = RD_WAIT_RRESP then
                r_rready <= '1';
            else
                r_rready <= '0';
            end if;

            -- write channel inactive
            r_awaddr  <= (others => '0');
            r_awprot  <= "000";
            r_awvalid <= '0';
            r_wdata   <= (others => '0');
            r_wstrb   <= (others => '0');
            r_wvalid  <= '0';
            r_bready  <= '0';

            -- latch last valid status
            if rvalid = '1' and rresp = "00" then
                r_cal_done_rst_n <= rdata(0);
            end if;
        end if;
    end process;

    p_wait_counter : process(clk, rst_n)
    begin
        if rst_n = '0' then
            r_read_wait_ctr <= C_INIT_WAIT;
        elsif rising_edge(clk) then
            if r_fsm_cs = RD_INIT_DELAY then
                r_read_wait_ctr <= r_read_wait_ctr - 1;
            else
                r_read_wait_ctr <= C_INIT_WAIT;
            end if;
        end if;
    end process;

    p_next_state : process(r_fsm_cs, r_read_wait_ctr, arready, rvalid, rresp, rdata)
    begin
        c_fsm_ns <= RD_IDLE;

        case r_fsm_cs is
            when WAIT_NOC_INIT =>
                c_fsm_ns <= RD_IDLE;

            when RD_IDLE =>
                c_fsm_ns <= RD_INIT_DELAY;

            when RD_INIT_DELAY =>
                if r_read_wait_ctr(3) = '1' then
                    c_fsm_ns <= RD_SEND_ARADDR;
                else
                    c_fsm_ns <= RD_INIT_DELAY;
                end if;

            when RD_SEND_ARADDR =>
                if arready = '1' then
                    c_fsm_ns <= RD_WAIT_RRESP;
                else
                    c_fsm_ns <= RD_SEND_ARADDR;
                end if;

            when RD_WAIT_RRESP =>
                if rvalid = '1' then
                    if rresp = "00" then
                        -- terminate only on SUCCESS
                        if rdata(0) = '1' then
                            c_fsm_ns <= RD_TERMINATE;
                        else
                            c_fsm_ns <= RD_IDLE;  -- retry on BUSY or FAIL
                        end if;
                    else
                        c_fsm_ns <= RD_IDLE;      -- retry on AXI read error
                    end if;
                else
                    c_fsm_ns <= RD_WAIT_RRESP;
                end if;

            when RD_TERMINATE =>
                c_fsm_ns <= RD_TERMINATE;

            when others =>
                c_fsm_ns <= RD_IDLE;
        end case;
    end process;

    p_state_reg : process(clk, rst_n)
    begin
        if rst_n = '0' then
            r_fsm_cs <= WAIT_NOC_INIT;
        elsif rising_edge(clk) then
            r_fsm_cs <= c_fsm_ns;
        end if;
    end process;

end architecture;