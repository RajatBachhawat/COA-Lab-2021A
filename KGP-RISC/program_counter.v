/*
 * Assignment     : KGPRISC
 * Semester       : Autumn 2021 
 * Group          : 46
 * Name1          : Neha Dalmia
 * RollNumber1    : 19CS30055
 * Name2          : Rajat Bachhawat
 * RollNumber2    : 19CS10073
 */

`timescale 1ns / 1ps

module program_counter(
    input clk,
    input reset,
	 input [31:0] PC,
    output reg [31:0] PCN
    );
		
	always @(posedge clk or posedge reset)
	begin
		if(reset == 1)
			begin
				PCN <= 32'd0; // reset condition -> 2nd Address on the Instruction Fetch Memory
			end
		else
			begin
				PCN <= PC; // set next value of pc
			end
	end
endmodule 