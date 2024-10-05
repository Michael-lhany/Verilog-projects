module ALU_16B (
input wire [15:0] A,B ,
input wire CLK,
input wire [3:0] ALU_FUN ,
output reg [15:0] ALU_OUT ,
output reg Carry_Flag, Arith_flag, Logic_flag, CMP_flag, Shift_flag
);

//ALU Functions

always @(posedge CLK) begin
	case (ALU_FUN)
		4'b0000:begin
			{Carry_Flag,ALU_OUT}<=A+B;
		end
		4'b0001:begin
			{Carry_Flag,ALU_OUT}<=A-B;
		end
		4'b0010:begin
			ALU_OUT<=A*B;
		end
		4'b0011:begin
			ALU_OUT<=A/B;
		end
		4'b0100:begin
			ALU_OUT<=A&B;
		end
		4'b0101:begin
			ALU_OUT<=A|B;
		end
		4'b0110:begin
			ALU_OUT<=~(A&B);
		end
		4'b0111:begin
			ALU_OUT<=~(A|B);
		end
		4'b1000:begin
			ALU_OUT<=A^B;
		end
		4'b1001:begin
			ALU_OUT<=(A~^B);
		end
		4'b1010:begin
			ALU_OUT<=(A==B);
		end
		4'b1011:begin
			if(A>B)begin
				ALU_OUT<=2;
			end else begin
				ALU_OUT<=0;
			end
		end
		4'b1100:begin
			if(A<B)begin
				ALU_OUT<=3;
			end else begin
				ALU_OUT<=0;
			end
		end
		4'b1101:begin
			ALU_OUT<=A>>1;
		end
		4'b1110:begin
			ALU_OUT<=A<<1;
		end
		default:begin
			ALU_OUT<=16'b0;
		end
	endcase
end


//Flags

always @(*) 
begin
	if (ALU_FUN == 4'b0000 || ALU_FUN == 4'b0001 || ALU_FUN == 4'b0010  || ALU_FUN == 4'b0011) begin
		Arith_flag=1;		Logic_flag=0;			CMP_flag=0;			Shift_flag=0;
	end else if (ALU_FUN == 4'b0100 || ALU_FUN == 4'b0101 || ALU_FUN == 4'b0110  || ALU_FUN == 4'b0111 || ALU_FUN == 4'b1000 || ALU_FUN == 4'b1001) begin
		Arith_flag=0;		Logic_flag=1;			CMP_flag=0;			Shift_flag=0;
	end else if (ALU_FUN == 4'b1010 || ALU_FUN == 4'b1011 || ALU_FUN == 4'b1100) begin
		Arith_flag=0;		Logic_flag=0;			CMP_flag=1;			Shift_flag=0;
	end else if (ALU_FUN == 4'b1101 || ALU_FUN == 4'b1110) begin
		Arith_flag=0;		Logic_flag=0;			CMP_flag=0;			Shift_flag=1;
	end
end
endmodule