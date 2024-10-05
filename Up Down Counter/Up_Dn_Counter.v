module Up_Dn_Counter
(	input wire [4:0] In,
	input wire Load, Up, Down,
	input wire CLK,
	output reg [4:0] Counter,
	output wire High, Low
	);

always @(posedge CLK) 
begin
	if (Load) begin
		Counter=In;
	end
	else if (Down && !Low) begin
		Counter<=Counter-1;
	end
	else if (Up && !High && !Down) begin
		Counter<=Counter+1;
	end
end

assign Low = (Counter==0);

assign  High = (Counter==31);

endmodule