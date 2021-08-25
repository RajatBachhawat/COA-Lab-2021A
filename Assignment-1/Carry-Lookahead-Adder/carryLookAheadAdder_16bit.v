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

// 16-bit CLA with LCU
module carryLookAheadAdder_16bit(
  input [15:0] a,      // 16 bit input integer a
  input [15:0] b,      // 16 bit input integer b
  input carryIn,       // input carry
  output [15:0] sum,   // 16 bit output sum
  output carryOut,     // output carry
  output P_block,      // block Propagate for entire 16 block 
  output G_block	     // block Generate for entire 16 block 
  );
  
  wire [3:0] P_block_4bit, G_block_4bit;	// Block propagates and generates for each 4-bit CLA block
  wire [4:0] carry;				                // carry[1..4] : output carry of each 4-bit CLA block
  
  /*
  Logic/Explanation

  carry[0] = input carry

  Input integers are divided into four blocks of 4-bits.
  Four 4-bit CLAs are used to calculate the block Generates and Propagates of these 4-bit blocks.
  Sum is calculated using the 4-bit CLA logic.

  To optimise the carry generation, these block G's and P's are passed through a
  second layer of lookahead which helps in calculating the input carries for each 4-bit CLA
  quicker (quicker than simply rippling in the carries from the previous block), hence leading
  to lesser delay.
  */

  assign carry[0] = carryIn;	// initial carry set to carryIn
  
  lookAheadCarryUnit LCU(			// Creating the LCU to precompute the carries for every 4-bit block
    .carryIn(carryIn),				// and generate P_block and G_block for the entire block of 16 bits
    .P(P_block_4bit),
    .G(G_block_4bit),
    .carry(carry[4:1]),
    .P_block(P_block),
    .G_block(G_block)
  );
  
  genvar i;
  generate
    for (i = 3; i <= 15; i = i + 4)
      begin
        // Cascading four 4-bit CLAs that return block propagate and generate for their block
        carryLookAheadAdder_4bit_aug CLA(
          .a(a[i:i-3]),		              // 4-bit section
          .b(b[i:i-3]), 
          .carryIn(carry[i/4]),	        // precomputed carry for the block obtained from LCU 
          .sum(sum[i:i-3]),             // sum for this block
          .P_block(P_block_4bit[i/4]),  // block Propagate for this block
          .G_block(G_block_4bit[i/4])   // block Generate for this block
        );
      end
  endgenerate
  
  assign carryOut = carry[4];	// final carryOut is stored in carry[4]
endmodule // carryLookAheadAdder_16bit