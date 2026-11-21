module FA (input logic a, b, c_in, output logic s, c_out);
	assign s = a^b^c_in;
	assign c_out = (a&b) | (c_in&a) | (c_in&b);
endmodule

module part1(input logic [3:0]a,b, input logic c_in, output logic [3:0]s, output logic c_out);
	logic c1, c2, c3;
	FA u0(a[0], b[0], c_in, s[0], c1);
	FA u1(a[1], b[1], c1, s[1], c2);
	FA u2(a[2], b[2], c2, s[2], c3);
	FA u3(a[3], b[3], c3, s[3], c_out);
endmodule

module part2(input logic [3:0]A, B, input logic [1:0]Function, output logic[7:0]ALUout);
	logic c_out;
	logic [3:0]s;
	part1 adder(A, B, 1'b0, s, c_out);
	
	always_comb
	begin
		case(Function)
			2'b00: ALUout = {3'b000, c_out, s};
			2'b01: 
				if (|{A, B})
					ALUout = 8'b00000001;
				else
					ALUout = 8'b00000000;
			2'b10:
				if (&{A, B})
					ALUout = 8'b00000001;
				else
					ALUout = 8'b00000000;
			2'b11: ALUout = {A, B};
			default: ALUout = 8'b00000000;
		endcase
	end
endmodule