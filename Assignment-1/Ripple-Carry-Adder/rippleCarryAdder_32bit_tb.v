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

// Ripple carry adder (32-bit) testbench module
module rippleCarryAdder_32bit_tb;
  wire[31:0] sum;
  wire carryOut;
  reg[31:0] a, b;
  reg carryIn;
  reg[31:0] expected_sum;
  reg expected_carryOut;
  
  rippleCarryAdder_32bit rca(.sum(sum), .carryOut(carryOut), .a(a), .b(b), .carryIn(carryIn));
  
  initial
    begin
      $monitor ($time, "\na=%d b=%d carryIn=%b\nsum=%b (%d) expected_sum=%b (%d)\ncarryOut=%b expected_carryOut=%b", a, b, carryIn, sum, sum, expected_sum, expected_sum, carryOut, expected_carryOut);
      #10 carryIn = 0; a = 560000000; b = 390000000; expected_sum = 950000000; expected_carryOut = 0;
      #10 carryIn = 0; a = 153000000; b = 102000000; expected_sum = 255000000; expected_carryOut = 0;
      #10 carryIn = 0; a = 1; b = 1000000000; expected_sum = 1000000001; expected_carryOut = 0;
      #10 carryIn = 0; a = 179000000; b = 23000000; expected_sum = 202000000; expected_carryOut = 0;
      #10 carryIn = 0; a = 20000; b = 30000; expected_sum = 50000; expected_carryOut = 0;
      #10 carryIn = 0; a = 41467295; b = 4253500000; expected_sum = 4294967295; expected_carryOut = 0;
      #10 carryIn = 0; a = 4294967294; b = 3; expected_sum = 1; expected_carryOut = 1;
      #10 carryIn = 0; a = 4294967295; b = 1; expected_sum = 0; expected_carryOut = 1;
      #10 $finish;
	end
endmodule // rippleCarryAdder_32bit_tb