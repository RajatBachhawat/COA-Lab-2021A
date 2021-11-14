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

module KGPRISC_tb;

	// Inputs
	reg clk;
	reg reset;
	
	// Outputs
	wire [31:0] result;
	
	integer i;

	// Instantiate the Unit Under Test (UUT)
	KGPRISC uut (
		.clk(clk), 
		.reset(reset),
		.result(result)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0;
		for(i=0;i<300;i=i+1) begin
			#10 clk = ~clk;
		end
		$display("The result is : %d", result);
	end
endmodule

