`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/12 07:23:42
// Design Name: 
// Module Name: REG_EXE_MEM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module REG_EXE_MEM(
        input clk,
        input rst,
        input CE,
        // Input
        input [31:0] inst_in,
        input [31:0] PC,
        input [31:0] ALU_out,
        input [31:0] Data_out,
        input mem_w,
        input [1:0] DatatoReg,
        input RegWrite,
        input [4:0] written_reg,
        input [4:0] read_reg1,
        input [4:0] read_reg2,
        input WB_EN_IN,
		input MEM_R_EN_IN,
		input MEM_W_EN_IN,
        
        // Output
        output reg [31:0] EXE_MEM_inst_in,
        output reg [31:0] EXE_MEM_PC = 0,
        output reg [31:0] EXE_MEM_ALU_out,
        output reg [31:0] EXE_MEM_Data_out,
        output reg EXE_MEM_mem_w,
        output reg [1:0] EXE_MEM_DatatoReg,
        output reg EXE_MEM_RegWrite,
        output reg [4:0] EXE_MEM_written_reg,
        output reg [4:0] EXE_MEM_read_reg1,
        output reg [4:0] EXE_MEM_read_reg2,

        output reg WB_EN,
		output reg MEM_R_EN,
		output reg MEM_W_EN
    );
    always @ (posedge clk or posedge rst) begin
        if (rst == 1) begin
            { WB_EN, MEM_R_EN, MEM_W_EN } <= 3'b000;
            EXE_MEM_inst_in     <= 32'h00000013;
            EXE_MEM_PC          <= 32'h00000000;
            EXE_MEM_ALU_out     <= 32'h00000000;
            EXE_MEM_Data_out    <= 32'h00000000;
            EXE_MEM_mem_w       <= 1'b0;
            EXE_MEM_DatatoReg   <= 2'b00;
            EXE_MEM_RegWrite    <= 1'b0;
            EXE_MEM_written_reg <= 5'b00000;
            EXE_MEM_read_reg1   <= 5'b00000;
            EXE_MEM_read_reg2   <= 5'b00000;
            
        end
        else if (CE) begin
            { WB_EN, MEM_R_EN, MEM_W_EN } <= { WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN };
            EXE_MEM_inst_in     <= inst_in;
            EXE_MEM_PC          <= PC;
            EXE_MEM_Data_out    <= Data_out; 
            EXE_MEM_ALU_out     <= ALU_out; 
            EXE_MEM_mem_w       <= mem_w;
            EXE_MEM_DatatoReg   <= DatatoReg;
            EXE_MEM_RegWrite    <= RegWrite;
            EXE_MEM_written_reg <= written_reg;
            EXE_MEM_read_reg1   <= read_reg1;
            EXE_MEM_read_reg2   <= read_reg2;
            //$display("REG_EXE_MEM: %t, %t, %t\n", $time, ALU_out, EXE_MEM_ALU_out);
        end
    end
endmodule