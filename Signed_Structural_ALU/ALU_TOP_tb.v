`timescale 1us/100ns

module ALU_TOP_tb ();

parameter Data_In_WIDTH = 16,
		Arith_Out_WIDTH = 32,
		Logic_Out_WIDTH = 16,
		CMP_Out_WIDTH = 2,
		Shift_Out_WIDTH = 17;

reg signed [Data_In_WIDTH-1 : 0] A_tb;
reg signed [Data_In_WIDTH-1 : 0] B_tb;
reg [3:0] ALU_FUNC_tb;
reg CLK_tb;
reg RST_tb;
wire signed [Arith_Out_WIDTH-1 : 0] Arith_OUT_tb; 
wire [Logic_Out_WIDTH-1 : 0] Logic_OUT_tb;
wire [CMP_Out_WIDTH-1 : 0] CMP_OUT_tb;
wire [Shift_Out_WIDTH-1 : 0] SHIFT_OUT_tb;
wire Arith_Flag_tb, Logic_Flag_tb, CMP_Flag_tb, SHIFT_Flag_tb;


ALU_TOP #(.Data_In_WIDTH(Data_In_WIDTH),.Arith_Out_WIDTH(Arith_Out_WIDTH),.Logic_Out_WIDTH(Logic_Out_WIDTH),
			.CMP_Out_WIDTH(CMP_Out_WIDTH),.Shift_Out_WIDTH(Shift_Out_WIDTH)) 	DUT(
.A(A_tb),
.B(B_tb),
.ALU_FUNC(ALU_FUNC_tb),
.CLK(CLK_tb),
.RST(RST_tb),
.Arith_OUT(Arith_OUT_tb), 
.Logic_OUT(Logic_OUT_tb),
.CMP_OUT(CMP_OUT_tb),
.SHIFT_OUT(SHIFT_OUT_tb),
.Arith_Flag(Arith_Flag_tb),
.Logic_Flag(Logic_Flag_tb),
.CMP_Flag(CMP_Flag_tb),
.SHIFT_Flag(SHIFT_Flag_tb) 
	);


always begin
	#4
	CLK_tb = ~CLK_tb;
	#6
	CLK_tb = ~CLK_tb;
end


initial 
begin
	$dumpfile("count.vcd");
	$dumpvars;
	CLK_tb = 0;
	RST_tb = 1;


	//First test testing the addition negative negative (-6 + -25)
	$display("*** Test case 1 --Addition-- Neg + Neg (-6 + -25) ***");
	ALU_FUNC_tb = 4'b0000;
	A_tb = 'shFFFA;
	B_tb = 'shFFE7;
	#10
	if (Arith_OUT_tb == 32'shffffffe1 && Arith_Flag_tb == 1) begin
		$display("Test 1 Passed");
	end else begin
		$display("Test Failed");
	end


	//Second test testing the addition positive negative (42 + -27)
	$display("*** Test case 2 --Addition-- Pos + Neg (42 + -27) ***");
	ALU_FUNC_tb = 4'b0000;
	A_tb = 'sh002A;
	B_tb = 'shFFE5;
	#10
	if (Arith_OUT_tb == 32'sh000F && Arith_Flag_tb == 1) begin
		$display("Test 2 Passed");
	end else begin
		$display("Test Failed");
	end


	//Third test testing the addition negative positive (-56 + 42)
	$display("*** Test case 3 --Addition-- Neg + Pos (-56 + 42) ***");
	ALU_FUNC_tb = 4'b0000;
	A_tb = 'shFFC8;
	B_tb = 'sh002A;
	#10
	if (Arith_OUT_tb == 32'shFFFFFFF2 && Arith_Flag_tb == 1) begin
		$display("Test 3 Passed");
	end else begin
		$display("Test Failed");
	end


	//Fourth test testing the addition positive positive (100 + 56)
	$display("*** Test case 4 --Addition-- Pos + Pos (100 + 56) ***");
	ALU_FUNC_tb = 4'b0000;
	A_tb = 'sh0064;
	B_tb = 'sh0038;
	#10
	if (Arith_OUT_tb == 32'sh009C && Arith_Flag_tb == 1) begin
		$display("Test 4 Passed");
	end else begin
		$display("Test Failed");
	end


	//Fifth test testing the Subtraction Negative Negative (-43 - -76)
	$display("*** Test case 5 --Subtraction-- Neg + Neg (-43 - -76) ***");
	ALU_FUNC_tb = 4'b0001;
	A_tb = 'shFFD5;
	B_tb = 'shFFB4;
	#10
	if (Arith_OUT_tb == 32'sh0021 && Arith_Flag_tb == 1) begin
		$display("Test 5 Passed");
	end else begin
		$display("Test Failed");
	end


	//Sixth test testing the Subtraction Positive Negative (43 - -76)
	$display("*** Test case 6 --Subtraction-- Pos + Neg (43 - -76) ***");
	ALU_FUNC_tb = 4'b0001;
	A_tb = 'sh002B;
	B_tb = 'shFFB4;
	#10
	if (Arith_OUT_tb == 32'sh0077 && Arith_Flag_tb == 1) begin
		$display("Test 6 Passed");
	end else begin
		$display("Test Failed");
	end


	//Seventh test testing the Subtraction Negative Positve (-43 - 76)
	$display("*** Test case 7 --Subtraction-- Neg + Pos (-43 - 76) ***");
	ALU_FUNC_tb = 4'b0001;
	A_tb = 'shFFD5;
	B_tb = 'sh004C;
	#10
	if (Arith_OUT_tb == 32'shFFFFFF89 && Arith_Flag_tb == 1) begin
		$display("Test 7 Passed");
	end else begin
		$display("Test Failed");
	end


	//Eighth test testing the Subtraction Positive Positive (43 - 76)
	$display("*** Test case 8 --Subtraction-- Pos + Pos (43 - 76) ***");
	ALU_FUNC_tb = 4'b0001;
	A_tb = 'sh002B;
	B_tb = 'sh004C;
	#10
	if (Arith_OUT_tb == 32'shFFFFFFDF && Arith_Flag_tb == 1) begin
		$display("Test 8 Passed");
	end else begin
		$display("Test Failed");
	end


	//Nineth test testing the Multiplication Negative Negative (-5 * -7)
	$display("*** Test case 9 --Multiplication-- Neg + Neg (-5 * -7) ***");
	ALU_FUNC_tb = 4'b0010;
	A_tb = 'shFFFB;
	B_tb = 'shFFF9;
	#10
	if (Arith_OUT_tb == 32'sh0023 && Arith_Flag_tb == 1) begin
		$display("Test 9 Passed");
	end else begin
		$display("Test Failed");
	end


	//Tenth test testing the Multiplication Positive Negative (5 * -7)
	$display("*** Test case 10 --Multiplication-- Pos + Neg (5 * -7) ***");
	ALU_FUNC_tb = 4'b0010;
	A_tb = 'sh0005;
	B_tb = 'shFFF9;
	#10
	if (Arith_OUT_tb == 32'shFFFFFFDD && Arith_Flag_tb == 1) begin
		$display("Test 10 Passed");
	end else begin
		$display("Test Failed");
	end


	//Eleventh test testing the Multiplication Negative Positive (-5 * 7)
	$display("*** Test case 11 --Multiplication-- Neg + Pos (-5 * 7) ***");
	ALU_FUNC_tb = 4'b0010;
	A_tb = 'shFFFB;
	B_tb = 'sh0007;
	#10
	if (Arith_OUT_tb == 32'shFFFFFFDD && Arith_Flag_tb == 1) begin
		$display("Test 11 Passed");
	end else begin
		$display("Test Failed");
	end


	//Twelveth test testing the Multiplication Positive Positive (5 * 7)
	$display("*** Test case 12 --Multiplication-- Pos + Pos (5 * 7) ***");
	ALU_FUNC_tb = 4'b0010;
	A_tb = 'sh0005;
	B_tb = 'sh0007;
	#10
	if (Arith_OUT_tb == 32'sh0023 && Arith_Flag_tb == 1) begin
		$display("Test 12 Passed");
	end else begin
		$display("Test Failed");
	end


	//Thirtinth test testing the Division Negative Negative (-50 / -5)
	$display("*** Test case 13 --Division-- Neg + Neg (-50 / -5) ***");
	ALU_FUNC_tb = 4'b0011;
	A_tb = 'shFFCE;
	B_tb = 'shFFFB;
	#10
	if (Arith_OUT_tb == 32'sh000A && Arith_Flag_tb == 1) begin
		$display("Test 13 Passed");
	end else begin
		$display("Test Failed");
	end


	//Fourtenth test testing the Division Positive Negative (50 / -5)
	$display("*** Test case 14 --Division-- Pos + Neg (50 / -5) ***");
	ALU_FUNC_tb = 4'b0011;
	A_tb = 'sh0032;
	B_tb = 'shFFFB;
	#10
	if (Arith_OUT_tb == 32'shFFFFFFF6 && Arith_Flag_tb == 1) begin
		$display("Test 14 Passed");
	end else begin
		$display("Test Failed");
	end


	//Fiftenth test testing the Division Negative Positive (-50 / 5)
	$display("*** Test case 15 --Division-- Neg + Pos (-50 / 5) ***");
	ALU_FUNC_tb = 4'b0011;
	A_tb = 'shFFCE;
	B_tb = 'sh0005;
	#10
	if (Arith_OUT_tb == 32'shFFFFFFF6 && Arith_Flag_tb == 1) begin
		$display("Test 15 Passed");
	end else begin
		$display("Test Failed");
	end


	//Sixtenth test testing the Division Positive Positive (50 / 5)
	$display("*** Test case 16 --Division-- Pos + Pos (50 / 5) ***");
	ALU_FUNC_tb = 4'b0011;
	A_tb = 'sh0032;
	B_tb = 'sh0005;
	#10
	if (Arith_OUT_tb == 32'sh000A && Arith_Flag_tb == 1) begin
		$display("Test 16 Passed");
	end else begin
		$display("Test Failed");
	end


	//Sevententh test testing the And gate
	$display("*** Test case 17 --And-- ***");
	ALU_FUNC_tb = 4'b0100;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (Logic_OUT_tb == 16'b0010 && Logic_Flag_tb == 1) begin
		$display("Test 17 Passed");
	end else begin
		$display("Test Failed");
	end


	//Eightenth test testing the or gate
	$display("*** Test case 18 --Or-- ***");
	ALU_FUNC_tb = 4'b0101;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (Logic_OUT_tb == 16'b1011 && Logic_Flag_tb == 1) begin
		$display("Test 18 Passed");
	end else begin
		$display("Test Failed");
	end


	//Nineteenth test testing the Nand gate
	$display("*** Test case 19 --Nand-- ***");
	ALU_FUNC_tb = 4'b0110;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1001 ;
	#10
	if (Logic_OUT_tb == 16'hFFFE && Logic_Flag_tb == 1) begin
		$display("Test 19 Passed");
	end else begin
		$display("Test Failed");
	end


	//twentyth test testing the nor gate
	$display("*** Test case 20 --Nor-- ***");
	ALU_FUNC_tb = 4'b0111;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (Logic_OUT_tb == 16'hFFF4 && Logic_Flag_tb == 1) begin
		$display("Test 20 Passed");
	end else begin
		$display("Test Failed");
	end


	//twenty first test testing the NOP 
	$display("*** Test case 21 --NOP-- ***");
	ALU_FUNC_tb = 4'b1000;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (CMP_OUT_tb == 2'b00 && CMP_Flag_tb == 1) begin
		$display("Test 21 Passed");
	end else begin
		$display("Test Failed");
	end


	//twenty second test testing the equality function 
	$display("*** Test case 22 --Equal-- ***");
	ALU_FUNC_tb = 4'b1001;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (CMP_OUT_tb == 2'b00 && CMP_Flag_tb == 1) begin
		$display("Test 22 Passed");
	end else begin
		$display("Test Failed");
	end


	//twenty third test testing the greater than function 
	$display("*** Test case 23 --Greater-- ***");
	ALU_FUNC_tb = 4'b1010;
	A_tb = 16'sb1011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (CMP_OUT_tb == 2'b10 && CMP_Flag_tb == 1) begin
		$display("Test 23 Passed");
	end else begin
		$display("Test Failed");
	end


	//twenty fourth test testing the less than function 
	$display("*** Test case 24 --Lesser-- ***");
	ALU_FUNC_tb = 4'b1011;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (CMP_OUT_tb == 2'b11 && CMP_Flag_tb == 1) begin
		$display("Test 24 Passed");
	end else begin
		$display("Test Failed");
	end


	//twenty fifth test testing the Shift A>>1 function 
	$display("*** Test case 25 --Shift A>>1-- ***");
	ALU_FUNC_tb = 4'b1100;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (SHIFT_OUT_tb == 17'sb0001 && SHIFT_Flag_tb == 1) begin
		$display("Test 25 Passed");
	end else begin
		$display("Test Failed");
	end


	//twenty sixth test testing the Shift A<<1 function 
	$display("*** Test case 26 --Shift A<<1-- ***");
	ALU_FUNC_tb = 4'b1101;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (SHIFT_OUT_tb == 17'sb0110 && SHIFT_Flag_tb == 1) begin
		$display("Test 26 Passed");
	end else begin
		$display("Test Failed");
	end


	//twenty seventh test testing the Shift B>>1 function 
	$display("*** Test case 27 --Shift B>>1-- ***");
	ALU_FUNC_tb = 4'b1110;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (SHIFT_OUT_tb == 17'sb0101 && SHIFT_Flag_tb == 1) begin
		$display("Test 27 Passed");
	end else begin
		$display("Test Failed");
	end


	//twenty eighth test testing the Shift B<<1 function 
	$display("*** Test case 28 --Shift B<<1-- ***");
	ALU_FUNC_tb = 4'b1111;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (SHIFT_OUT_tb == 17'sb10100 && SHIFT_Flag_tb == 1) begin
		$display("Test 28 Passed");
	end else begin
		$display("Test Failed");
	end


	//twenty nineth test testing the reset function 
	$display("*** Test case 29 --Reset-- ***");
	RST_tb = 0;
	ALU_FUNC_tb = 4'b1111;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (SHIFT_OUT_tb == 17'sb0000 && SHIFT_Flag_tb == 0) begin
		$display("Test 29 Passed");
	end else begin
		$display("Test Failed");
	end
	RST_tb = 1;


	//Thirtyth test testing that when the arith flag is up all other flags are down 
	$display("*** Test case 30 when the arith flag is up all other flags are down ***");
	ALU_FUNC_tb = 4'b0001;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (Arith_Flag_tb == 1 && Logic_Flag_tb == 0 && CMP_Flag_tb == 0 && SHIFT_Flag_tb == 0) begin
		$display("Test 30 Passed");
	end else begin
		$display("Test Failed");
	end


	//Thirty first test testing that when the Logic flag is up all other flags are down 
	$display("*** Test case 31 when the Logic flag is up all other flags are down ***");
	ALU_FUNC_tb = 4'b0101;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (Arith_Flag_tb == 0 && Logic_Flag_tb == 1 && CMP_Flag_tb == 0 && SHIFT_Flag_tb == 0) begin
		$display("Test Passed");
	end else begin
		$display("Test Failed");
	end


	//Thirty second test testing that when the CMP flag is up all other flags are down 
	$display("*** Test case 32 when the CMP flag is up all other flags are down ***");
	ALU_FUNC_tb = 4'b1001;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (Arith_Flag_tb == 0 && Logic_Flag_tb == 0 && CMP_Flag_tb == 1 && SHIFT_Flag_tb == 0) begin
		$display("Test 32 Passed");
	end else begin
		$display("Test Failed");
	end


	//Thirty third test testing that when the shift flag is up all other flags are down 
	$display("*** Test case 33 when the Shift flag is up all other flags are down ***");
	ALU_FUNC_tb = 4'b1101;
	A_tb = 16'sb0011 ; 
	B_tb = 16'sb1010 ;
	#10
	if (Arith_Flag_tb == 0 && Logic_Flag_tb == 0 && CMP_Flag_tb == 0 && SHIFT_Flag_tb == 1) begin
		$display("Test 33 Passed");
	end else begin
		$display("Test Failed");
	end

	$stop;
end




endmodule