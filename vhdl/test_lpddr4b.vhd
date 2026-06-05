library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Port names follow the Platform Designer auto-recognition convention:
--   <interface type prefix>_<interface name>_<signal type>
--   clk        -> clock sink (single clock, name omitted)
--   reset_n    -> reset sink, active-low (single reset, name omitted)
--   axi_m_*    -> AXI4 manager interface "axi_m"
--   coe_*      -> conduit (exported signal)
entity test_lpddr4b is
    generic (
        AXI_ADDR_WIDTH     : integer                       := 30;
        AXI_DATA_WIDTH     : integer                       := 256;
        AXI_ID_WIDTH       : integer                       := 6
    );
    port (
        -- Clock sink / reset sink (active-low)
        clk     : in std_logic;
        reset_n : in std_logic;

        -- AXI4 write address channel
        axi_m_awaddr  : out std_logic_vector(AXI_ADDR_WIDTH-1 downto 0);     -- Start burst address
        axi_m_awburst : out std_logic_vector(1 downto 0);                    -- Burst type
        axi_m_awcache : out std_logic_vector(3 downto 0);
        axi_m_awid    : out std_logic_vector(AXI_ID_WIDTH-1 downto 0);       -- Transaction ID
        axi_m_awlen   : out std_logic_vector(7 downto 0);                    -- Number of writes
        axi_m_awlock  : out std_logic;                                       -- Atomic Access, 0 - Normal Access, 1 - Exclusive Access
        axi_m_awqos   : out std_logic_vector(3 downto 0);                    -- User defined QOS
        axi_m_awsize  : out std_logic_vector(2 downto 0);                    -- Size of single write (log2 - number of bytes)
        axi_m_awvalid : out std_logic;                                       -- Address write valid from master
        axi_m_awuser  : out std_logic_vector(13 downto 0);                   -- User defined value
        axi_m_awprot  : out std_logic_vector(2 downto 0);                    -- Access Protections
        axi_m_awready : in  std_logic;                                       -- Ready to accept write address from slave

        -- AXI4 read address channel
        axi_m_araddr  : out std_logic_vector(AXI_ADDR_WIDTH-1 downto 0);     -- Read address, base address for burst
        axi_m_arburst : out std_logic_vector(1 downto 0);                    -- Burst type
        axi_m_arcache : out std_logic_vector(3 downto 0);
        axi_m_arid    : out std_logic_vector(AXI_ID_WIDTH-1 downto 0);       -- Transaction ID
        axi_m_arlen   : out std_logic_vector(7 downto 0);                    -- Number of reads
        axi_m_arlock  : out std_logic;                                       -- Atomic Access
        axi_m_arqos   : out std_logic_vector(3 downto 0);                    -- User defined QOS
        axi_m_arsize  : out std_logic_vector(2 downto 0);                    -- Size of single read (log2 - number of bytes)
        axi_m_arvalid : out std_logic;                                       -- Address read valid from master
        axi_m_aruser  : out std_logic_vector(13 downto 0);                   -- User defined value
        axi_m_arprot  : out std_logic_vector(2 downto 0);                    -- Access Protections
        axi_m_arready : in  std_logic;                                       -- Ready to accept read address from slave

        -- AXI4 write data channel
        axi_m_wdata   : out std_logic_vector(AXI_DATA_WIDTH-1 downto 0);     -- The write Data
        axi_m_wstrb   : out std_logic_vector((AXI_DATA_WIDTH/8)-1 downto 0); -- Identifies which bytes of the data are valid, one bit for each byte
        axi_m_wlast   : out std_logic;                                       -- Last word of the burst
        axi_m_wvalid  : out std_logic;                                       -- Write data valid from master
        axi_m_wready  : in  std_logic;                                       -- Slave ready to accept data

        -- AXI4 write response channel
        axi_m_bready  : out std_logic;                                       -- Master ready to accept data
        axi_m_bid     : in  std_logic_vector(AXI_ID_WIDTH-1 downto 0);       -- Transaction ID
        axi_m_bresp   : in  std_logic_vector(1 downto 0);                    -- Response info from Slave
        axi_m_bvalid  : in  std_logic;                                       -- Write response is valid, from slave

        -- AXI4 read data channel
        axi_m_rready  : out std_logic;                                       -- Master is ready to accept read data
        axi_m_rdata   : in  std_logic_vector(AXI_DATA_WIDTH-1 downto 0);     -- Read data from slave
        axi_m_rid     : in  std_logic_vector(AXI_ID_WIDTH-1 downto 0);       -- Transaction ID
        axi_m_rlast   : in  std_logic;                                       -- Last word of the burst
        axi_m_rresp   : in  std_logic_vector(1 downto 0);                    -- Response info from Slave
        axi_m_rvalid  : in  std_logic;                                       -- Read data from slave is valid

        -- Conduit (exported) - output signal on LED
        coe_test_complete : out std_logic
    );
