/*
 * Assignment	  : 1
 * Problem No.	: 1
 * Semester		  : Autumn 2021 
 * Group 		    : 46
 * Name1 		    : Neha Dalmia
 * RollNumber1 	: 19CS30055
 * Name2 		    : Rajat Bachhawat
 * RollNumber2 	: 19CS10073
 */

`timescale 1ns / 1ps

// Half adder module implementation
module halfAdder(
  output sum, carryOut, 	// single bit outputs consisting of sum and carry
  input a, b				      // input bits
  );
  
  assign sum = a ^ b;		// sum = a xor b
  assign carryOut = a & b;	// carry =  a and b
endmodule // halfAdder