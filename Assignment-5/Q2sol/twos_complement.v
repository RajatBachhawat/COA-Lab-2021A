/*
 * Assignment	  : 5
 * Problem No.	  : 2
 * Semester		  : Autumn 2021 
 * Group 		  : 46
 * Name1 		  : Neha Dalmia
 * RollNumber1 	  : 19CS30055
 * Name2 		  : Rajat Bachhawat
 * RollNumber2 	  : 19CS10073
 */

`timescale 1ns / 1ps

module twos_complement(input I, 
	input CLK,
	input RST,
	output reg O
	);
	/*
    S0: State where we output the same value as input (Default State)
    S1: State where we output reverse value as input
    */
	parameter S0 = 1'b0, S1 = 1'b1; 	// State encodings, FSM has 2 states
	reg PS; 							// PS: Present State
					
	always @(posedge CLK or posedge RST) begin
		if (RST) begin
			PS <= S0;					// Async reset, resets to the default state
		end
		else begin  					// On clock +ve edge
			case (PS)
				S0: begin				// S0: The state where we output the same value as input
					if (I) begin		// if we are in state 0 and input is 1 then output is 1 and we move to state 1
						O <= 1'b1;
						PS <= S1;
					end
					else begin			// if we are in state 0 and input is 0 then output is 0 and we remain in state 0
						O <= 1'b0;
						PS <= S0;
					end
				end
				S1: begin				// S1: The state where we output reverse value as input
					if (I) begin		// if we are in state 1 and input is 1 then output is 0 and we remain in state 1
						O <= 1'b0;
						PS <= S1;
					end
					else begin			// if we are in state 1 and input is 0 then output is 1 and we remain in state 1
						O <= 1'b1;
						PS <= S1;
					end
				end
			endcase
		end
	end
endmodule