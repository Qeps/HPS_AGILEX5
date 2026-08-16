library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_axi4 is
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
        awaddr  : out std_logic_vector(AXI_ADDR_WIDTH-1 downto 0);     -- Start burst address
        awburst : out std_logic_vector(1 downto 0);                    -- Burst type
        awcache : out std_logic_vector(3 downto 0);
        awid    : out std_logic_vector(AXI_ID_WIDTH-1 downto 0);       -- Transaction ID
        awlen   : out std_logic_vector(7 downto 0);                    -- Number of writes
        awlock  : out std_logic;                                       -- Atomic Access, 0 - Normal Access, 1 - Exclusive Access
        awqos   : out std_logic_vector(3 downto 0);                    -- User defined QOS
        awsize  : out std_logic_vector(2 downto 0);                    -- Size of single write (log2 - number of bytes)
        awvalid : out std_logic;                                       -- Address write valid from master
        awuser  : out std_logic_vector(13 downto 0);                   -- User defined value
        awprot  : out std_logic_vector(2 downto 0);                    -- Access Protections
        awready : in  std_logic;                                       -- Ready to accept write address from slave

        -- AXI4 read address channel
        araddr  : out std_logic_vector(AXI_ADDR_WIDTH-1 downto 0);     -- Read address, base address for burst
        arburst : out std_logic_vector(1 downto 0);                    -- Burst type
        arcache : out std_logic_vector(3 downto 0);
        arid    : out std_logic_vector(AXI_ID_WIDTH-1 downto 0);       -- Transaction ID
        arlen   : out std_logic_vector(7 downto 0);                    -- Number of reads
        arlock  : out std_logic;                                       -- Atomic Access
        arqos   : out std_logic_vector(3 downto 0);                    -- User defined QOS
        arsize  : out std_logic_vector(2 downto 0);                    -- Size of single read (log2 - number of bytes)
        arvalid : out std_logic;                                       -- Address read valid from master
        aruser  : out std_logic_vector(13 downto 0);                   -- User defined value
        arprot  : out std_logic_vector(2 downto 0);                    -- Access Protections
        arready : in  std_logic;                                       -- Ready to accept read address from slave

        -- AXI4 write data channel
        wdata   : out std_logic_vector(AXI_DATA_WIDTH-1 downto 0);     -- The write Data
        wstrb   : out std_logic_vector((AXI_DATA_WIDTH/8)-1 downto 0); -- Identifies which bytes of the data are valid, one bit for each byte
        wlast   : out std_logic;                                       -- Last word of the burst
        wvalid  : out std_logic;                                       -- Write data valid from master
        wready  : in  std_logic;                                       -- Slave ready to accept data

        -- AXI4 write response channel
        bready  : out std_logic;                                       -- Master ready to accept data
        bid     : in  std_logic_vector(AXI_ID_WIDTH-1 downto 0);       -- Transaction ID
        bresp   : in  std_logic_vector(1 downto 0);                    -- Response info from Slave
        bvalid  : in  std_logic;                                       -- Write response is valid, from slave

        -- AXI4 read data channel
        rready  : out std_logic;                                       -- Master is ready to accept read data
        rdata   : in  std_logic_vector(AXI_DATA_WIDTH-1 downto 0);     -- Read data from slave
        rid     : in  std_logic_vector(AXI_ID_WIDTH-1 downto 0);       -- Transaction ID
        rlast   : in  std_logic;                                       -- Last word of the burst
        rresp   : in  std_logic_vector(1 downto 0);                    -- Response info from Slave
        rvalid  : in  std_logic;                                       -- Read data from slave is valid

        -- Conduit (exported) - output signal on LED
        test_complete : out std_logic
    );
end entity;

architecture rtl of test_axi4 is

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
    awburst <= "01";            -- INCR
    awid    <= (others => '0');
    awlen   <= std_logic_vector(to_unsigned(BURST_BEATS - 1, 8));
    awlock  <= '0';
    awqos   <= (others => '0');
    awsize  <= AXI_BEAT_SIZE;
    awuser  <= (others => '0');
    awprot  <= (others => '0');
    arburst <= "01";            -- INCR
    arid    <= (others => '0');
    arlen   <= std_logic_vector(to_unsigned(BURST_BEATS - 1, 8));
    arlock  <= '0';
    arqos   <= (others => '0');
    arsize  <= AXI_BEAT_SIZE;
    aruser  <= (others => '0');
    arprot  <= (others => '0');
    wstrb   <= (others => '1');
    awcache <= "0011";  -- normal non-cacheable bufferable/modifiable
    arcache <= "0011";

--  Registered outputs
    awaddr      <= r_awaddr;
    awvalid     <= r_awvalid;
    araddr      <= r_araddr;
    arvalid     <= r_arvalid;
    wvalid      <= r_wvalid;
    bready      <= r_bready;
    rready      <= r_rready;
    test_complete <= r_test_complete;

    wdata   <= TEST_DATA(write_index);
    wlast   <= '1' when (write_state = WRITE_DATA and write_index = LAST_INDEX) else '0';

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
                    if awready = '1' then
                        r_awvalid   <= '0';
                        r_wvalid    <= '1';
                        write_index <= 0;
                        write_state <= WRITE_DATA;
                    end if;

                when WRITE_DATA =>
                    if wready = '1' then
                        if write_index = LAST_INDEX then
                            r_wvalid    <= '0';
                            write_state <= WRITE_RESP;
                        else
                            write_index <= write_index + 1;
                        end if;
                    end if;

                when WRITE_RESP =>
                    if bvalid = '1' then
                        if bresp = "00" or bresp = "01" then
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
                    if arready = '1' then
                        r_arvalid  <= '0';
                        r_rready   <= '1';
                        read_index <= 0;
                        read_state <= READ_DATA;
                    end if;

                when READ_DATA =>
                    if rvalid = '1' then
                        beat_ok := '1';

                        if rdata /= TEST_DATA(read_index) then
                            beat_ok := '0';
                        end if;

                        if rresp /= "00" then
                            beat_ok := '0';
                        end if;

                        if read_index = LAST_INDEX then
                            if rlast /= '1' then
                                beat_ok := '0';
                            end if;
                        else
                            if rlast = '1' then
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