end entity;

architecture rtl of test_lpddr4b is

    constant AXI_START_ADDR : std_logic_vector(AXI_ADDR_WIDTH-1 downto 0) := (others => '0');

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

    constant BURST_BEATS    : natural                       := 8;
    constant LAST_INDEX     : natural                       := BURST_BEATS - 1;
    constant AXI_BEAT_SIZE  : std_logic_vector(2 downto 0)  := std_logic_vector(to_unsigned(clog2(AXI_DATA_WIDTH/8), 3));

    subtype word_t is std_logic_vector(AXI_DATA_WIDTH-1 downto 0);
    type word_array_t is array (0 to LAST_INDEX) of word_t;
    constant TEST_DATA     : word_array_t := (
        0 => x"0000000100000002000000030000000400000005000000060000000700000008",
        1 => x"1111111122222222333333334444444455555555666666667777777788888888",
        2 => x"89ABCDEF01234567FEDCBA987654321000112233445566778899AABBCCDDEEFF",
        3 => x"13579BDF2468ACE013579BDF2468ACE013579BDF2468ACE013579BDF2468ACE0",
        4 => x"AAAAAAAA55555555AAAAAAAA55555555AAAAAAAA55555555AAAAAAAA55555555",
        5 => x"DEADBEEFCAFEBABE123456789ABCDEF00F1E2D3C4B5A69788796A5B4C3D2E1F0",
        6 => x"000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F",
        7 => x"FF00FF0000FF00FFAA55AA550055AA55F0F00F0F0FF0F0F05A5AA5A53C3CC3C3"
    );

    type write_state_t is (WRITE_IDLE, WRITE_ADDR, WRITE_DATA, WRITE_RESP, WRITE_FINISH);
    type read_state_t  is (READ_IDLE, READ_ADDR, READ_DATA, READ_FINISH);

    signal write_state : write_state_t := WRITE_IDLE;
    signal read_state  : read_state_t  := READ_IDLE;

    signal write_index : natural range 0 to LAST_INDEX := 0;
    signal read_index  : natural range 0 to LAST_INDEX := 0;

    -- AXI4 signals registers
    signal r_awaddr  : std_logic_vector(AXI_ADDR_WIDTH-1 downto 0) := (others => '0');
    signal r_awvalid : std_logic                                   := '0';
    signal r_araddr  : std_logic_vector(AXI_ADDR_WIDTH-1 downto 0) := (others => '0');
    signal r_arvalid : std_logic                                   := '0';
    signal r_wvalid  : std_logic                                   := '0';
    signal r_bready  : std_logic                                   := '1';
    signal r_rready  : std_logic                                   := '0';

    -- Test stages signals
    signal write_done    : std_logic := '0';
    signal compare_error : std_logic := '0';

    -- Test output signal register
    signal r_test_complete    : std_logic;

begin

-- Constants
    axi_m_awburst <= "01";            -- INCR
    axi_m_awid    <= (others => '0');
    axi_m_awlen   <= std_logic_vector(to_unsigned(BURST_BEATS - 1, 8));
    axi_m_awlock  <= '0';
    axi_m_awqos   <= (others => '0');
    axi_m_awsize  <= AXI_BEAT_SIZE;
    axi_m_awuser  <= (others => '0');
    axi_m_awprot  <= (others => '0');
    axi_m_arburst <= "01";            -- INCR
    axi_m_arid    <= (others => '0');
    axi_m_arlen   <= std_logic_vector(to_unsigned(BURST_BEATS - 1, 8));
    axi_m_arlock  <= '0';
    axi_m_arqos   <= (others => '0');
    axi_m_arsize  <= AXI_BEAT_SIZE;
    axi_m_aruser  <= (others => '0');
    axi_m_arprot  <= (others => '0');
    axi_m_wstrb   <= (others => '1');
    axi_m_awcache <= "0011";  -- normal non-cacheable bufferable/modifiable
    axi_m_arcache <= "0011";

