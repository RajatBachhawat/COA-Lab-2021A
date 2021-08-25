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

// Ripple carry adder (8-bit) testbench module
module rippleCarryAdder_8bit_tb;
  wire[7:0] sum;
  wire carryOut;
  reg[7:0] a, b;
  reg carryIn;
  reg[7:0] expected_sum;
  reg expected_carryOut;
  
  rippleCarryAdder_8bit rca(.sum(sum), .carryOut(carryOut), .a(a), .b(b), .carryIn(carryIn));
  
  initial
    begin
      $monitor ($time, "a=%d b=%d carryIn=%b sum=%b (%d) expected_sum=%b (%d) carryOut=%b expected_carryOut=%b", a, b, carryIn, sum, sum, expected_sum, expected_sum, carryOut, expected_carryOut);
      #10 carryIn = 0; a = 56; b = 39; expected_sum = 95; expected_carryOut = 0;
      #10 carryIn = 0; a = 153; b = 102; expected_sum = 255; expected_carryOut = 0;
      #10 carryIn = 0; a = 1; b = 100; expected_sum = 101; expected_carryOut = 0;
      #10 carryIn = 0; a = 179; b = 23; expected_sum = 202; expected_carryOut = 0;
      #10 carryIn = 0; a = 20; b = 30; expected_sum = 50; expected_carryOut = 0;
      #10 carryIn = 0; a = 1; b = 10; expected_sum = 11; expected_carryOut = 0;
      #10 carryIn = 0; a = 254; b = 3; expected_sum = 1; expected_carryOut = 1;
      #10 carryIn = 0; a = 255; b = 1; expected_sum = 0; expected_carryOut = 1;
      #10 $finish;
	end
endmodule // rippleCarryAdder_8bit_tb