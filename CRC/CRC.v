module CRC (
input wire Data,
input wire Active,
input wire CLK,
input wire RST,
output reg CRC,
output reg Valid
);

parameter [7:0] seed = 8'hD8;

integer N;

reg [7:0] LFSR;
wire feedback;
reg Counter_Done;
reg [3:0] counter;

assign feedback = LFSR[0] ^ Data;

always @(posedge CLK or negedge RST) begin
	if (~RST) begin
		LFSR <= seed;
		CRC  <= 1'b0;
		Valid <= 1'b0;
	end
	else if (Active) begin
		LFSR[0] <= LFSR[1] ;
		LFSR[1] <= LFSR[2] ;
		LFSR[2] <= LFSR[3] ^ feedback ;
		LFSR[3] <= LFSR[4] ;
		LFSR[4] <= LFSR[5] ;
		LFSR[5] <= LFSR[6] ;
		LFSR[6] <= LFSR[7] ^ feedback;
		LFSR[7] <= feedback ;
	end
	else if (~Counter_Done) begin
		{LFSR[6:0],CRC} <= LFSR ;
		Valid <= 1'b1;
	end
end

always @(posedge CLK or negedge RST) begin
	if (~RST) begin
		counter <= 0;
	end
	else if (Active) begin
		counter <= 0;
	end else begin
		Counter_Done <= 0;
		if (counter > 3'b111) begin
			Counter_Done <= 1;
			Valid <= 0;
		end else begin
			counter <= counter + 1;
		end
	end
end

endmodule