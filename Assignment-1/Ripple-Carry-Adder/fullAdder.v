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

// Full adder module implementation (using half adders)
module fullAdder(
  output sum, carryOut,	// single bit outputs consisting of sum and carry
  input a, b, carryIn  // input bits
  );
  
  wire s1, c1, c2;

  /*
  Logic
  
  sum = (a^b)^c
  carry = a&b + c&(a^b)
  s1 = a^b (first half adder)
  c1 = a&b (first half adder)
  c2 = carryIn&(a^b) (second half adder)
  sum = (a^b)^c = s1 xor carryIn (second half adder)
  carry = c1 or c2
  */
  
  halfAdder ha1(.sum(s1), .carryOut(c1), .a(a), .b(b));	
  halfAdder ha2(.sum(sum), .carryOut(c2), .a(s1), .b(carryIn));
  assign carryOut = c1 | c2;  // sum and carryOut wires  contain the sum and carry
endmodule // fullAdder