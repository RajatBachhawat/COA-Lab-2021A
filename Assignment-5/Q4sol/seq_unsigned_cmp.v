/*
 * Assignment	  : 5
 * Problem No.	  : 4
 * Semester		  : Autumn 2021 
 * Group 		  : 46
 * Name1 		  : Neha Dalmia
 * RollNumber1 	  : 19CS30055
 * Name2 		  : Rajat Bachhawat
 * RollNumber2 	  : 19CS10073
 */

`timescale 1ns / 1ps

/*Sequential Unsigned Comparator FSM (Moore implementation)*/

module seq_unsigned_cmp(
    input CLK, RST, OP, A, B,
    output reg L, E, G
    );

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;   // State encodings
    /*
    S0: A = B for the bits read so far (Default State)
    S1: A < B (Stay in the same state once entered)
    S2: A > B (Stay in the same state once entered)
    */
    reg [1:0] PS, NS;                   // PS: Present State, NS: Next State
    
    // sequential logic of Moore Machine
    always @(posedge CLK or posedge RST) begin
        if(RST) begin
            PS <= S0;                   // Async reset, resets to the default state
        end
        else begin
            PS <= NS;                   // Go to the next state on clock +ve edge
        end
    end
    
    // combinational logic for Next State
    always @(PS or A or B) begin
        NS = S0;                        // default state assignment to avoid latch
        case(PS)
            S0: begin                   // if all bits read so far have been equal
                if(A == B) begin
                    NS = S0;            // if curr bit of A == curr bit of B, we stay in A
                end
                else begin
                    if(A < B) begin
                        NS = S1;        // if curr bit of A < curr bit of B, we go to S1
                    end
                    if(A > B) begin
                        NS = S2;        // if curr bit of A > curr bit of B, we go to S2
                    end
                end
            end
            S1: begin                   // if already found bit of A < bit of B, stay in S1 forever
                NS = S1;
            end
            S2: begin                   // if already found bit of A > bit of B, stay in S2 forever
                NS = S2;
            end
        endcase
    end

    // combinational logic for Output
    always @(OP or PS) begin
        L = 0;                          // default state assignments to avoid latch
        E = 0;
        G = 0;
        if(OP) begin                    // if input control (OP) becomes logic-1
            case(PS)
                S0: begin               // if in S0, meaning A == B -> {L,E,G} = {0,1,0}
                    L = 0;
                    E = 1;
                    G = 0;
                end
                S1: begin               // if in S1, meaning A < B -> {L,E,G} = {1,0,0}
                    L = 1;
                    E = 0;
                    G = 0;
                end
                S2: begin               // if in S2, meaning A > B -> {L,E,G} = {0,0,1}
                    L = 0;
                    E = 0;
                    G = 1;
                end
            endcase
        end
    end

endmodule // seq_unsigned_cmp

/*2-1 MUX*/

module mux21(
    input D0, D1, S,                    // inputs
    output Y                            // output
    );

    wire w0, w1, S_BAR;                 // internal nets

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

/*32-bit Parallel Load Shift Register*/

module shiftReg_32bit(
    input [31:0] A, reset,				// 32-bit input and reset
	input select, CLK,					// *usual meanings*
	output O 					        // Current MSB of the input
    );

	wire [30:0] M, Q;				    // M represents wire going from MUX to D-FF & Q is output of D-FF
   
    dff d0(CLK, A[0], reset[0], Q[0]);  // DFF for the LSB

    generate
        genvar i;
        for(i = 1; i <= 30; i = i + 1) begin: gen_mux_dff   // Cascading the DFFs bits 1 to 30
            mux21 mx(A[i], Q[i-1], select, M[i-1]);    
	        dff di(CLK, M[i-1], reset[i], Q[i]);
        end
    endgenerate

    mux21 mx(A[31], Q[30], select, M[30]);    
    dff di(CLK, M[30], reset[31], O);   // DFF for the MSB

endmodule // shiftReg_32bit