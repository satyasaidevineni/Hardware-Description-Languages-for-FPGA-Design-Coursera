module FSM(
	input In1,
	input RST,
	input CLK,
	output reg Out1
);

	reg [1:0] state; // state variable

	parameter A=0, B=1, C=2;
	always @(state)
	begin
		case (state)
			A: Out1 = 1'b0;
			B: Out1 = 1'b0;
			C: Out1 = 1'b1;
			default: Out1 = 1'b0;
		endcase
	end

	always @(posedge CLK or RST)
	begin
		if(~RST)
			state = A;
		else
			case(state)
				A : if(In1) state = B;
				else 	state = A;

				B : if(In1) state = B;
				else 	state = C;

				C : if(In1) state = A;
				else 	state = C;
			endcase
	end

endmodule