library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debouncer is
    generic (
        DEBOUNCE_TIME : integer := 1000000
    );
    port (
        clk        : in  std_logic;
        resetn     : in  std_logic;
        button_in  : in  std_logic;
        button_out : out std_logic
    );

    attribute altera_interface 			  : string;
    attribute altera_interface of clk    : signal is "altera.com:interfaces:altera_clock:1.0 in clk clk";
    attribute altera_interface of resetn : signal is "altera.com:interfaces:altera_reset:1.0 in resetn reset_n";

end entity debouncer;

architecture rtl of debouncer is

    signal counter       : unsigned(31 downto 0) := (others => '0');
    signal button_sync_0 : std_logic := '0';
    signal button_sync_1 : std_logic := '0';
    signal button_out_r  : std_logic := '0';

begin

    button_out <= button_out_r;

    process(clk, resetn)
    begin
        if resetn = '0' then
            button_sync_0 <= '0';
            button_sync_1 <= '0';
        elsif rising_edge(clk) then
            button_sync_0 <= button_in;
            button_sync_1 <= button_sync_0;
        end if;
    end process;

    process(clk, resetn)
    begin
        if resetn = '0' then
            counter      <= (others => '0');
            button_out_r <= '0';
        elsif rising_edge(clk) then
            if button_sync_1 = button_out_r then
                counter <= (others => '0');
            else
                counter <= counter + 1;
                if counter >= to_unsigned(DEBOUNCE_TIME, counter'length) then
                    button_out_r <= button_sync_1;
                    counter      <= (others => '0');
                end if;
            end if;
        end if;
    end process;

end architecture rtl;