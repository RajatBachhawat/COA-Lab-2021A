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

// Ripple carry adder (64-bit) implementation (using two 32-bit RCA)
module rippleCarryAdder_64bit (
  output[63:0] sum,	// 64 bit output sum
  output carryOut,	// most significant carry bit
  input[63:0] a,	// 64 bit input a
  input[63:0] b,	// 64 bit input b
  input carryIn	// carryIn
  );
  
  wire carry;		// wire to store the intermediate carry 
  	
  /* 
  Logic
  We use two 32-bit RCAs to make a 64-bit RCA.
  Rightmost 32 input bits and input carry are passed on to RCA #1.
  The carry generated from RCA #1 is passed on to RCA #2 along with the leftmost 32 input bits.
  */
  
  rippleCarryAdder_32bit add0 (sum[31:0], carry, a[31:0], b[31:0], carryIn);        //0 to 31st bits of the inputs added, carry generated for next 32 bits
  rippleCarryAdder_32bit add1 (sum[63:32], carryOut, a[63:32], b[63:32], carry);    // carry generated previosuly passed as input carry,  32nd to 63rd bits of the inputs added. Final otuput carry generated.
  
endmodule // rippleCarryAdder_64bit