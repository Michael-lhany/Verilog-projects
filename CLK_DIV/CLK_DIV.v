module CLK_DIV (
input wire I_ref_clk,
input wire I_rst_n,
input wire I_clk_en,
input wire [7:0] I_div_ratio,
output wire O_div_clk
);

reg [6:0] counter;
reg odd_flag; 
reg O_div_clk_2;

assign O_div_clk = (I_clk_en && ( I_div_ratio != 0) && ( I_div_ratio != 1))? O_div_clk_2 : I_ref_clk ;

always @(posedge I_ref_clk or negedge I_rst_n) begin
	if (~I_rst_n) begin
		O_div_clk_2 <= 1'b0;
		odd_flag <= 1'b0;		
		counter <= 0;
	end
	else begin
		if (I_clk_en && ( I_div_ratio != 0) && ( I_div_ratio != 1)) begin
			if ((I_div_ratio[0] == 0) && (counter == (I_div_ratio >> 1)-1)) begin
				O_div_clk_2 <= ~O_div_clk_2;
				counter <= 1'b0;
			end else if ((I_div_ratio[0] == 1) && (counter == (I_div_ratio >> 1)) && (odd_flag == 0)) begin
				O_div_clk_2 <= 1'b1;
				odd_flag <= 1'b1;
				counter <= 1'b0;
			end else if ((I_div_ratio[0] == 1) && (counter == (I_div_ratio >> 1)-1) && (odd_flag == 1)) begin
				O_div_clk_2 <= 1'b0;
				odd_flag <= 1'b0;
				counter <= 1'b0;
			end else begin
				counter <= counter + 1;
			end
		end
	end
end
endmodule