/*
 * Assignment     : 7
 * Semester       : Autumn 2021 
 * Group          : 46
 * Name1          : Neha Dalmia
 * RollNumber1    : 19CS30055
 * Name2          : Rajat Bachhawat
 * RollNumber2    : 19CS10073
 */

`timescale 1ns / 1ps

module KGPRISC (
    input clk,
    input reset,
	output [31:0] result
    );
	 
	reg [31:0] program_output;
	
	wire [31:0] PC;
	wire [31:0] PCN;
    wire [31:0] instruction;

    // Breaking up of the instruction, obtained from instruction decoder
	wire [2:0] opcode;
    wire [3:0] func_code;
    wire [4:0] reg_addr_1, reg_addr_2;
    wire [31:0] imm;
    wire [31:0] label;
	
    // Control Signals output from the controller
	wire [3:0] alu_operation;
	wire reg_dst, mem_read, mem_to_reg, mem_write, is_branch, reg_write, ALU_src;

	// Data to be written to the register file
	wire [31:0] reg_write_data;
	// Address to be written to
	wire [4:0] reg_write_addr;
	// Data read from the register file
	wire [31:0] reg_read_data_1, reg_read_data_2;
	
    // Flags from the ALU
	wire zeroFlag, carryFlag, signFlag;
	wire [31:0] alu_result;

	// Output from the Data memory block
	wire [31:0] mem_data_out;
	
	program_counter pc (
      .clk(clk), 
		.reset(reset),
		.PCN(PCN),
		.PC(PC)
    );														
	
	instruction_fetch IF (
      .clk(clk), 
		.PC(PC), 
		.reset(reset),
	   .instruction(instruction)
    );
	
	instruction_decoder ID (
		  .PC(PCN),
        .instruction(instruction),
        .opcode(opcode),
		.rs(reg_addr_1),
		.rt(reg_addr_2),
		.func_code(func_code),
		.imm(imm),
        .label(label)
    );
	
	controller CU (
		.reset(reset),
		.opcode(opcode),
		.func_code(func_code),
		.reg_dst(reg_dst),
		.mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
		.mem_write(mem_write),
		.is_branch(is_branch),
		.operation(alu_operation),
		.ALU_src(ALU_src),
		.reg_write(reg_write)
    );

	data_memory_module DM (
        .clk(clk), 
		.reset(reset), 
		.mem_write(mem_write), 
		.mem_read(mem_read), 
		.address(alu_result[9:0]),
		.input_data(reg_read_data_2), 
		.output_data(mem_data_out)
    );
	 
	mux21_32bit write_to_reg_mux (
		.in1(mem_data_out),
		.in0(alu_result),
		.select(mem_to_reg),
		.out(reg_write_data)
	);

	mux21_5bit reg_dst_mux (
		.in1(reg_addr_1),
		.in0(reg_addr_2),
		.select(reg_dst),
		.out(reg_write_addr)
	);
	
	registerfile RB (
        .clk(clk),
		.reset(reset),
		.reg_write(reg_write),
		.wrAddr(reg_write_addr), 
		.wrData(reg_write_data),
		.rdAddrA(reg_addr_1),
		.rdAddrB(reg_addr_2),
		.rdDataA(reg_read_data_1),
		.rdDataB(reg_read_data_2)
    );
					  
	wire [31:0] alu_input_2;
	mux21_32bit alu_input_mux (
		.in0(reg_read_data_2),
		.in1(imm),
		.select(ALU_src),
		.out(alu_input_2)
	);					  

	ALU ALU (
        .inp1(reg_read_data_1),
		.inp2(alu_input_2),
		.operation(alu_operation),
		.clk(clk),
		.reset(reset),
		.out(alu_result),
		.carryFlag(carryFlag),
		.zeroFlag(zeroFlag), 
		.signFlag(signFlag)
	
    );
	
	branch_logic BL (
		 .is_branch(is_branch),
	    .opcode(opcode),
	    .func_code(func_code),
	    .carryFlag(carryFlag),
        .zeroFlag(zeroFlag),
        .signFlag(signFlag),
        .address(reg_read_data_1),
        .label(label),
        .PC(PCN),
        .PCN(PC)
    );
	 
	 assign result = reg_read_data_2;

endmodule