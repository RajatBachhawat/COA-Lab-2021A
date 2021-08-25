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

// Half adder testbench module
module halfAdder_tb;
  wire sum, carryOut;
  reg a, b;
  reg expected_sum, expected_carryOut;
  
  halfAdder ha(.sum(sum), .carryOut(carryOut), .a(a), .b(b));
  
  initial
    begin
      $monitor ($time, "a=%b b=%b sum=%b expected_sum=%b carryOut=%b expected_carryOut=%b", a, b, sum, expected_sum, carryOut, expected_carryOut);
      #10 a = 0; b = 0; expected_sum = 0; expected_carryOut = 0;
      #10 a = 0; b = 1; expected_sum = 1; expected_carryOut = 0;
      #10 a = 1; b = 0; expected_sum = 1; expected_carryOut = 0;
      #10 a = 1; b = 1; expected_sum = 0; expected_carryOut = 1;
      #10 $finish;
	end
endmodule // halfAdder_tb