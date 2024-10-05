`timescale 1ns/100ps


module Up_Dn_Counter_tb ();


reg [4:0] In_tb;
reg Load_tb, Up_tb, Down_tb;
reg CLK_tb;
wire [4:0] Counter_tb;
wire High_tb, Low_tb;


Up_Dn_Counter DUT (
.In(In_tb),
.Load(Load_tb),
.Up(Up_tb),
.Down(Down_tb),
.CLK(CLK_tb),
.Counter(Counter_tb),
.High(High_tb),
.Low(Low_tb)
);


always #5 CLK_tb = ~CLK_tb ;


initial
begin
	$dumpfile("count.vcd");
	$dumpvars;   
	CLK_tb = 0;
	Load_tb = 0;
	Up_tb = 0;
	Down_tb = 0;
	In_tb = 5'b00001;
	$display("Test case 1"); //Testing the Load function
	#10
	Load_tb = 1;
	$display("Test case 2");//Testing the Load function priority 1
	#10
	Load_tb = 1;
	Up_tb = 1;
	$display("Test case 3"); //Testing the Load function priority 2
	#10
	Load_tb = 1;
	Up_tb = 1;
	Down_tb = 1;
	$display("Test case 4"); //Testing the up function 
	#10
	Load_tb = 0;
	Up_tb = 1;
	Down_tb = 0;
	$display("Test case 5"); //Testing the Down function 
	#30
	Load_tb = 0;
	Up_tb = 0;
	Down_tb = 1;
	$display("Test case 6"); //Testing the Down function priority and the low flag
	#10
	Load_tb= 0;
	Up_tb = 1;
	Down_tb = 1;
	$display("Test case 7"); //Testing the high flag
	#40
	Load_tb = 1;
	Up_tb = 0;
	Down_tb = 0;
	In_tb = 5'b11101;
	#10
	Load_tb = 0;
	Up_tb = 1;
	Down_tb = 0;
	#40
	$stop;
end

endmodule