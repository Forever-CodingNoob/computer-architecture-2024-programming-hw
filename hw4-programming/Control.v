module Control
(
    input [6:0] opcode_i, // instruction[6:0]
    output ALUOp_o,
    output ALUSrc_o,
    output RegWrite_o
);
   
    // ALUOp: R-type -> 1, I-type -> 0
    assign ALUOp_o = (opcode_i[5] == 1'b1); // opcode[5]==1 iff instr is R-type
    assign ALUSrc_o = (opcode_i == 7'b0010011);
    assign RegWrite_o = (opcode_i == 7'b0010011 || opcode_i == 7'b0110011);

endmodule
