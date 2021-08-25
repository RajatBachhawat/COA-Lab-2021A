/*
 * Assignment	  : 1
 * Problem No.	: 2
 * Semester		  : Autumn 2021 
 * Group 		    : 46
 * Name1 		    : Neha Dalmia
 * RollNumber1 	: 19CS30055
 * Name2 		    : Rajat Bachhawat
 * RollNumber2 	: 19CS10073
 */

`timescale 1ns / 1ps

// 16-bit CLA without LCU (carry bits rippled in)
module carryLookAheadAdder_16bit_ripple(
  input [15:0] a,       // 16 bit input integer a
  input [15:0] b,       // 16 bit input integer b
  input carryIn,        // input carry
  output [15:0] sum,    // 16 bit output sum
  output carryOut       // output carry
  );
  
  wire [4:0] carry;	    // carry[1..4] : output carry of each 4-bit CLA block
  
  /*
  Logic/Explanation

  carry[0] = input carry

  Input integers are divided into four blocks of 4-bits.
  Four 4-bit CLAs are used to calculate the carryOuts of these 4-bit blocks.
  Sum is calculated using the 4-bit CLA logic.

  Then the carryIn for each block is rippled from the previous block's carryOut.
  
  Also, it can be denoted by:
  carry[i+1] = G__block_4bit[i] | (P_block_4bit[i] & carry[i]), for 0<=i<=3
  
  */

  assign carry[0] = carryIn;  // first carry in input carry
  
  genvar i;
  generate
    for (i = 3; i <= 15; i = i + 4) 
      begin
        // Cascading four 4-bit CLAs to add 4-bit blocks individually and ripple the carry
        carryLookAheadAdder_4bit CLA(
          .a(a[i:i-3]),           // 4-bit section
          .b(b[i:i-3]), 
          .carryIn(carry[i/4]), 	// input carry for this block, obtained by rippling from previous block
          .sum(sum[i:i-3]),		    // sum for this block
          .carryOut(carry[i/4+1])	// rippling in carry to the next block 
        );
      end
  endgenerate
  
  assign carryOut = carry[4];	// final carryOut is stored in carry[4]
endmodule // carryLookAheadAdder_16bit_ripple