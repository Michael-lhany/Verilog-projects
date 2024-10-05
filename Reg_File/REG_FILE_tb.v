`timescale 1us/100ns

module Reg_File_tb ();

reg WrEn_tb;
reg RdEn_tb;
reg CLK_tb;
reg RST_tb;
reg [2:0] Address_tb;
reg [15:0] WrData_tb;
wire [15:0] RdData_tb;


Reg_File Dut(
.WrEn(WrEn_tb),
.RdEn(RdEn_tb),
.CLK(CLK_tb),
.RST(RST_tb),
.Address(Address_tb),
.WrData(WrData_tb),
.RdData(RdData_tb)
	);


always #5 CLK_tb = ~CLK_tb ;


initial
begin
	$dumpfile("count.vcd");
	$dumpvars;
	CLK_tb = 0;
	RST_tb = 1;


	//First test testing the write function
	$display("First test testing the write function");
	WrEn_tb = 1;
	RdEn_tb = 0;
	Address_tb = 3'b001;
	WrData_tb = 16'b0011;
	#10


	//Second test testing the write function 2
	$display("Second test testing the write function 2");
	WrEn_tb = 1;
	RdEn_tb = 0;
	Address_tb = 3'b110;
	WrData_tb = 16'b110011;
	#10


	//Third test testing the read function
	$display("Third test testing the read function");
	WrEn_tb = 0;
	RdEn_tb = 1;
	Address_tb = 3'b001;
	#10
	if(RdData_tb == 16'b0011) begin
		$display("Test passed");
	end else begin
		$display("Test failed");
	end


	//Fourth test testing the read function 2
	$display("Fourth test testing the read function 2");
	WrEn_tb = 0;
	RdEn_tb = 1;
	Address_tb = 3'b110;
	#10
	if(RdData_tb == 16'b110011) begin
		$display("Test passed");
	end else begin
		$display("Test failed");
	end


	//Fifth test testing the reset function 
	$display("Fifth test testing the reset function");
	RST_tb = 0;
	#10
	if(RdData_tb == 16'b0000) begin
		$display("Test passed");
	end else begin
		$display("Test failed");
	end

	$stop;
end

endmodule