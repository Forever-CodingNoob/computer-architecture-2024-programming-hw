module ALU(
    input [31:0] data1_i,
    input [31:0] data2_i,
    input [2:0] ALUCtrl_i,
    output reg [31:0] data_o,
    output zero_o
);
    assign zero_o = (data_o == 0);
    always @(ALUCtrl_i or data1_i or data2_i) begin
        case(ALUCtrl_i)
            3'b000: // addition
                data_o = data1_i + data2_i;
            3'b001: // subtraction
                data_o = data1_i - data2_i;
            3'b010: // bitwise and 
                data_o = data1_i & data2_i;
            3'b011: // bitwise or
                data_o = data1_i | data2_i;
            3'b100: // bitwise xor
                data_o = data1_i ^ data2_i;
            3'b101: // left shift
                data_o = data1_i << data2_i[4:0];
            3'b110: // arithmetic right shift
                data_o = $signed(data1_i) >>> data2_i[4:0];
            3'b111: // logical right shift
                data_o = data1_i >> data2_i[4:0];
            default:
                data_o = 32'b0;
        endcase
    end
endmodule
