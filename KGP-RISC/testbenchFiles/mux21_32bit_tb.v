`timescale 1ns / 1ps
//Mux TestBench

module mux21_tb;

	// Inputs
	reg [31:0] in0;
	reg [31:0] in1;
	reg select;

	// Outputs
	wire [31:0] out;

	// Instantiate the Unit Under Test (UUT)
	mux21_32bit uut (
		.in0(in0), 
		.in1(in1), 
		.select(select), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
        $monitor("in0 = %d, in1 = %d, select = %b, output = %d", in0,in1,select,out);
		in0 = 32'b0;
		in1 = 32'b0;
		select = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		in0 = 52;
		in1 = 38;
		select=1;
		
		#20 
		select=0;
	end
      
endmodule
