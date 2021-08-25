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

// Ripple carry adder (16-bit) implementation (using two 8-bit RCA)
module rippleCarryAdder_16bit (
  output[15:0] sum,	// 16 bit output sum
  output carryOut,	// most significant carry bit
  input[15:0] a,	// 16 bit input a
  input[15:0] b,	// 16 bit input b
  input carryIn	// carryIn
  );

  wire carry;		// wire to store the intermediate carry 
  
  /* 
  Logic
  We use two 8-bit RCAs to make a 16-bit RCA.
  Rightmost 8 input bits and input carry are passed on to RCA #1.
  The carry generated from RCA #1 is passed on to RCA #2 along with the leftmost 8 input bits.
  */

  rippleCarryAdder_8bit add0 (sum[7:0], carry, a[7:0], b[7:0], carryIn);        // 0 to 7th bits of the inputs added, carry generated for next 8 bits
  rippleCarryAdder_8bit add1 (sum[15:8], carryOut, a[15:8], b[15:8], carry);	// carry generated previosuly passed as input carry,  8th to 15th bits of the inputs added. Final otuput carry generated.
endmodule // rippleCarryAdder_16bit