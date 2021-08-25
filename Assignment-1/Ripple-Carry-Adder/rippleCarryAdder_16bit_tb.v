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

// Ripple carry adder (16-bit) testbench module
module rippleCarryAdder_16bit_tb;
  wire[15:0] sum;
  wire carryOut;
  reg[15:0] a, b;
  reg carryIn;
  reg[15:0] expected_sum;
  reg expected_carryOut;
  
  rippleCarryAdder_16bit rca(.sum(sum), .carryOut(carryOut), .a(a), .b(b), .carryIn(carryIn));
  
  initial
    begin
      $monitor ($time, "a=%d b=%d carryIn=%b sum=%b (%d) expected_sum=%b (%d) carryOut=%b expected_carryOut=%b", a, b, carryIn, sum, sum, expected_sum, expected_sum, carryOut, expected_carryOut);
      #10 carryIn = 0; a = 56000; b = 3900; expected_sum = 59900; expected_carryOut = 0;
      #10 carryIn = 0; a = 15300; b = 10200; expected_sum = 25500; expected_carryOut = 0;
      #10 carryIn = 0; a = 1; b = 10000; expected_sum = 10001; expected_carryOut = 0;
      #10 carryIn = 0; a = 17900; b = 2300; expected_sum = 20200; expected_carryOut = 0;
      #10 carryIn = 0; a = 1; b = 10; expected_sum = 11; expected_carryOut = 0;
      #10 carryIn = 0; a = 22000; b = 43535; expected_sum = 65535; expected_carryOut = 0;
      #10 carryIn = 0; a = 65534; b = 3; expected_sum = 1; expected_carryOut = 1;
      #10 carryIn = 0; a = 65535; b = 1; expected_sum = 0; expected_carryOut = 1;
      #10 $finish;
	end
endmodule // rippleCarryAdder_16bit_tb