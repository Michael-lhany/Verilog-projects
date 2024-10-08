`timescale 1ns/100ps

module CLK_DIV_tb();


///		Parameters		///
localparam CLK_PERIOD = 10;


///		DUT signals		///
reg			I_ref_clk_tb;
reg			I_rst_n_tb;
reg			I_clk_en_tb;
reg	 [7:0] 	I_div_ratio_tb;
wire		O_div_clk_tb;


////		DUT instantiation		////
CLK_DIV clock_divider(
.I_ref_clk(I_ref_clk_tb),
.I_rst_n(I_rst_n_tb),
.I_clk_en(I_clk_en_tb),
.I_div_ratio(I_div_ratio_tb),
.O_div_clk(O_div_clk_tb)
);


///		Clock Generator		///
always #(CLK_PERIOD/2.0) I_ref_clk_tb = ~I_ref_clk_tb;


///		Initial block		///
initial
begin
	$dumpfile("LFSR_DUMP.vcd") ;       
	$dumpvars;

	init();
	reset();


	I_clk_en_tb = 'b0;
	#(CLK_PERIOD)
	I_clk_en_tb = 'b0;
	I_div_ratio_tb = 'h1;
	#(20*CLK_PERIOD)
	I_clk_en_tb = 'b1;
	I_div_ratio_tb = 'h2;
	#(20*CLK_PERIOD)
	I_div_ratio_tb = 'h3;
	#(20*CLK_PERIOD) 
	I_div_ratio_tb = 'h4;
	#(20*CLK_PERIOD)  
	I_div_ratio_tb = 'h5;
	#(20*CLK_PERIOD) 
	I_div_ratio_tb = 'h6;
	#(20*CLK_PERIOD) 
	$stop;
end


///		Tasks		///

//Initialize
task init;	
 begin
 	I_ref_clk_tb = 'b0;
 	I_div_ratio_tb = 'b0;
 	I_clk_en_tb = 'b0;
 	I_rst_n_tb = 'b0;
 end
endtask

//Reset
task reset;
 begin
	I_rst_n_tb = 'b1;
	#(CLK_PERIOD)
	I_rst_n_tb = 'b0;
	#(CLK_PERIOD)
	I_rst_n_tb = 'b1;
 end
endtask

endmodule