`timescale 1ps/1ps

module HazardDetection(
    input [4:0] src1_ID,
    input [4:0] src2_ID,
    input [4:0] dest_EXE, 
    input [4:0] dest_MEM,
    input [6:0] branch_comm,
    input WB_EN_EXE, 
    input WB_EN_MEM, 
    input MEM_R_EN_EXE, 
    input ST_or_BNE, 
    input is_imm,
    output hazard_detected
);

    wire src2_is_valid, exe_has_hazard, mem_has_hazard, hazard, instr_is_branch;

    assign src2_is_valid = (~is_imm) || ST_or_BNE;

    assign exe_has_hazard = WB_EN_EXE && (src1_ID == dest_EXE || (src2_is_valid && src2_ID == dest_EXE));
    assign mem_has_hazard = WB_EN_MEM && (src1_ID == dest_MEM || (src2_is_valid && src2_ID == dest_MEM));

    assign hazard = (exe_has_hazard || mem_has_hazard);
    assign instr_is_branch = branch_comm == 7'b1100011; // conditional branch

    assign hazard_detected = (instr_is_branch && hazard) || (/*MEM_R_EN_EXE &&*/ mem_has_hazard);
endmodule