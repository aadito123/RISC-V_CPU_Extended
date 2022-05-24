module conditionChecker (
    input [6:0] OPcode,
    input [2:0] Fun1,
    input [31:0] reg1,
    input [31:0] reg2,
    output reg brCond
);
  always @ ( * ) begin
    case (OPcode)
        7'b1101111, 7'b1100111: brCond <= 1;
        7'b1100011: begin 
            case (Fun1)
                3'b000: brCond <= (reg1 == reg2) ? 1 : 0; // BEQ
                3'b001: brCond <= (reg1 != reg2) ? 1 : 0; // BNE
                3'b100: brCond <= (reg1 < reg2) ? 1 : 0; // BLT
                3'b101: brCond <= (reg1 >= reg2) ? 1 : 0; // BGE
                default: brCond <= 1;
            endcase
        end
        default: brCond <= 0;
    endcase
  end
endmodule