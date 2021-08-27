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
      $monitor ($time, "\na=%d b=%d carryIn=%b\nsum=%b (%d) expected_sum=%b (%d)\ncarryOut=%b expected_carryOut=%b", a, b, carryIn, sum, sum, expected_sum, expected_sum, carryOut, expected_carryOut);
      #10 carryIn = 0; a = 64'd56000000000000; b = 64'd39000000000000; expected_sum = 64'd95000000000000; expected_carryOut = 0;
      #10 carryIn = 0; a = 64'd15300000000000; b = 64'd10200000000000; expected_sum = 64'd25500000000000; expected_carryOut = 0;
      #10 carryIn = 0; a = 64'd1; b = 64'd100000000000000; expected_sum = 64'd100000000000001; expected_carryOut = 0;
      #10 carryIn = 0; a = 64'd17900000000000; b = 64'd2300000000000; expected_sum = 64'd20200000000000; expected_carryOut = 0;
      #10 carryIn = 0; a = 64'd20000; b = 64'd30000; expected_sum = 64'd50000; expected_carryOut = 0;
      #10 carryIn = 0; a = 64'd41467295; b = 64'd4253500000; expected_sum = 64'd4294967295; expected_carryOut = 0;
      #10 carryIn = 0; a = 64'd4294967294; b = 64'd3; expected_sum = 64'd4294967297; expected_carryOut = 0;
      #10 carryIn = 0; a = 64'd18446744073709551615; b = 64'd1; expected_sum = 64'd0; expected_carryOut = 1;
      #10 $finish;
	end
endmodule // rippleCarryAdder_64bit_tb