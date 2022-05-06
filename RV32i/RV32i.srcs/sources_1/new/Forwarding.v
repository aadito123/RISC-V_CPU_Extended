`timescale 1ps/1ps

module ForwardingUnit(
    input [4:0] src1_EXE,
	input [4:0] src2_EXE,
	input [4:0] ST_src_EXE,
	input [4:0] dest_MEM,
    input [4:0] dest_WB,
	input WB_EN_MEM,
	input WB_EN_WB,
	output reg [1:0] output_ALU1, // forwarding for ALU val1
	output reg [1:0] output_ALU2, // forwarding for ALU val2
    output reg [1:0] output_store); // forwarding for store value

    always @(*) begin
        { output_ALU1, output_ALU2, output_store } <= 6'b000000; // non-blocking assign

		// determining forwarding control signal for store value 
        if (WB_EN_MEM && ST_src_EXE == dest_MEM) output_store <= 2'b01;
        else if (WB_EN_WB && ST_src_EXE == dest_WB) output_store <= 2'b10;

        // determining forwarding control signal for ALU val1
        if (WB_EN_MEM && src1_EXE == dest_MEM) output_ALU1 <= 2'b01;
        else if (WB_EN_WB && src1_EXE == dest_WB) output_ALU1 <= 2'b10;

        // determining forwarding control signal for ALU val2
        if (WB_EN_MEM && src2_EXE == dest_MEM) output_ALU2 <= 2'b01;
        else if (WB_EN_WB && src2_EXE == dest_WB) output_ALU2 <= 2'b10;
	end
endmodule