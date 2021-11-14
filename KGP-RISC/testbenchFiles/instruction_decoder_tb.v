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

module instruction_decoder_tb;
    reg [31:0] instruction;
    reg [31:0] PC;
    wire [2:0] opcode;
    wire [3:0] func_code;
    wire [4:0] rs; wire[4:0] rt;
    wire [31:0] imm;
    wire [31:0] label;

    instruction_decoder ID (
        .instruction(instruction),
        .PC(PC),
        .opcode(opcode),
        .func_code(func_code),
        .rs(rs),
        .rt(rt),
        .imm(imm),
        .label(label)
    );
    
    initial begin
        #100 
        #10 $monitor("instruction = %b, PC = %b, opcode = %b, func_code = %b, rs = %b, rt = %b, imm = %b, label = %b",instruction,PC,opcode,func_code,rs,rt,imm,label);
        #10 instruction = 32'b00000100000010000000000000000000; PC = 5; // add instruction
        #10 instruction = 32'b00100100110000000100000000010000; PC = 5; // addi instruction
        #10 instruction = 32'b01000001000100000000000000000010; PC = 5; // load instruction
        #10 instruction = 32'b01100000000000000000000000010000; PC = 5; // b instruction
        #10 instruction = 32'b01100000000000000000000000010001; PC = 5; // bl instruction
        #10 instruction = 32'b10000001000100000000000000000000; PC = 5; // br instruction
        #10 instruction = 32'b10100001000000000000000000010001; PC = 5; // bz instruction
        $finish;
    end

endmodule