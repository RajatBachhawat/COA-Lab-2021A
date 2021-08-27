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

// Carry Lookahead Adder (4-bit) augmented to output block P and G - testbench module
module carryLookAheadAdder_4bit_aug_tb;
  wire [3:0] sum;
  wire P_block, G_block;
  wire carryOut;
  reg [3:0] a, b;
  reg carryIn;
  reg [3:0] expected_sum;
  reg expected_P_block, expected_G_block;
  reg expected_carryOut;
  
  carryLookAheadAdder_4bit_aug cla(.a(a), .b(b), .carryIn(carryIn), .sum(sum), .P_block(P_block), .G_block(G_block));
  assign carryOut = G_block | (P_block & carryIn);

  initial
    begin
      $monitor ($time, "a=%d b=%d carryIn=%b sum=%b (%d) expected_sum=%b (%d) carryOut=%b expected_carryOut=%b\nP_block=%b expected_P_block=%b G_block=%b expected_G_block=%b", a, b, carryIn, sum, sum, expected_sum, expected_sum, carryOut, expected_carryOut, P_block, expected_P_block, G_block, expected_G_block);
      #10 a = 4'b0000; b = 4'b0001; carryIn = 0; expected_sum = 4'b0001; expected_carryOut = 0; expected_P_block = 0; expected_G_block = 0;
      #10 a = 4'b1111; b = 4'b1111; carryIn = 0; expected_sum = 4'b1110; expected_carryOut = 1; expected_P_block = 0; expected_G_block = 1;
      #10 a = 4'b0110; b = 4'b1001; carryIn = 0; expected_sum = 4'b1111; expected_carryOut = 0; expected_P_block = 1; expected_G_block = 0;
      #10 a = 4'b1111; b = 4'b0000; carryIn = 0; expected_sum = 4'b1111; expected_carryOut = 0; expected_P_block = 1; expected_G_block = 0;
      #10 a = 4'b0001; b = 4'b0001; carryIn = 0; expected_sum = 4'b0010; expected_carryOut = 0; expected_P_block = 0; expected_G_block = 0;
      #10 a = 4'b1111; b = 4'b0111; carryIn = 0; expected_sum = 4'b0110; expected_carryOut = 1; expected_P_block = 0; expected_G_block = 1;
      #10 a = 4'b1001; b = 4'b1010; carryIn = 0; expected_sum = 4'b0011; expected_carryOut = 1; expected_P_block = 0; expected_G_block = 1;
      #10 a = 4'b1100; b = 4'b0001; carryIn = 0; expected_sum = 4'b1101; expected_carryOut = 0; expected_P_block = 0; expected_G_block = 0;
      #10 $finish;
	end
endmodule // carryLookAheadAdder_4bit_aug_tb