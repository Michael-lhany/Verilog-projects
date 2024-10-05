`timescale 1ns/100ps

module CRC_tb ();


///		Parameters		///
parameter CLK_PERIOD = 100;
parameter Test_Cases = 10;


///		Loop variables	///
integer Operation;

///		DUT signals		///
reg 	Data_tb;
reg 	Active_tb;
reg 	CLK_tb;
reg 	RST_tb;
wire 	CRC_tb;
wire 	Valid_tb;


///		Memories		///
reg	[7:0] data_in [Test_Cases-1:0];
reg	[7:0] expected_out [Test_Cases-1:0];				


////		DUT instantiation		////
CRC DUT(
.Data(Data_tb),
.Active(Active_tb),
.CLK(CLK_tb),
.RST(RST_tb),
.CRC(CRC_tb),
.Valid(Valid_tb)
);


///		Initial block		///
initial
begin
	$dumpfile("LFSR_DUMP.vcd") ;       
	$dumpvars;

	$readmemh("DATA_h.txt",data_in);
	$readmemh("Expec_Out_h.txt",expected_out);

	init();

	for (Operation=0;Operation<Test_Cases;Operation=Operation+1)
  begin
   DATA_IN(data_in[Operation]) ;                       // do_lfsr_operation
   CRC_OUT(expected_out[Operation],Operation) ;           // check output response
  end

  #(4*CLK_PERIOD)
  $stop;

end


///		Clock Generator		///
always #(CLK_PERIOD/2)  CLK_tb = ~CLK_tb ;


///		Tasks		///

//Initialize
task init;
 begin
	CLK_tb = 'b0;
	RST_tb = 'b0;
	Active_tb = 'b0;
	Data_tb = 'b0;
 end
endtask

//Reset
task Reset;
 begin
	RST_tb = 'b1;
	#(CLK_PERIOD)
	RST_tb = 'b0;
	#(CLK_PERIOD)
	RST_tb = 'b1;
 end
endtask

//DATA_IN
task DATA_IN;
input [7:0] IN_DATA;
integer N;
 begin
	Reset();
	Active_tb = 1;
	for(N=0; N<8; N=N+1)
	 begin
		Data_tb = IN_DATA[N];
		#(CLK_PERIOD);
	 end
	Active_tb = 0;
 end
endtask

//CRC_OUT
task CRC_OUT;
input reg [7:0] Exp_Out;
input integer Operation_Num;

reg [7:0] Out_Temp;

integer N;

begin
	Active_tb = 0;
 	@(posedge Valid_tb)
	for(N=0; N<8; N=N+1)
	begin
    	#(CLK_PERIOD) Out_Temp[N] = CRC_tb ;
	end
	if(Out_Temp == Exp_Out) 
    begin
    	$display("Test Case %d succeeded",Operation_Num);
    end
    else
    begin
    	$display("Test Case %d failed", Operation_Num);
    end
end
endtask


endmodule