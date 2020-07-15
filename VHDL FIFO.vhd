library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIFO8x9 is
	port(
		clk, rst           : in  std_logic;
		RdPtrClr, WrPtrClr : in  std_logic;
		RdInc, WrInc       : in  std_logic;
		DataIn             : in  std_logic_vector(8 downto 0);
		DataOut            : out std_logic_vector(8 downto 0);
		rden, wren         : in  std_logic
	);
end entity FIFO8x9;

architecture RTL of FIFO8x9 is
	--signal declarations
	type fifo_array is array (7 downto 0) of std_logic_vector(8 downto 0); -- makes use of VHDL’s enumerated type
	signal fifo         : fifo_array;
	signal wrptr, rdptr : unsigned(2 downto 0);
	--signal en: std_logic_vector(7 downto 0);
	--signal dmuxout      : std_logic_vector(8 downto 0);

begin

	DataOut <= fifo(to_integer(rdptr)) when wren = '1' else "ZZZZZZZZZ";

	process(clk, rst)
	begin
		if clk'EVENT and clk = '1' then
			if rst = '1' then
				rdptr <= "000";
			elsif RdPtrClr = '1' then
				rdptr <= "000";
			elsif RdInc = '1' then
				rdptr <= rdptr + 1;
			else
				rdptr <= rdptr;
			end if;
		end if;

	end process;

	process(clk, rst)
	begin
		if clk'EVENT and clk = '1' then
			if rst = '1' then
				wrptr <= "000";
			elsif WrPtrClr = '1' then
				wrptr <= "000";
			elsif WrInc = '1' then
				wrptr <= wrptr + 1;
			else
				wrptr <= wrptr;
			end if;
		end if;
	end process;

	process(clk)
	begin
		if clk'EVENT and clk = '1' then
			if wren = '1' then
				fifo(to_integer(wrptr)) <= DataIn;
			else
				fifo(to_integer(wrptr)) <= fifo(to_integer(wrptr));
			end if;
		end if;
	end process;

end RTL;