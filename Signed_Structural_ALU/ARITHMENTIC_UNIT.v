module ARITHMETIC_UNIT #(parameter Arith_In_WIDTH = 16, Arith_Out_WIDTH = 32)(

input wire signed [Arith_In_WIDTH-1 : 0] A,
input wire signed [Arith_In_WIDTH-1 : 0] B,
input wire [1:0] ALU_FUN,
input wire CLK,
input wire RST,
input wire Arith_Enable,
output reg signed [Arith_Out_WIDTH-1 : 0] Arith_OUT,
output reg Arith_Flag
 	);


always @(posedge CLK or negedge RST) begin
if (Arith_Enable) begin
	if (!RST) begin
		Arith_OUT <= 32'b0;
		Arith_Flag <= 0;
	end
	else begin
		case (ALU_FUN)
			2'b00:begin
				Arith_OUT <= A+B;
				Arith_Flag <= 1;			
			end
			2'b01:begin
				Arith_OUT <= A-B;
				Arith_Flag <= 1;			
			end
			2'b10:begin
				Arith_OUT <= A*B;
				Arith_Flag <= 1;			
			end
			2'b11:begin
				Arith_OUT <= A/B;
				Arith_Flag <= 1;			
			end
		endcase
	end
end 
else begin
	Arith_OUT <= 32'b0;
	Arith_Flag <= 0;
end
end


endmodule