module Automatic_Garage_Door_Controller (
input wire CLK,
input wire RST,
input wire UP_Max,
input wire DN_Max,
input wire Activate,
output reg UP_M,
output reg DN_M
);


localparam  [1:0]    IDLE = 2'b00,
                     S1 = 2'b01,
                     S2 = 2'b11;

reg    [1:0]         current_state,
                     next_state ;

always @(posedge CLK or negedge RST) begin
	if (~RST) begin
		current_state <= IDLE;
	end
	else begin
		current_state <= next_state;
	end
end



always @(*) begin
	case(current_state)
	IDLE : begin
		if(Activate) begin
			if (UP_Max) begin
				next_state <= S2;
			end else begin
				next_state <= S1;
			end
		end else begin
			next_state <= IDLE;
		end
	end
	S1 : begin
		if (UP_Max) begin
			next_state <= IDLE;
		end else begin
			next_state <= S1;
		end
	end
	S2 : begin
		if (DN_Max) begin
			next_state <= IDLE;
		end else begin
			next_state <= S2;
		end
	end
	default : begin
		next_state <= IDLE;
	end
	endcase
end


always @(*) begin
	case(current_state)
	IDLE  : begin
		UP_M = 1'b0;
		DN_M = 1'b0;
	end
	S1 : begin
		UP_M = 1'b1;
		DN_M = 1'b0;
	end
	S2 : begin
		UP_M = 1'b0;
		DN_M = 1'b1;
	end
	endcase
end
endmodule