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

//Mux TestBench

module mux21_tb;

	// Inputs
	reg [4:0] in0;
	reg [4:0] in1;
	reg select;

	// Outputs
	wire [4:0] out;

	// Instantiate the Unit Under Test (UUT)
	mux21_5bit uut (
		.in0(in0), 
		.in1(in1), 
		.select(select), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
        $monitor("in0 = %b, in1 = %b, select = %b, output = %b", in0,in1,select,out);
		in0 = 5'b00000;
		in1 = 5'b00000;
		select = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		in0 = 5'b00000;
		in1 = 5'b00001;
		select=1;
		
		#20 
		select=0;
	end
      
endmodule
