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

module ALU(
    input [31:0] inp1,
    input [31:0] inp2,
	input [3:0] operation,
	input clk,
	input reset,
    output reg [31:0] out,
    output reg carryFlag,
    output reg zeroFlag,
    output reg signFlag
    );

reg c31,c32;
// Sequential block for remembering carry
always @(posedge clk or posedge reset) begin
	 if(reset) begin
		  carryFlag <= 1'b0;
	 end
	 else if(operation == 4'b0000) begin
		  carryFlag <= c32;
	 end
end

// Combinational block for ALU Logic
always @(*)
	begin
		c31 = 1'b0;
		c32 = 1'b0;
		case(operation) 
			4'b0000: 	begin		//add
						{c31,out[30:0]}=inp1[30:0]+inp2[30:0];
						{c32,out[31]}=inp1[31]+inp2[31]+c31;
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end
			4'b0001:	begin 	//and
						out=inp1&inp2;
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end 
			4'b0010:	begin 	//xor
						out=inp1^inp2;
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end 
			4'b0011:	begin		//comp
						out=(~inp2)+1; // 2's complement of rt
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end 
			4'b0100:	begin		//shll
						out=inp1<<inp2;
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end
			4'b0101:	begin		//shrl
						out=inp1>>inp2;
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end
			4'b0110:	begin		//shra
						out=inp1>>>inp2;
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end
			4'b0111:    begin   // less than 0
						out = inp1;
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end  
			4'b1000:    begin   // equal to 0
						out = inp1;
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end  
			default:                
						begin
						out = 32'b0;
						zeroFlag = 1'b0;
						signFlag = 1'b0;
						end
		endcase
    end			
endmodule