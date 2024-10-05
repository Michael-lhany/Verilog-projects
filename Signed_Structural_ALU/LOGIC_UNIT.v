module LOGIC_UNIT #(parameter Logic_In_WIDTH = 16, Logic_Out_WIDTH = 16) (

input wire signed [Logic_In_WIDTH-1 : 0] A,
input wire signed [Logic_In_WIDTH-1 : 0] B,
input wire [1:0] ALU_FUN,
input wire CLK,
input wire RST,
input wire Logic_Enable,
output reg [Logic_Out_WIDTH-1 : 0] Logic_OUT,
output reg Logic_Flag
	);


always @(posedge CLK or negedge RST) begin
if (Logic_Enable) begin
	if (!RST) begin
		Logic_OUT <= 0;
		Logic_Flag <= 0;
	end
	else begin
		case (ALU_FUN)
			2'b00:begin
				Logic_OUT <= A&B;
				Logic_Flag <= 1;			
			end
			2'b01:begin
				Logic_OUT <= A|B;
				Logic_Flag <= 1;			
			end
			2'b10:begin
				Logic_OUT <= ~(A&B);
				Logic_Flag <= 1;			
			end
			2'b11:begin
				Logic_OUT <= ~(A|B);
				Logic_Flag <= 1;			
			end
		endcase
	end
end 
else begin
	Logic_OUT <= 0;
	Logic_Flag <= 0;
end
end




endmodule