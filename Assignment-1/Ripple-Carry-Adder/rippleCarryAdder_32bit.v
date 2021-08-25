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

// Ripple carry adder (32-bit) implementation (using two 16-bit RCA)
module rippleCarryAdder_32bit (
  output[31:0] sum, // 32 bit output sum
  output carryOut,	// most significant carry bit
  input[31:0] a,	// 32 bit input a
  input[31:0] b,	// 32 bit input b
  input carryIn	// carryIn
  );

  wire carry;		// wire to store the intermediate carry 
  
  /* 
  Logic
  We use two 16-bit RCAs to make a 32-bit RCA.
  Rightmost 16 input bits and input carry are passed on to RCA #1.
  The carry generated from RCA #1 is passed on to RCA #2 along with the leftmost 16 input bits.
  */
  
  rippleCarryAdder_16bit add0 (sum[15:0], carry, a[15:0], b[15:0], carryIn);        // 0 to 15th bits of the inputs added, carry generated for next 16 bits
  rippleCarryAdder_16bit add1 (sum[31:16], carryOut, a[31:16], b[31:16], carry);    // carry generated previosuly passed as input carry,  16th to 31st bits of the inputs added. Final otuput carry generated.

endmodule // rippleCarryAdder_32bit