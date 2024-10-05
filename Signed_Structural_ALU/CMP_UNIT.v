module CMP_UNIT #(parameter CMP_In_WIDTH = 16, CMP_Out_WIDTH = 2) (

input wire signed [CMP_In_WIDTH-1:0] A,
input wire signed [CMP_In_WIDTH-1:0] B,
input wire [1:0] ALU_FUN,
input wire CLK,
input wire RST,
input wire CMP_Enable,
output reg [CMP_Out_WIDTH-1:0] CMP_OUT,
output reg CMP_Flag
	);


always @(posedge CLK or negedge RST) begin
if (CMP_Enable) begin
	if (!RST) begin
		CMP_OUT <= 0;
		CMP_Flag <= 0;
	end
	else begin
		case (ALU_FUN)
			2'b00:begin
				CMP_Flag <= 1;
				CMP_OUT <= 0;	
			end
			2'b01:begin
				CMP_Flag <= 1;
				if (A == B) begin
					CMP_OUT <= 1;					
				end	else begin
					CMP_OUT <= 0;
				end			
			end
			2'b10:begin
				CMP_Flag <= 1;	
				if (A > B) begin
					CMP_OUT <= 2;					
				end	else begin
					CMP_OUT <= 0;
				end			
			end
			2'b11:begin
				CMP_Flag <= 1;
				if (A < B) begin
					CMP_OUT <= 3;					
				end	else begin
					CMP_OUT <= 0;
				end			
			end
		endcase
	end
end 
else begin
	CMP_OUT <= 0;
	CMP_Flag <= 0;
end
end



endmodule 