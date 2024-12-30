module CPU
(
    input clk_i, 
    input rst_i
);

    // TODO: Implement your CPU here
    // Do not change the name of these module instances.
    
    wire [63:0] pc, next_pc;
    wire [31:0] instr;
    wire [6:0] opcode;
    wire [4:0] RS1addr, RS2addr, RDaddr;
    wire [3:0] funct; // instr[30, 14:12]
    wire [63:0] RS2data, data1, data2, imm, ALU_data;
    wire ALU_zero;

    wire ALUOp, ALUSrc, RegWrite;
    wire [2:0] ALUCtrl;


    PC PC(
        .clk_i      (clk_i),
        .rst_i      (rst_i),
        .pc_i       (next_pc),
        .pc_o       (pc)
    );

    Instruction_Memory Instruction_Memory(
        .addr_i     (pc), 
        .instr_o    (instr)
    );


    Registers Registers(
        .clk_i      (clk_i),
        .rst_i      (rst_i),
        .RS1addr_i  (RS1addr),
        .RS2addr_i  (RS2addr),
        .RDaddr_i   (RDaddr), 
        .RDdata_i   (ALU_data),
        .RegWrite_i (RegWrite), 
        .RS1data_o  (data1), 
        .RS2data_o  (RS2data) 
    );

    Imm_Gen Imm_Gen(
        .instr_i    (instr),
        .imm_o      (imm)
    );

    ALU ALU(
        .data1_i    (data1),
        .data2_i    (data2),
        .ALUCtrl_i  (ALUCtrl),
        .data_o     (ALU_data),
        .zero_o     (ALU_zero)
    );

    Control Control(
        .opcode_i   (opcode),
        .ALUOp_o    (ALUOp),
        .ALUSrc_o   (ALUSrc),
        .RegWrite_o (RegWrite)
    );

    ALU_Control ALU_Control(
        .ALUOp_i    (ALUOp), 
        .funct_i    (funct),
        .ALUCtrl_o  (ALUCtrl)
    );

    assign next_pc = pc+4; 
    assign {RS2addr, RS1addr, RDaddr, opcode} = {instr[24:15], instr[11:0]};
    assign funct = {instr[30], instr[14:12]};
    assign data2 = ALUSrc?imm:RS2data;



endmodule
