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

// Augmented 4-bit CLA to make 16-bit CLA without rippling in carry bits, outputs : P, G, sum
module carryLookAheadAdder_4bit_aug(
  input [3:0] a,	  //input 4 bit integers are a and b
  input [3:0] b,
  input carryIn,	  // input carry
  output [3:0] sum,	// 4 bit output sum
  output G_block,   // block generate signal
  output P_block    // block propagate signal
  );
  wire [3:0] carry;	            // carry[1..3]: output carry for leftmost 3 bits
  wire [3:0] G, P;	            // G and P are the Generate and Propagate terms
  
  /*
  Logic/Explanation

  P[0..3] = Propagate signals
  G[0..3] = Generate signals
  carry[1..3] = Generated carry bits
  P_block = Block Propagate signal for the entire 4-bit block
  G_block = Block Generate signal for the entire 4-bit block

  P[i] = A[i] ^ B[i], for 0<=i<=3
  G[i] = A[i] & B[i], for 0<=i<=3
  
  carry[0] = input carry
  carry[i+1] = G[i] | (P[i] & carry[i]), for 0<=i<=3
  
  More specifically, on expanding:
  
  carry[1] = G[0] | (P[0] & carry[0])
  carry[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & carry[0])
  carry[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & carry[0])
  
  Also, we can calculate P and G for the entire 4-bit block like so (independent of carry[0]):

  P_block = P[3] & P[2] & P[1] & P[0]
  G_block = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0])
  
  sum[i] = P[i] ^ carry[i], for 0<=i<=3
  */

  assign G = a & b;           // Generate signals (G[0..3])
  assign P = a ^ b;	          // Propagate signals (P[0..3])
  
  assign carry[0] = carryIn;  // Setting initial carry to input carry value
  
  assign carry[1] = G[0] | (P[0] & carry[0]);
  assign carry[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & carry[0]);
  assign carry[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & carry[0]);
  // carry[4] not computed, can be derived using the equation: G_block | (P_block & carry[0])

  assign P_block = P[0] & P[1] & P[2] & P[3]; 	 					                                    // Block Propagate (P_block)
  assign G_block = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]); // Block Generate (G_block)
  
  assign sum = P ^ carry[3:0];	// obtaining the sum using carry bits and propagate signals
endmodule // carryLookAheadAdder_4bit_aug