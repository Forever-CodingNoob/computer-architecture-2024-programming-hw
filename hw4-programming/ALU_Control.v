module ALU_Control
(
    input ALUOp_i, 
    input [3:0] funct_i, // instruction[30, 14:12]
    output reg [2:0] ALUCtrl_o
);
    always @(ALUOp_i or funct_i) begin
        case(ALUOp_i)
            1'b0: begin // I-type
                case(funct_i[2:0]) // check funct3
                    3'b000: ALUCtrl_o = 3'b000; // addi
                    3'b100: ALUCtrl_o = 3'b100; // xori
                    3'b110: ALUCtrl_o = 3'b011; // ori
                    3'b111: ALUCtrl_o = 3'b010; // andi
                    3'b001: ALUCtrl_o = 3'b101; // slli
                    3'b101: ALUCtrl_o = funct_i[3] ? 3'b110 : 3'b111; // srai or srli
                endcase
            end
            1'b1: begin // R-type
                case(funct_i) // check {instruction[30], funct3}
                    4'b0000: ALUCtrl_o = 3'b000; // add
                    4'b1000: ALUCtrl_o = 3'b001; // sub
                    4'b0100: ALUCtrl_o = 3'b100; // xor
                    4'b0110: ALUCtrl_o = 3'b011; // or
                    4'b0111: ALUCtrl_o = 3'b010; // and
                    4'b0001: ALUCtrl_o = 3'b101; // sll
                    4'b0101: ALUCtrl_o = 3'b111; // srl
                    4'b1101: ALUCtrl_o = 3'b110; // sra
                endcase
            end
        endcase
    end
endmodule
