`timescale 1us/100ns

module ALU_16B_tb ();

reg [15:0] A_tb,B_tb;
reg CLK_tb;
reg [3:0] ALU_FUN_tb ;
wire [15:0] ALU_OUT_tb ;
wire Carry_Flag_tb, Arith_flag_tb, Logic_flag_tb, CMP_flag_tb, Shift_flag_tb;


ALU_16B DUT(
.A(A_tb),
.B(B_tb),
.CLK(CLK_tb),
.ALU_FUN(ALU_FUN_tb),
.ALU_OUT(ALU_OUT_tb),
.Carry_Flag(Carry_Flag_tb),
.Arith_flag(Arith_flag_tb),
.Logic_flag(Logic_flag_tb),
.CMP_flag(CMP_flag_tb),
.Shift_flag(Shift_flag_tb)
);


always #5 CLK_tb = ~CLK_tb ;


initial
begin
	$dumpfile("count.vcd");
	$dumpvars;
	CLK_tb = 0;
	A_tb = 16'b0001;
	B_tb = 16'b0001;
	

	ALU_FUN_tb = 4'b1111;
	$display("Test case 1");  //Testing when the alu is not working
	#10
	if (ALU_OUT_tb == 0) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end


	ALU_FUN_tb = 4'b0000;
	$display("Test case 2");  //Testing the addition function
	#10
	if (ALU_OUT_tb == 16'b0010 && Arith_flag_tb==1 && Carry_Flag_tb==0) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end
	

	ALU_FUN_tb = 4'b0001;
	$display("Test case 3");   //Testing the subtraction function
	#10
	if (ALU_OUT_tb == 16'b0000 && Arith_flag_tb==1 && Carry_Flag_tb==0) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end
	

	ALU_FUN_tb = 4'b0010;
	$display("Test case 4");   //Testing the multiplication function
	#10
	if (ALU_OUT_tb == 16'b0001 && Arith_flag_tb==1) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end


	ALU_FUN_tb = 4'b0011;
	A_tb = 16'b0010;
	B_tb = 16'b0010;
	$display("Test case 5");   //Testing the division function
	#10
	if (ALU_OUT_tb == 16'b0001 && Arith_flag_tb==1) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end


	ALU_FUN_tb = 4'b0100;
	$display("Test case 6");   //Testing the and function
	#10
	if (ALU_OUT_tb == 16'b0010 && Logic_flag_tb==1) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end


	ALU_FUN_tb = 4'b0101;
	$display("Test case 7");   //Testing the or function
	#10
	if (ALU_OUT_tb == 16'b0010 && Logic_flag_tb==1) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end


	ALU_FUN_tb = 4'b0110;
	$display("Test case 8");   //Testing the nand function
	#10
	if (ALU_OUT_tb == 16'hfffd && Logic_flag_tb==1) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end


	ALU_FUN_tb = 4'b0111;
	$display("Test case 9");   //Testing the nor function
	#10
	if (ALU_OUT_tb == 16'hfffd && Logic_flag_tb==1) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end


	ALU_FUN_tb = 4'b1000;
	$display("Test case 10");   //Testing the xor function
	#10
	if (ALU_OUT_tb == 16'b0000 && Logic_flag_tb==1) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end


	ALU_FUN_tb = 4'b1001;
	$display("Test case 11");   //Testing the xnor function
	#10
	if (ALU_OUT_tb == 16'hffff && Logic_flag_tb==1) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end


	ALU_FUN_tb = 4'b1010;
	$display("Test case 12");   //Testing the equality function
	#10
	if (ALU_OUT_tb == 16'b0001 && CMP_flag_tb==1) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end


	ALU_FUN_tb = 4'b1011;
	$display("Test case 13");   //Testing the greater than function
	#10
	if (ALU_OUT_tb == 16'b0000 && CMP_flag_tb==1) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end


	ALU_FUN_tb = 4'b1100;
	$display("Test case 14");   //Testing the Less than function
	#10
	if (ALU_OUT_tb == 16'b0000 && CMP_flag_tb==1) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end


	ALU_FUN_tb = 4'b1101;
	$display("Test case 15");   //Testing the shift right function
	#10
	if (ALU_OUT_tb == 16'b0001 && Shift_flag_tb==1) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end


	ALU_FUN_tb = 4'b1110;
	$display("Test case 16");   //Testing the shift left function
	#10
	if (ALU_OUT_tb == 16'b0100 && Shift_flag_tb==1) begin
		$display("Passed");
	end	else begin
		$display("Failed");
	end
	$stop;
end

endmodule