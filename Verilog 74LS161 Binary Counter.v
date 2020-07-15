module LS161a(
	input [3:0] D, // Parallel Input
	input CLK, // Clock
	input CLR_n, // Active Low Asynchronous Reset
	input LOAD_n, // Enable Parallel Input
	input ENP, // Count Enable Parallel
	input ENT, // Count Enable Trickle
	output reg [3:0]Q, // Parallel Output 	
	output RCO // Ripple Carry Output (Terminal Count)
);

	assign RCO = (Q[3] & Q[2] & Q[1] & Q[0]);

	always @(posedge CLK or CLR_n)
	begin
		if(CLR_n == 1'b0)
			begin
				Q <= 4'd0;
			end
		else if (LOAD_n == 1'b0)
			begin
				Q <= D;
			end
		else if ((ENP & ENT))
			begin
				Q <= Q + 4'd1;
			end
	end
endmodule