`timescale 1ps/1ps

module ForwardingUnit(
    input [4:0] ID_EX_Rs,
	input [4:0] ID_EX_Rt,
	input [4:0] EX_MEM_Rd,
	input [4:0] MEM_WB_Rd,
	input EX_MEM_RegWrite,
	input MEM_WB_RegWrite,
	output [1:0] output1,
	output [1:0] output2);

    reg [1:0] output1_temp; reg [1:0] output2_temp;

    always @(*) begin
		{output1_temp, output2_temp} = 0;
	
		if((EX_MEM_RegWrite == 1) && (EX_MEM_Rd != 0) && (EX_MEM_Rd == ID_EX_Rs)) begin
			output1_temp = 2;
		end else if((MEM_WB_RegWrite == 1) && (MEM_WB_Rd != 0) && (MEM_WB_Rd == ID_EX_Rs)) begin
			output1_temp = 1;
		end
		
		if((EX_MEM_RegWrite == 1) && (EX_MEM_Rd != 0) && (EX_MEM_Rd == ID_EX_Rt)) begin
			output2_temp = 2;
		end else if((MEM_WB_RegWrite == 1) && (MEM_WB_Rd != 0) && (MEM_WB_Rd == ID_EX_Rt)) begin
			output2_temp = 1;
		end
	end

	assign ForwardA = ForwardA_tmp;
	assign ForwardB = ForwardB_tmp;
endmodule