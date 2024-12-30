`define read_reg(addr) ((addr==0)?32'b0:registers[addr])
module Registers(
    input clk_i,
    input [4:0] RS1addr_i,
    input [4:0] RS2addr_i,
    input [4:0] RDaddr_i,
    input [31:0] RDdata_i,
    input RegWrite_i,
    output [31:0] RS1data_o,
    output [31:0] RS2data_o
);
    reg [31:0] registers [0:31];

    assign RS1data_o = `read_reg(RS1addr_i);
    assign RS2data_o = `read_reg(RS2addr_i);

    always @(posedge clk_i) begin
        if(RegWrite_i && RDaddr_i != 0) begin
            registers[RDaddr_i] <= RDdata_i;
        end
    end
endmodule
