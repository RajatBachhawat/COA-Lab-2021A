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

/*
 * Assignment     : 7
 * Semester       : Autumn 2021 
 * Group          : 46
 * Name1          : Neha Dalmia
 * RollNumber1    : 19CS30055
 * Name2          : Rajat Bachhawat
 * RollNumber2    : 19CS10073
 */

module registerfile(
	input reset,
	input clk,
    input reg_write,			// control line for register writing
    input [4:0] wrAddr,		// Address to write in 
    input [31:0] wrData,    // Write Data
    input [4:0] rdAddrA,    //Read Address 1
    output reg [31:0] rdDataA,  // Read Data 1
    input [4:0] rdAddrB,    //Read Address 2
    output reg [31:0] rdDataB // Read Data 2
  	);

	reg [31:0] registerBank[31:0]; 
    integer i;
				
   always @(*) 
		begin
			if(rdAddrB>=32) 
				rdDataB=32'hxxxxxxxx;       //Not possible, kept just to prevent latch
			else
				rdDataB=registerBank[rdAddrB];          //Read Data
				
			if(rdAddrA>=32) 
				rdDataA=32'hxxxxxxxx;
			else
				rdDataA=registerBank[rdAddrA];          //Read Data
			
		end
		
   always @(posedge clk or posedge reset)            //Write Operation
		begin
		  if (reset) begin
			   for(i=0;i<32;i=i+1) begin	
					registerBank[i] <= 32'b0;
				end
		  end
        else if (reg_write) 
				registerBank[wrAddr] <= wrData;
		end
		
endmodule