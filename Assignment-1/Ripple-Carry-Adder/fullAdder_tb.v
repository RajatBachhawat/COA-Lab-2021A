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

// Full adder testbench module
module fullAdder_tb;
  wire sum, carryOut;
  reg a, b, carryIn;
  reg expected_sum, expected_carryOut;
  
  fullAdder fa(.sum(sum), .carryOut(carryOut), .a(a), .b(b), .carryIn(carryIn));
  
  initial
    begin
      $monitor ($time, "a=%b b=%b carryIn=%b sum=%b expected_sum=%b carryOut=%b expected_carryOut=%b", a, b, carryIn, sum, expected_sum, carryOut, expected_carryOut);
      #10 carryIn = 0; a = 0; b = 0; expected_sum = 0; expected_carryOut = 0;
      #10 carryIn = 0; a = 0; b = 1; expected_sum = 1; expected_carryOut = 0;
      #10 carryIn = 0; a = 1; b = 0; expected_sum = 1; expected_carryOut = 0;
      #10 carryIn = 0; a = 1; b = 1; expected_sum = 0; expected_carryOut = 1;
      #10 carryIn = 1; a = 0; b = 0; expected_sum = 1; expected_carryOut = 0;
      #10 carryIn = 1; a = 0; b = 1; expected_sum = 0; expected_carryOut = 1;
      #10 carryIn = 1; a = 1; b = 0; expected_sum = 0; expected_carryOut = 1;
      #10 carryIn = 1; a = 1; b = 1; expected_sum = 1; expected_carryOut = 1;
      #10 $finish;
	end
endmodule // fullAdder_tb