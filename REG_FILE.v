module Reg_File (
input wire WrEn,
input wire RdEn,
input wire CLK,
input wire RST,
input wire [2:0] Address,
input wire [15:0] WrData,
output reg [15:0] RdData 
	);


reg [15:0] memory [7:0];

always @(posedge CLK or negedge RST) begin
	if (~RST) begin
		memory[0] <= 16'b0;
		memory[1] <= 16'b0;
		memory[2] <= 16'b0;
		memory[3] <= 16'b0;
		memory[4] <= 16'b0;
		memory[5] <= 16'b0;
		memory[6] <= 16'b0;
		memory[7] <= 16'b0;
		RdData <= 16'b0;
	end
	else begin
		if (WrEn && !RdEn) begin
			memory[Address] <= WrData;
		end else if (RdEn && !WrEn) begin
			RdData <= memory[Address];
		end
	end
end


endmodule