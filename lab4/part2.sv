module RateDivider # (parameter CLOCK_FREQUENCY=500)(
	input logic ClockIn,
	input logic Reset,
	input logic [1:0] Speed,
	output logic Enable
);
	logic [$clog2(CLOCK_FREQUENCY*4):0] freq, Q;
	
	always_comb 
		begin
			case(Speed)
				2'b00: freq = 0;
				2'b01: freq = CLOCK_FREQUENCY-1;
				2'b10: freq = CLOCK_FREQUENCY*2-1;
				2'b11: freq = CLOCK_FREQUENCY*4-1;
			endcase
		end

	always_ff @(posedge ClockIn)
		begin 
			if (Reset)
				Q <= freq;
			else if (~(|Q))
				Q <= freq;
			else
				Q <= Q - 1;
		end
	assign Enable = (~(|Q));
endmodule
	
module FA (input logic a, b, c_in, output logic s, c_out);
	assign s = a^b^c_in;
	assign c_out = (a&b) | (c_in&a) | (c_in&b);
endmodule
	
module adder(input logic [3:0]a,b, input logic c_in, output logic [3:0]s, c_out);
	logic c1, c2, c3;
	FA u0(a[0], b[0], c_in, s[0], c_out[0]);
	FA u1(a[1], b[1], c_out[0], s[1], c_out[1]);
	FA u2(a[2], b[2], c_out[1], s[2], c_out[2]);
	FA u3(a[3], b[3], c_out[2], s[3], c_out[3]);
endmodule


module DisplayCounter(
	input logic Clock,
	input logic Reset,
	input logic EnableDC,
	output logic [3:0] CounterValue
);
	logic [3:0]cout, Q, s;
	
	always_ff @(posedge Clock)
	begin
		if (Reset)
			Q <= 4'b0;
		else if (EnableDC)
			Q <= s;
	end
	assign CounterValue = Q;
	adder u0(Q, 4'b0001, 1'b0, s, cout);
endmodule

module part2 #(parameter CLOCK_FREQUENCY=500)(
	input logic ClockIn, Reset,
	input logic [1:0] Speed,
	output logic [3:0] CounterValue
);
	logic Enable;
	RateDivider rd(ClockIn, Reset, Speed, Enable);
	DisplayCounter dc(ClockIn, Reset, Enable, CounterValue);
endmodule