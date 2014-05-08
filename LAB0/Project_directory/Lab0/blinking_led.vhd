library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity blinking_led is
	port(
		clk_50mhz : in std_logic ;
		reset_btn : in std_logic;
		green_led : out std_logic
	);
end entity;

architecture behave of blinking_led is

signal clk_1hz : std_logic ;
signal scaler : integer range 0 to 25000000 ;
signal LED  : std_logic ;

begin

	clk_1hz_process : process( clk_50mhz , reset_btn )
	begin
		if (reset_btn = '0') then 
			clk_1hz <= '0';
			scaler <= 0;
		elsif(rising_edge(clk_50mhz)) then 
			if (scaler < 25000000) then 
				scaler <= scaler + 1 ;
				clk_1hz <= '0';
			else
				scaler <= 0;
				clk_1hz <= '1';
			end if;
		end if;
	end process clk_1hz_process;
	
	blinking_process : process (clk_1hz,reset_btn)
	begin
		if (reset_btn = '0') then 
			LED <= '0';
		elsif rising_edge(clk_1hz) then
			LED <= not LED ;
		end if ;
	end process blinking_process;

	green_led <= LED;
	end behave;