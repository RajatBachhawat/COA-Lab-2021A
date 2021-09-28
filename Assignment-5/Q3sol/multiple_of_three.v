/*
 * Assignment	  : 5
 * Problem No.	  : 3
 * Semester		  : Autumn 2021 
 * Group 		  : 46
 * Name1 		  : Neha Dalmia
 * RollNumber1 	  : 19CS30055
 * Name2 		  : Rajat Bachhawat
 * RollNumber2 	  : 19CS10073
 */

`timescale 1ns / 1ps

module multiple_of_three_detector(
	input I, 
	input CLK,
	input RST,
	output reg O
	);
	/*
    S0: Modulo 3 value of bits read so far is 0 (Default State)
    S1: Modulo 3 value of bits read so far is 1
    S2: Modulo 3 value of bits read so far is 2
    */
	parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10; 	// State encodings, FSM has 3 states
	reg[1:0] PS; 								    // PS: Present State
	always @(posedge CLK or posedge RST) begin
		if (RST) begin
			PS <= S0;					// Async reset, resets to the default state
		end
		else begin						// On clock +ve edge
			case (PS)
				S0: begin				// S0 : if modulo so far is 0
					if (I) begin		// if in S0 with I = 1: go to S1 and O = 0
						O <= 1'b0;
						PS <= S1;
					end
					else begin			// if in S0 with I = 0: go to S0 and O = 1
						O <= 1'b1;
						PS <= S0;
					end
				end
				S1:	begin				// S1 : if modulo so far is 1
					if (I) begin		// if in S1 with I = 1: go to S0 and O = 1
						O <= 1'b1;
						PS <= S0;
					end
					else begin			// if in S1 with I = 0: go to S2 and O = 0
						O <= 1'b0;
						PS <= S2;
					end
				end
                S2:	begin				// S2 : if modulo so far is 2 
					if (I) begin		// if in S2 with I = 1: go to S2 and O = 0
						O <= 1'b0;
						PS <= S2;
					end
					else begin			// if in S2 with I = 0: go to S1 and O = 0
						O <= 1'b0;
						PS <= S1;
					end
				end
			endcase
		end
	end
endmodule