`define read_reg(addr) ((addr==0)?64'b0:register[addr])
module Registers
( // Do not modify port names
    input         clk_i,
    input         rst_i,
    input  [4:0]  RS1addr_i,
    input  [4:0]  RS2addr_i,
    input  [4:0]  RDaddr_i,
    input  [63:0] RDdata_i,
    input         RegWrite_i,
    output [63:0] RS1data_o, 
    output [63:0] RS2data_o
);

// Store the content of registers here.
// Do not change the name.
reg signed [63:0] register [0:31];
integer i;

// TODO: Implement your register file here.
// All registers should be reset to 0 when rst_i is high.
// Make sure that register[0] is always 0.


assign RS1data_o = `read_reg(RS1addr_i);
assign RS2data_o = `read_reg(RS2addr_i);

always @(posedge clk_i or posedge rst_i) begin
    if(rst_i) begin // if rst_i reaches rising edge
        for(i=0; i<32; i=i+1)
            register[i] <= 64'b0;
    end 
    else if(RegWrite_i && RDaddr_i != 0) begin // if clk_i reaches rising edge
        register[RDaddr_i] <= RDdata_i;
    end
end

endmodule 
