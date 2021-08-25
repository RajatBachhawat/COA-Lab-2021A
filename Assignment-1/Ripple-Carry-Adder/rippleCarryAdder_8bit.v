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

// Ripple carry adder (8-bit) implementation (using cascaded full adders)
module rippleCarryAdder_8bit (
  output[7:0] sum,		// 8 bit output sum
  output carryOut,		// most significant carry bit
  input[7:0] a,			// 8 bit input a
  input[7:0] b,			// 8 bit unout b
  input carryIn		// carryIn
  );
  
  wire carry[6:0];		// wire to store intermediate carries

  /* 
  Logic

  We use the full adder to add 3 bits at every position, the input bits from a and b
  and the third bit is the carry over from the previous addition.
  For the 0th bit, input carry is 0. This gives us the sum for the corresponding bit position
  and a carry which is rippled on to the bit position to the left.
  */
  
  fullAdder add0(sum[0],carry[0],a[0], b[0], carryIn);		// carryIn is 0 initially
  fullAdder add1(sum[1],carry[1],a[1], b[1], carry[0]);		// carry[0] computed in the 1st addition passed as the input carry in the second additon
  fullAdder add2(sum[2],carry[2],a[2], b[2], carry[1]);		// same process repeats
  fullAdder add3(sum[3],carry[3],a[3], b[3], carry[2]);		
  fullAdder add4(sum[4],carry[4],a[4], b[4], carry[3]);
  fullAdder add5(sum[5],carry[5],a[5], b[5], carry[4]);
  fullAdder add6(sum[6],carry[6],a[6], b[6], carry[5]);
  fullAdder add7(sum[7],carryOut,a[7], b[7], carry[6]);
endmodule // rippleCarryAdder_8bit