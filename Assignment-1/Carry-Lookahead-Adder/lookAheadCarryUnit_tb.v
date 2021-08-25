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
module lookAheadCarryUnit_tb;
  wire [4:1] carry;
  wire P_block, G_block;
  reg carryIn;
  reg [3:0] P,G;
  reg [4:1] expected_carry;
  reg expected_P_block, expected_G_block;

  lookAheadCarryUnit lcu(.carryIn(carryIn), .P(P), .G(G), .carry(carry), .P_block(P_block), .G_block(G_block));

  initial
    begin
      $monitor ($time, "carryIn=%b P[3..0]=%b G[3..0]=%b carry[4..1]=%b expected_carry[4..1]=%b\nP_block=%b expected_P_block=%b G_block=%b expected_G_block=%b", carryIn, P, G, carry, expected_carry, P_block, expected_P_block, G_block, expected_G_block);      #10 carryIn = 0; P = 4'b0000; G = 4'b0000; expected_carry = 4'b0000; expected_P_block = 0; expected_G_block = 0;
      #10 carryIn = 0; P = 4'b0010; G = 4'b1001; expected_carry = 4'b1011; expected_P_block = 0; expected_G_block = 1;
      #10 carryIn = 0; P = 4'b1111; G = 4'b0000; expected_carry = 4'b0000; expected_P_block = 1; expected_G_block = 0;
      #10 carryIn = 0; P = 4'b0100; G = 4'b1011; expected_carry = 4'b1111; expected_P_block = 0; expected_G_block = 1;
      #10 carryIn = 1; P = 4'b0000; G = 4'b0000; expected_carry = 4'b0000; expected_P_block = 0; expected_G_block = 0;
      #10 carryIn = 1; P = 4'b0010; G = 4'b1001; expected_carry = 4'b1011; expected_P_block = 0; expected_G_block = 1;
      #10 carryIn = 1; P = 4'b1111; G = 4'b0000; expected_carry = 4'b1111; expected_P_block = 1; expected_G_block = 0;
      #10 carryIn = 1; P = 4'b0100; G = 4'b1011; expected_carry = 4'b1111; expected_P_block = 0; expected_G_block = 1;
      #10 $finish;
	end
endmodule // lookAheadCarryUnit_tb