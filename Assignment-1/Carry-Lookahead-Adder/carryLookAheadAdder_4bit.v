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

// 4-bit CLA, outputs : sum, carry
module carryLookAheadAdder_4bit(
  input [3:0] a,	  // input 4 bit integers are a and b
  input [3:0] b,	
  input carryIn,	  // input carry
  output [3:0] sum,	// 4 bit output sum
  output carryOut	  // final carryOut bit
  );
  
  wire [4:0] carry;	            // carry[1..4]: output carry for each bit
  wire [3:0] G, P;	            // G and P are the Generate and Propagate terms

  /*
  Logic/Explanation

  P[0..3] = Propagate signals
  G[0..3] = Generate signals
  carry[1..4] = Generated carry bits
  
  P[i] = A[i] ^ B[i], for 0<=i<=3
  G[i] = A[i] & B[i], for 0<=i<=3

  carry[0] = input carry
  carry[i+1] = G[i] | (P[i] & carry[i]), for 0<=i<=3
  
  More specifically, on expanding:
  
  carry[1] = G[0] | (P[0] & carry[0])
  carry[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & carry[0])
  carry[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & carry[0])
  carry[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & carry[0])
  
  sum[i] = P[i] ^ carry[i], for 0<=i<=3
  
  */

  assign G = a & b;             // Create the Generate (G) Terms:  G_i = A_i AND B_i
  assign P = a ^ b;             // Create the Propagate (P) Terms: P_i = A_i XOR B_i
  
  assign carry[0] = carryIn;    // Setting initial carry to input carry value
  
  assign carry[1] = G[0] | (P[0] & carry[0]);
  assign carry[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & carry[0]);
  assign carry[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & carry[0]);
  assign carry[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & carry[0]);

  assign carryOut = carry[4];	  // final carryOut is stored in carry[4]

  assign sum = P ^ carry[3:0];	// obtaining the sum using carry bits and propagate signals
endmodule // carryLookAheadAdder_4bit