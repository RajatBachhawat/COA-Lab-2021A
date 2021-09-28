/*
 * Assignment	  : 5
 * Problem No.	  : 1
 * Semester		  : Autumn 2021 
 * Group 		  : 46
 * Name1 		  : Neha Dalmia
 * RollNumber1 	  : 19CS30055
 * Name2 		  : Rajat Bachhawat
 * RollNumber2 	  : 19CS10073
 */

`timescale 1ns / 1ps

module lfsr_tb;
	reg [3:0] seed, reset;
  	reg CLK,select;
  	wire [3:0] O;
  	lfsr mm(
		.A(seed),
		.select(select),
		.reset(reset),
		.CLK(CLK),
		.O(O)
	); 	// instantiate lfsr module
	
  	initial begin 
      	$dumpfile("lfsr.vcd");
      	$dumpvars(0,lfsr_tb);
		CLK = 1'b1;						// Start clock
		
      	seed = 4'b1111;					// Initial seed
      	select = 1'b0; reset = 4'b0000; // Load the seed value in the register
		#8 select = 1'b1;			    // Start shifting
		#120 $finish;			 		// Stop after 15 clock cycles
    end
	// Output should go from seed (1111) to seed (1111) passing through all possible 15 states
	always #4 CLK = ~CLK;
	always #8 $monitor($time, "ns -> %b", O); // monitor output change at every +ve edge of clock
endmodule