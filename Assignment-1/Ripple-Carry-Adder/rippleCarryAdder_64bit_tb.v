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

// Ripple carry adder (64-bit) testbench module
module rippleCarryAdder_64bit_tb;
  wire[63:0] sum;
  wire carryOut;
  reg[63:0] a, b;
  reg carryIn;
  reg[63:0] expected_sum;
  reg expected_carryOut;
  
  rippleCarryAdder_64bit rca(.sum(sum), .carryOut(carryOut), .a(a), .b(b), .carryIn(carryIn));
  
  initial
    begin
      $monitor ($time, "a=%d b=%d carrIn=%b sum=%b (%d) expected_sum=%b (%d) carryOut=%b expected_carryOut=%b", a, b, carryIn, sum, sum, expected_sum, expected_sum, carryOut, expected_carryOut);
      #10 carryIn = 0; a = 56000000000000; b = 39000000000000; expected_sum = 95000000000000; expected_carryOut = 0;
      #10 carryIn = 0; a = 15300000000000; b = 10200000000000; expected_sum = 25500000000000; expected_carryOut = 0;
      #10 carryIn = 0; a = 1; b = 100000000000000; expected_sum = 100000000000001; expected_carryOut = 0;
      #10 carryIn = 0; a = 17900000000000; b = 2300000000000; expected_sum = 20200000000000; expected_carryOut = 0;
      #10 carryIn = 0; a = 20000; b = 30000; expected_sum = 50000; expected_carryOut = 0;
      #10 carryIn = 0; a = 41467295; b = 4253500000; expected_sum = 4294967295; expected_carryOut = 0;
      #10 carryIn = 0; a = 4294967294; b = 3; expected_sum = 4294967297; expected_carryOut = 0;
      #10 carryIn = 0; a = 18446744073709551615; b = 1; expected_sum = 0; expected_carryOut = 1;
      #10 $finish;
	end
endmodule // rippleCarryAdder_64bit_tb