/*
 * Assignment	  : 5
 * Problem No.	  : 1
 * Semester		  : Autumn 2021 
 * Group 		  : 46
 * Name1 		  : Neha Dalmia
 * RollNumber1 	  : 19CS30055
 * Name2 		  : Rajat Bachhawat
 * RollNumber2 	  : 19CS10073
 */

`timescale 1ns / 1ps

/*2-1 MUX*/

module mux21(D0, D1, S, Y);
    
    input D0, D1, S;                    //inputs
    output Y;                           //output
    wire w0, w1, S_BAR;                 //internal nets

    not U0 (S_BAR,S);
    and U1 (w1,D1,S);
    and U2 (w0,D0,S_BAR);
    or U3 (Y,w0,w1);                    // Y = S.D1 + ~S.D0

endmodule // mux21

/*D Flip-Flop, +ve edge triggered, with async reset*/

module dff( 
    input CLK, D, RST,                  //inputs
    output reg Q                        //outputs
    );

    always @(posedge CLK or posedge RST) begin
        if(RST) begin
            Q <= 1'b0;                  // Async reset, resets Q to 0
        end
        else begin
            Q <= D;                     // Q <- D  on clock +ve edge
        end
    end
    
endmodule // dff

/*4-bit Linear Feedback Shift Register*/

module lfsr(A,select,reset,CLK,O);
	
    input [3:0] A,reset;				// 4 bit input and reset
	input select,CLK;					// *usual meanings*
	wire [3:0] Win;						// Connection wires  into the dffs w1int-w4int
	wire W;						        // First wire (W1)
	output [3:0] O;					    // output of D-FFs, W2-W5
	// 4 series of D-FF 
   
    // Setting up the structure shown in the diagram (cascading the dff's accordingly)

	mux21 mx(A[0],O[1],select,Win[3]);    
	dff d0(CLK,Win[3],reset[0],O[0]);   // DFF for 0th bit

	mux21 M1(A[1],O[2],select,Win[2]);
	dff d1(CLK,Win[2],reset[1],O[1]);   // DFF for 1st bit

	mux21 M2(A[2],O[3],select,Win[1]);
	dff d2(CLK,Win[1],reset[2],O[2]);   // DFF for 2nd bit

	mux21 M3(A[3],W,select,Win[0]);
	dff d3(CLK,Win[0],reset[3],O[3]);   // DFF for 3rd bit

	xor(W,O[0],O[1]);

endmodule // lfsr