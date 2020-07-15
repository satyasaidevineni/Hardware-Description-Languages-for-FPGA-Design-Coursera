module FIFO8x9(
	input clk, rst,
	input RdPtrClr, WrPtrClr,
	input RdInc, WrInc,
	input [8:0] DataIn,
	input rden, wren,
	output reg [8:0] DataOut
);
	//signal declarations

	reg [8:0] fifo_array[7:0];
	reg [7:0] wrptr, rdptr;
	//	wire [7:0] wr_cnt, rd_cnt;


	always @(posedge clk)
	begin
		if(~rst)
			rdptr <= 8'd0;
		else if(RdPtrClr)
			rdptr <= 8'd0;
		else if (RdInc)
			rdptr <= rdptr + 8'd1;
		else
			rdptr <= rdptr;
	end

	always @(posedge clk)
	begin
		if(~rst)
			wrptr <= 8'd0;
		else if (WrInc)
			wrptr <= 8'd0;
		else if (wren)
			wrptr <= wrptr + 8'd1;
		else
			wrptr <= wrptr;
	end

	always@(posedge clk)
	begin
		if(rden)
			DataOut <= fifo_array[rdptr];
		else
			DataOut <= 9'bz;
	end

	always@(posedge clk)
	begin
		if(wren)
			fifo_array[wrptr] <= DataIn;
		else
			fifo_array[wrptr] <= fifo_array[wrptr];
	end

endmodule