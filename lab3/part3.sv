module ALU(input logic [3:0]A, B, input logic [2:0]Function, output logic[7:0]ALUout);
	logic [4:0]s;
	logic [7:0]p;
	assign s = A + B;
	assign p = A * B;
	always_comb
	begin
		case(Function)
			3'b000: ALUout = {3'b000, s};
			3'b001: ALUout = p;
			3'b010: ALUout = B << A;
			3'b011: ALUout = ALUout;
			default: ALUout = 8'b00000000;
		endcase
	end
endmodule

module register(input logic clk, reset_b, input logic [7:0]d, output logic [7:0]q);
	always_ff @(posedge clk)
	begin
		if (reset_b)
			q <= 8'b00000000;
		else
			q <= d;
	end
endmodule

module part3(input logic Clock, Reset_b, input logic [3:0] Data, input logic [2:0]Function, output logic [7:0] ALU_reg_out);
	logic [7:0]ALUout;
	ALU u0(Data, ALU_reg_out[3:0], Function, ALUout);
	register u1(Clock, Reset_b, ALUout, ALU_reg_out);
endmodule