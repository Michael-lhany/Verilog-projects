module ALU_TOP #(parameter Data_In_WIDTH = 16, Arith_Out_WIDTH = 32, Logic_Out_WIDTH = 16, CMP_Out_WIDTH = 2, Shift_Out_WIDTH = 17) (

input wire signed [Data_In_WIDTH-1 : 0] A,
input wire signed [Data_In_WIDTH-1 : 0] B,
input wire [3:0] ALU_FUNC,
input wire CLK,
input wire RST,
output wire signed [Arith_Out_WIDTH-1 : 0] Arith_OUT, 
output wire [Logic_Out_WIDTH-1 : 0] Logic_OUT,
output wire [CMP_Out_WIDTH-1 : 0] CMP_OUT,
output wire [Shift_Out_WIDTH-1 : 0] SHIFT_OUT,
output wire Arith_Flag, Logic_Flag, CMP_Flag, SHIFT_Flag 
	);

wire Arith_Enable, Logic_Enable, CMP_Enable, Shift_Enable;


Decoder_Unit Decoder(
.ALU_FUN(ALU_FUNC[3:2]),
.Arith_Enable(Arith_Enable),
.Logic_Enable(Logic_Enable),
.CMP_Enable(CMP_Enable),
.Shift_Enable(Shift_Enable)
	);


ARITHMETIC_UNIT #(.Arith_In_WIDTH(Data_In_WIDTH),.Arith_Out_WIDTH(Arith_Out_WIDTH)) Arith_unit(
.A(A),
.B(B),
.ALU_FUN(ALU_FUNC[1:0]),
.CLK(CLK),
.RST(RST),
.Arith_Enable(Arith_Enable),
.Arith_OUT(Arith_OUT),
.Arith_Flag(Arith_Flag)
	);


LOGIC_UNIT #(.Logic_In_WIDTH(Data_In_WIDTH),.Logic_Out_WIDTH(Logic_Out_WIDTH)) Logic_unit(
.A(A),
.B(B),
.ALU_FUN(ALU_FUNC[1:0]),
.CLK(CLK),
.RST(RST),
.Logic_Enable(Logic_Enable),
.Logic_OUT(Logic_OUT),
.Logic_Flag(Logic_Flag)
	);


CMP_UNIT #(.CMP_In_WIDTH(Data_In_WIDTH),.CMP_Out_WIDTH(CMP_Out_WIDTH)) CMP_unit(
.A(A),
.B(B),
.ALU_FUN(ALU_FUNC[1:0]),
.CLK(CLK),
.RST(RST),
.CMP_Enable(CMP_Enable),
.CMP_OUT(CMP_OUT),
.CMP_Flag(CMP_Flag)
	);


SHIFT_UNIT #(.Shift_In_WIDTH(Data_In_WIDTH),.Shift_Out_WIDTH(Shift_Out_WIDTH)) Shift_unit(
.A(A),
.B(B),
.ALU_FUN(ALU_FUNC[1:0]),
.CLK(CLK),
.RST(RST),
.Shift_Enable(Shift_Enable),
.Shift_OUT(SHIFT_OUT),
.Shift_Flag(SHIFT_Flag)
	);


endmodule