--  Registered outputs
    axi_m_awaddr      <= r_awaddr;
    axi_m_awvalid     <= r_awvalid;
    axi_m_araddr      <= r_araddr;
    axi_m_arvalid     <= r_arvalid;
    axi_m_wvalid      <= r_wvalid;
    axi_m_bready      <= r_bready;
    axi_m_rready      <= r_rready;
    coe_test_complete <= r_test_complete;

    axi_m_wdata   <= TEST_DATA(write_index);
    axi_m_wlast   <= '1' when (write_state = WRITE_DATA and write_index = LAST_INDEX) else '0';

    lpddr4_write_fsm : process(clk, reset_n)
    begin
        if reset_n = '0' then
            write_state <= WRITE_IDLE;
            r_awvalid   <= '0';
            r_awaddr    <= AXI_START_ADDR;
            r_wvalid    <= '0';
            r_bready    <= '1';
            write_index <= 0;
            write_done  <= '0';

        elsif rising_edge(clk) then
            case write_state is
                when WRITE_IDLE =>
                    r_awaddr    <= AXI_START_ADDR;
                    r_awvalid   <= '1';
                    r_wvalid    <= '0';
                    write_done  <= '0';
                    write_state <= WRITE_ADDR;

                when WRITE_ADDR =>
                    if axi_m_awready = '1' then
                        r_awvalid   <= '0';
                        r_wvalid    <= '1';
                        write_index <= 0;
                        write_state <= WRITE_DATA;
                    end if;

                when WRITE_DATA =>
                    if axi_m_wready = '1' then
                        if write_index = LAST_INDEX then
                            r_wvalid    <= '0';
                            write_state <= WRITE_RESP;
                        else
                            write_index <= write_index + 1;
                        end if;
                    end if;

                when WRITE_RESP =>
                    if axi_m_bvalid = '1' then
                        if axi_m_bresp = "00" or axi_m_bresp = "01" then
                            write_done          <= '1';
                            write_state <= WRITE_FINISH;
                        else
                            write_done          <= '0';
                            write_state <= WRITE_FINISH;
                        end if;
                    end if;

                when WRITE_FINISH =>
                    null;

                when OTHERS =>
                    write_state <= WRITE_IDLE;

            end case;
        end if;
    end process;

    lpddr4_read_fsm : process(clk, reset_n)
        variable beat_ok : std_logic;
    begin
        if reset_n = '0' then
            read_state      <= READ_IDLE;
            r_arvalid       <= '0';
            r_araddr        <= AXI_START_ADDR;
            r_rready        <= '0';
            read_index      <= 0;
            compare_error   <= '0';
            r_test_complete <= '0';

        elsif rising_edge(clk) then
            beat_ok := '0';

            case read_state is
                when READ_IDLE =>
                    r_arvalid       <= '0';
                    r_rready        <= '0';
                    compare_error   <= '0';
                    r_test_complete <= '0';

                    if write_done = '1' then
                        r_araddr   <= AXI_START_ADDR;
                        r_arvalid  <= '1';
                        read_state <= READ_ADDR;
                    end if;

                when READ_ADDR =>
                    if axi_m_arready = '1' then
                        r_arvalid  <= '0';
                        r_rready   <= '1';
                        read_index <= 0;
                        read_state <= READ_DATA;
                    end if;

                when READ_DATA =>
                    if axi_m_rvalid = '1' then
                        beat_ok := '1';

                        if axi_m_rdata /= TEST_DATA(read_index) then
                            beat_ok := '0';
                        end if;

                        if axi_m_rresp /= "00" then
                            beat_ok := '0';
                        end if;

                        if read_index = LAST_INDEX then
                            if axi_m_rlast /= '1' then
                                beat_ok := '0';
                            end if;
                        else
                            if axi_m_rlast = '1' then
                                beat_ok := '0';
                            end if;
                        end if;

                        if beat_ok = '0' then
                            compare_error <= '1';
                        end if;

                        if read_index = LAST_INDEX then
                            r_rready   <= '0';
                            read_state <= READ_FINISH;

                            if compare_error = '0' and beat_ok = '1' then
                                r_test_complete <= '1';
                            else
                                r_test_complete <= '0';
                            end if;
                        else
                            read_index <= read_index + 1;
                        end if;
                    end if;

                when READ_FINISH =>
                    null;

                when OTHERS =>
                    read_state <= READ_IDLE;

            end case;
        end if;
    end process;

end architecture;