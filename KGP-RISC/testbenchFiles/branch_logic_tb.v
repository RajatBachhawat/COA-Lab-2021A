/*
 * Assignment     : KGPRISC
 * Semester       : Autumn 2021 
 * Group          : 46
 * Name1          : Neha Dalmia
 * RollNumber1    : 19CS30055
 * Name2          : Rajat Bachhawat
 * RollNumber2    : 19CS10073
 */

`timescale 1ns / 1ps

module branch_logic_tb;

	// Inputs
	reg clk;
    reg carryFlag;
    reg zeroFlag;
    reg signFlag;
    reg [31:0] address;
    reg [31:0] label;
    reg [31:0] PC;
    reg [2:0] opcode;
    reg [3:0] func_code;

	// Outputs
	wire [31:0] PCN;

	// Instantiate the Unit Under Test (UUT)
	branch_logic uut (
		.carryFlag(carryFlag), 
		.zeroFlag(zeroFlag), 
		.signFlag(signFlag), 
		.address(address), 
		.label(label), 
		.PC(PC), 
		.opcode(opcode), 
		.func_code(func_code), 
		.PCN(PCN)
	);

	initial begin
		// Initialize Inputs
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		$monitor("carryFlag=%b,signFlag=%b,zeroFlag=%b,address=%b,label=%b,PC=%b,opcode=%b,func_code=%b,PCN=%b",carryFlag,signFlag,zeroFlag,address,label,PC,opcode,func_code,PCN);
			
			
			// Exhaustive tests! 2 clks for all instructions due to flip flops
			
			#10 carryFlag = 0; signFlag = 0; zeroFlag = 0; address = 0; label = 10; PC = 0; opcode = 3'b011; func_code = 4'b0000;
			#10 carryFlag = 0; signFlag = 0; zeroFlag = 0; address = 0; label = 10; PC = 0; opcode = 3'b011; func_code = 4'b0001;
            #10 carryFlag = 1; signFlag = 0; zeroFlag = 0; address = 0; label = 10; PC = 0; opcode = 3'b011; func_code = 4'b0010;
            #10 carryFlag = 0; signFlag = 0; zeroFlag = 0; address = 0; label = 20; PC = 0; opcode = 3'b011; func_code = 4'b0010;
            #10 carryFlag = 1; signFlag = 0; zeroFlag = 0; address = 0; label = 10; PC = 0; opcode = 3'b011; func_code = 4'b0011;
            #10 carryFlag = 0; signFlag = 0; zeroFlag = 0; address = 0; label = 20; PC = 0; opcode = 3'b011; func_code = 4'b0011;
            #10 carryFlag = 0; signFlag = 0; zeroFlag = 0; address = 10; label = 0; PC = 0; opcode = 3'b100; func_code = 4'b0000;
            #10 carryFlag = 0; signFlag = 1; zeroFlag = 0; address = 0; label = 10; PC = 0; opcode = 3'b101; func_code = 4'b0000;
            #10 carryFlag = 0; signFlag = 0; zeroFlag = 0; address = 0; label = 10; PC = 0; opcode = 3'b101; func_code = 4'b0000;
            #10 carryFlag = 0; signFlag = 0; zeroFlag = 1; address = 0; label = 10; PC = 0; opcode = 3'b101; func_code = 4'b0001;
            #10 carryFlag = 0; signFlag = 0; zeroFlag = 0; address = 0; label = 10; PC = 0; opcode = 3'b101; func_code = 4'b0010;


			#10;
	end
      
endmodule