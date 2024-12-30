`timescale 1ns/10ps
`define test_times 2

module ALU_tb;
    // inputs
    reg [31:0] data1;
    reg [31:0] data2;
    reg [2:0] ALUCtrl;

    // outputs
    wire [31:0] data;
    wire zero;

    // temp
    reg [31:0] expected_data; // expected output
    integer i;

    ALU alu(
        .data1_i(data1),
        .data2_i(data2),
        .ALUCtrl_i(ALUCtrl),
        .data_o(data),
        .zero_o(zero)
    );

    // monitor signals
    initial $monitor("@%0d: data1 = %h, data2 = %h, ALUCtrl = %b, data = %h, zero = %b", $time, data1, data2, ALUCtrl, data, zero);

    // dump .vcd file
    initial begin
        $dumpfile("ALU_tb.vcd");
        $dumpvars(0, alu);
    end

    // check if the result is correct
    task checker;
        begin
            if(data !== expected_data) begin
                $error("ERROR at %0d: data_o expected = %b, got = %b",
                    $time, expected_data, data);
                $stop;
            end
            if(zero !== (data == 0)) begin
                $error("ERROR at %0d: zero_o expected = %b, got = %b",
                    $time, data==0, zero);
                $stop;
            end
        end
    endtask

    // testbench
    initial begin
        // test zero_o
        #10;
        data1 = $random; 
        data2 = data1;
        ALUCtrl = 3'b001; // sub
        expected_data = 32'b0;
        #10;
        checker();

        // regular tests
        for(i=3'b000; i<=3'b111; i=i+1) begin
            repeat(`test_times) begin
                #10;
                data1 = $random; 
                data2 = $random;
                ALUCtrl = i;
                case (ALUCtrl)
                    3'b000: expected_data = data1 + data2; // add
                    3'b001: expected_data = data1 - data2; // sub
                    3'b010: expected_data = data1 & data2; // bitwise and
                    3'b011: expected_data = data1 | data2; // bitwise or
                    3'b100: expected_data = data1 ^ data2; // bitwise xor
                    3'b101: expected_data = data1 << data2[4:0]; // left shift
                    3'b110: expected_data = $signed(data1) >>> data2[4:0]; // arithmetic right shift
                    3'b111: expected_data = data1 >> data2[4:0]; // logical right shift
                    default: expected_data = 32'b0;
                endcase
                #10;
                checker();
            end
        end
        $display("all correct!");
        $finish;
    end
endmodule
