module Imm_Gen
(
    input [31:0] instr_i,
    output reg [63:0] imm_o
);

    always @(instr_i) begin
        case(instr_i[6:0]) // opcode
            7'b0010011: // I-type
                imm_o = {{52{instr_i[31]}}, instr_i[31:20]};
            default: // R-type or other instructions that do not require imm
                imm_o = 64'b0;
        endcase
    end
endmodule
