module ALU_arithmetic_tb;
    reg [31:0]  input1, input2;
    reg [2:0]   ALUCtrl_i;
    wire [31:0] result;
    wire        zero;

    ALU alu (
        .data1_i(input1), 
        .data2_i(input2), 
        .ALUCtrl_i(ALUCtrl_i), 
        .data_o(result), 
        .zero_o(zero)
      );

    initial begin
        $display("Test for Addition");
        #10 ALUCtrl_i = 3'b000; input1 = 32'h00000001; input2 = 32'h00000001;
        #10 input1 = 32'hffffffff; input2 = 32'h00000001;
        #10 input1 = 32'h80000000; input2 = 32'h80000000;
        #10 input1 = 32'h7fffffff; input2 = 32'h00000001;
        #10 input1 = 32'h12345678; input2 = 32'h87654321;
        #10 $display("Test for Subtraction");
        #10 ALUCtrl_i = 3'b001; input1 = 32'h00000001; input2 = 32'h00000001;
        #10 input1 = 32'h00000000; input2 = 32'h00000001;
        #10 input1 = 32'h80000000; input2 = 32'h00000001;
        #10 input1 = 32'h7fffffff; input2 = 32'hffffffff;
        #10 input1 = 32'h12345678; input2 = 32'h87654321;
        #10 $display("Test for Bitwise AND");
        #10 ALUCtrl_i = 3'b010; input1 = 32'hffffffff; input2 = 32'hffffffff;
        #10 input1 = 32'hffffffff; input2 = 32'h00000000;
        #10 input1 = 32'h12345678; input2 = 32'h87654321;
        #10 input1 = 32'haaaaaaaa; input2 = 32'h55555555;
        #10 input1 = 32'h00000001; input2 = 32'h00000001;
        #10 $display("Test for Bitwise OR");
        #10 ALUCtrl_i = 3'b011; input1 = 32'hffffffff; input2 = 32'hffffffff;
        #10 input1 = 32'hffffffff; input2 = 32'h00000000;
        #10 input1 = 32'h12345678; input2 = 32'h87654321;
        #10 input1 = 32'haaaaaaaa; input2 = 32'h55555555;
        #10 input1 = 32'h00000001; input2 = 32'h00000001;
        #10 $display("Test for Bitwise XOR");
        #10 ALUCtrl_i = 3'b100; input1 = 32'hffffffff; input2 = 32'hffffffff;
        #10 input1 = 32'hffffffff; input2 = 32'h00000000;
        #10 input1 = 32'h12345678; input2 = 32'h87654321;
        #10 input1 = 32'haaaaaaaa; input2 = 32'h55555555;
        #10 input1 = 32'h00000001; input2 = 32'h00000001;
        #10 $display("Test for Left Shift");
        #10 ALUCtrl_i = 3'b101; input1 = 32'h00000001; input2 = 32'h00010001;
        #10 input1 = 32'h00000001; input2 = 32'h0000001f;
        #10 input1 = 32'hffffffff; input2 = 32'h01000005;
        #10 input1 = 32'h12345678; input2 = 32'h00000004;
        #10 input1 = 32'h80000000; input2 = 32'h00a00001;
        #10 $display("Test for Arithmetic Right Shift");
        #10 ALUCtrl_i = 3'b110; input1 = 32'h80000000; input2 = 32'h0000b001;
        #10 input1 = 32'hffffffff; input2 = 32'h0c00001f;
        #10 input1 = 32'h7fffffff; input2 = 32'h00000001;
        #10 input1 = 32'h12345678; input2 = 32'h00088004;
        #10 input1 = 32'h80000000; input2 = 32'h00f0001f;
        #10 $display("Test for Logical Right Shift");
        #10 ALUCtrl_i = 3'b111; input1 = 32'h80000000; input2 = 32'h00ab0001;
        #10 input1 = 32'hffffffff; input2 = 32'h0000001f;
        #10 input1 = 32'h7fffffff; input2 = 32'h0000c001;
        #10 input1 = 32'h12345678; input2 = 32'h12300004;
        #10 input1 = 32'h80000000; input2 = 32'h0000001f;
        #10 $finish(0);
    end

    initial begin
        $monitor("%x  %x  %x  %b", input1, input2, result, zero);
    end
endmodule