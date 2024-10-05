module SHIFT_UNIT #(parameter Shift_In_WIDTH = 16, Shift_Out_WIDTH = 17)(

input wire signed [Shift_In_WIDTH-1:0] A,
input wire signed [Shift_In_WIDTH-1:0] B,
input wire [1:0] ALU_FUN,
input wire CLK,
input wire RST,
input wire Shift_Enable,
output reg [Shift_Out_WIDTH-1:0] Shift_OUT,
output reg Shift_Flag
 	);


always @(posedge CLK or negedge RST) begin
if (Shift_Enable) begin
	if (!RST) begin
		Shift_OUT <= 0;
		Shift_Flag <= 0;
	end
	else begin
		case (ALU_FUN)
			2'b00:begin
				Shift_OUT <= A >> 1;
				Shift_Flag <= 1;			
			end
			2'b01:begin
				Shift_OUT <= A << 1;
				Shift_Flag <= 1;			
			end
			2'b10:begin
				Shift_OUT <= B >> 1;
				Shift_Flag <= 1;			
			end
			2'b11:begin
				Shift_OUT <= B << 1;
				Shift_Flag <= 1;			
			end
		endcase
	end
end 
else begin
	Shift_OUT <= 0;
	Shift_Flag <= 0;
end
end


endmodule