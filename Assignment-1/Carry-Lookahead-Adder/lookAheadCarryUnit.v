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

// Lookahead Carry Unit
module lookAheadCarryUnit(
  input carryIn,	    // input carry
  input [3:0] P,	    // block Propagates for each 4-bit block
  input [3:0] G,	    // block Generates for each 4-bit block
  output [4:1] carry,	// carry[1..4] : output carry of each 4-bit CLA block
  output P_block,	    // block Propagate for entire 16-bit block
  output G_block	    // block Generate for entire 16-bit block
  );

  wire carry0;
  /*
	Logic/Explanation
    
	carry[0] = input carry
	carry[i] = G[i-1] | (P[i-1] & carry[i-1]), 1 <= i <= 4
	
	More specifically, on expanding:

	carry[1] = G[0] | (P[0] & carry[0]) = G[0] | (P[0] & c_in)
	carry[2] = G[1] | (P[1] & carry[1]) = G[1] | (P[1] & G[0]) | (P[1] & P[0] & c_in)
	carry[3] = G[2] | (P[2] & carry[2]) = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & c_in)
	
	Also, we can calculate P and G for the entire 4-bit block like so (independent of carry[0]):

	P_block = P[3] & P[2] & P[1] & P[0]
	G_block = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0])
    
  Now,
  carry[4] can be computed, using: G_block | (P_block & carry[0])
  */
  assign carry0 = carryIn;	// set carry0 to carryIn

  assign carry[1] = G[0] | (P[0] & carry0);
  assign carry[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & carry0);
  assign carry[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & carry0);

  assign P_block = P[3] & P[2] & P[1] & P[0];
  assign G_block = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);

  assign carry[4] = G_block | (P_block & carry0);
endmodule // lookAheadCarryUnit