`timescale 1ns / 1ps

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

module controller_tb;
reg [2:0] opcode;
reg [3:0] func_code;
reg clk;
reg reset;
wire  reg_dst;
wire  mem_read;
wire  mem_to_reg;
wire mem_write;
wire is_branch;
wire [3:0] operation;
wire ALU_src;
wire reg_write;

controller uut(
    .opcode(opcode),
    .func_code(func_code),
    .reset(reset),
    .reg_dst(reg_dst),
    .mem_read(mem_read),
    .mem_to_reg(mem_to_reg),
    .mem_write(mem_write),
    .is_branch(is_branch),
    .operation(operation),
    .ALU_src(ALU_src),
    .reg_write(reg_write)
);
initial begin
    reset = 1;
    // Wait 100 ns for global reset to finish
    #100;
    #10 $monitor("reset=%b,opcode=%b,function code=%b,regDest=%b,memRead=%b,memtoReg=%b,mem_write=%b, is_branch = %b, operation =%b, ALU_src =%b, reg_write = %b",reset,opcode,func_code,reg_dst,mem_read,mem_to_reg,mem_write,is_branch, operation, ALU_src,reg_write);

    #10 reset = 0; opcode = 3'b000; func_code = 4'b0000;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b000; func_code = 4'b0001;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b000; func_code = 4'b0010;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b000; func_code = 4'b0011;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b000; func_code = 4'b0100;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b000; func_code = 4'b0101;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b000; func_code = 4'b0110;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b000; func_code = 4'b0111;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b000; func_code = 4'b1000;
    #10 reset = 1;

    #10 reset = 0; opcode = 3'b001; func_code = 4'b0000;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b001; func_code = 4'b0001;
    #10 reset = 1;

    #10 reset = 0; opcode = 3'b010; func_code = 4'b0000;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b010; func_code = 4'b0001;
    #10 reset = 1;

    #10 reset = 0; opcode = 3'b011; func_code = 4'b0000;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b011; func_code = 4'b0001;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b011; func_code = 4'b0010;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b011; func_code = 4'b0011;
    #10 reset = 1;

    #10 reset = 0; opcode = 3'b100; func_code = 4'b0000;
    #10 reset = 1;

    #10 reset = 0; opcode = 3'b101; func_code = 4'b0000;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b101; func_code = 4'b0001;
    #10 reset = 1;
    #10 reset = 0; opcode = 3'b101; func_code = 4'b0010;
    #10 reset = 1;
end
endmodule