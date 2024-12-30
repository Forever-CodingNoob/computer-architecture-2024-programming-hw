`timescale 1ns/10ps
`define clock_period 10

module Registers_tb;
    // inputs
    reg clk;
    reg [4:0] RS1addr;
    reg [4:0] RS2addr;
    reg [4:0] RDaddr;
    reg [31:0] RDdata;
    reg RegWrite;

    // outputs
    wire [31:0] RS1data;
    wire [31:0] RS2data;

    // temp
    integer i, j;
    integer value_1, value_2;

    Registers regs(
        .clk_i(clk),
        .RS1addr_i(RS1addr),
        .RS2addr_i(RS2addr),
        .RDaddr_i(RDaddr),
        .RDdata_i(RDdata),
        .RegWrite_i(RegWrite),
        .RS1data_o(RS1data),
        .RS2data_o(RS2data)
    );

    // set up clock
    initial clk = 0;
    always #(`clock_period/2) clk = ~clk;

    // monitor signals
    initial $monitor("@%0d: RS1addr = %d, RS2addr = %d, RDaddr = %d, RDdata = %h, RegWrite = %b, RS1data = %h, RS2data = %h", $time, RS1addr, RS2addr, RDaddr, RDdata, RegWrite, RS1data, RS2data);

    // dump .vcd file
    initial begin
        $dumpfile("Registers_tb.vcd");
        $dumpvars(0, regs);
    end

    task checker(
        input [4:0] reg_addr, 
        input [31:0] reg_value, 
        input [31:0] correct_value
    );
        reg [31:0] _correct_value;
        begin
            _correct_value = (reg_addr == 0)? 32'b0: correct_value;

            if(reg_value !== _correct_value) begin
                $error("ERROR at %0d: rs%d expected = %d, got = %d", 
                    $time, reg_addr, _correct_value, reg_value);
                $stop;
            end
        end
    endtask


    // testbench
    initial begin
        for(i=0; i<31; i=i+1) begin
            for(j=i+1; j<32; j=j+1) begin
                value_1 = $random;
                value_2 = $random;

                @(negedge clk);

                RS1addr <= i;
                RS2addr <= j;
                RegWrite <= 1;
                RDaddr <= i;
                RDdata <= value_1;
                
                @(negedge clk);

                checker(RS1addr, RS1data, value_1);
                RDaddr <= j;
                RDdata <= value_2;
            
                @(negedge clk);

                checker(RS2addr, RS2data, value_2);
                RegWrite <= 0;
                RDaddr <= j;
                RDdata <= RS2data+1;
            
                @(negedge clk);

                checker(RS2addr, RS2data, value_2);
            end
        end
        $display("all correct!");
        $finish;
    end
    

endmodule
