`timescale 1ns/100ps

module Automatic_Garage_Door_Controller_tb ();

/// 	Parameters		///
parameter CLK_PERIOD = 20;


///		integers		///
integer test_case;


/// 	Dut signals 	///
reg CLK_tb;
reg RST_tb;
reg UP_Max_tb;
reg DN_Max_tb;
reg Activate_tb;
wire UP_M_tb;
wire DN_M_tb;


///		Dut instantiation	///
Automatic_Garage_Door_Controller DUT(
.CLK(CLK_tb),
.RST(RST_tb),
.UP_Max(UP_Max_tb),
.DN_Max(DN_Max_tb),
.Activate(Activate_tb),
.UP_M(UP_M_tb),
.DN_M(DN_M_tb)
);


///		Clock generator		///
always #(CLK_PERIOD/2) CLK_tb = ~CLK_tb;


///		Initial block 		///
initial 
begin
	$dumpfile("LFSR_DUMP.vcd") ;       
	$dumpvars;

	init();
	reset();

	door_open();

	door_close();

	#CLK_PERIOD
	if (UP_M_tb == 0 && UP_M_tb == 0) begin
		$display("*** Test case %d : Staying in idle state if activate is not pressed PASSED ***",test_case);
	end else begin
		$display("Test case %d failed",test_case);
	end

	$stop;
end


///			Tasks		///

//Initialize
task init;
begin
	CLK_tb = 1'b0;
	RST_tb = 1'b1;
	Activate_tb = 1'b0;
	UP_Max_tb = 1'b0;
	DN_Max_tb = 1'b1;
	test_case = 1;
end
endtask

//Reset
task reset;
begin
	RST_tb = 1'b1;
	#CLK_PERIOD
	RST_tb = 1'b0;
	#CLK_PERIOD
	RST_tb = 1'b1;
end
endtask

//Door open
task door_open;
begin

	Activate_tb = 1'b1;
	#CLK_PERIOD
	if (UP_M_tb == 1 && DN_M_tb == 0) begin
		$display("*** Test case %d : Activating the door upwards PASSED ***",test_case);
	end else begin
		$display("Test case %d failed",test_case);
	end
	UP_Max_tb = 1'b1;
	DN_Max_tb = 1'b0;
	Activate_tb = 1'b0;
	test_case = test_case + 1;
	
	#CLK_PERIOD
	if (UP_M_tb == 0 && DN_M_tb == 0) begin
		$display("*** Test case %d : Returning to idle state after the door goes upwards PASSED ***",test_case);
	end else begin
		$display("Test case %d failed",test_case);
	end	
	test_case = test_case + 1;

end
endtask

//Door close
task door_close;
begin

	Activate_tb = 1'b1;
	#CLK_PERIOD
	if (DN_M_tb == 1 && UP_M_tb == 0) begin
		$display("*** Test case %d : Activating the door downwards PASSED ***",test_case);
	end else begin
		$display("Test case %d failed",test_case);
	end
	UP_Max_tb = 1'b0;
	DN_Max_tb = 1'b1;
	Activate_tb = 1'b0;
	test_case = test_case + 1;
	
	#CLK_PERIOD
	if (UP_M_tb == 0 && UP_M_tb == 0) begin
		$display("*** Test case %d : Returning to idle state after the door goes downwards PASSED ***",test_case);
	end else begin
		$display("Test case %d failed",test_case);
	end
	test_case = test_case + 1;

end
endtask

endmodule