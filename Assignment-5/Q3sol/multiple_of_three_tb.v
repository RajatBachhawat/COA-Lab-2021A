/*
 * Assignment	  : 5
 * Problem No.	  : 3
 * Semester		  : Autumn 2021 
 * Group 		  : 46
 * Name1 		  : Neha Dalmia
 * RollNumber1 	  : 19CS30055
 * Name2 		  : Rajat Bachhawat
 * RollNumber2 	  : 19CS10073
 */

`timescale 1ns / 1ps

module multiple_of_three_detector_tb;
  	reg CLK, I, RST;
  	wire O;
  	multiple_of_three_detector mtd(
		.I(I),
		.CLK(CLK),
		.RST(RST),
		.O(O)
	); // instantiate multiple_of_three_detector module

  	initial begin 
      	$dumpfile("multiple_of_three_tb.vcd");
      	$dumpvars(0,multiple_of_three_detector_tb);
      	CLK = 1'b1; // Start the clock
		// First test example
		#8
		I = 1'b0; // Set dummy start input = 0
		RST = 1'b1; // Reset to default state (S0)
		$display("FIRST STREAM [Ignore the first row (start state)]");
		// Input stream is 1111111; this stream is from MSB to LSB 
      	#8 I = 1'b1; RST = 1'b0; // On clock +ve edge, inputs are streamed in
		#8 I = 1'b1;
		#8 I = 1'b1;
		#8 I = 1'b1;
		#8 I = 1'b1;
		#8 I = 1'b1;
		#8 I = 1'b1;
		#8 I = 1'b1;
		// Second test example
		#8
		I = 1'b0;
		RST = 1'b1;
		$display("SECOND STREAM [Ignore the first row (start state)]");
		// Input stream is 00011110; this stream is from MSB to LSB 
      	#8 I = 1'b0; RST = 1'b0;
		#8 I = 1'b0;
		#8 I = 1'b0;
		#8 I = 1'b1;
		#8 I = 1'b1;
		#8 I = 1'b1;
		#8 I = 1'b1;
		#8 I = 1'b0;
		$finish; 
    end
	always #4 CLK = ~CLK;
	always #8 $monitor($time,"ns -> Input bit = %b, Is multiple of 3? = %b", I, O);
endmodule