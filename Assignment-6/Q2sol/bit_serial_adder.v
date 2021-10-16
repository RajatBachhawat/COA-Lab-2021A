/*
 * Assignment     : 6
 * Problem No.    : 2
 * Semester       : Autumn 2021 
 * Group          : 46
 * Name1          : Neha Dalmia
 * RollNumber1    : 19CS30055
 * Name2          : Rajat Bachhawat
 * RollNumber2    : 19CS10073
 */

`timescale 1ns / 1ps

/*Half-adder*/
module half_adder(
  output sum, carryOut, 	// single bit outputs consisting of sum and carry
  input a, b				// input bits
  );
  
  assign sum = a ^ b;		// sum = a xor b
  assign carryOut = a & b;	// carry =  a and b
endmodule // half_adder

/*Full-adder*/
module full_adder(
  output sum, carryOut,	    // single bit outputs consisting of sum and carry
  input a, b, carryIn       // input bits
  );
  
  wire s1, c1, c2;

  half_adder ha1(.sum(s1), .carryOut(c1), .a(a), .b(b));	
  half_adder ha2(.sum(sum), .carryOut(c2), .a(s1), .b(carryIn));
  assign carryOut = c1 | c2;  // sum and carryOut wires  contain the sum and carry
endmodule // full_adder

/*2-1 MUX*/
module mux21(
    input D0, D1, S,                    // inputs
    output reg Y                        // output
    );

    always @(*) begin
        if(S) begin
            Y <= D1;
        end
        else begin
            Y <= D0;
        end
    end

endmodule // mux21

/*D Flip-Flop, +ve edge triggered, with async reset*/
module dff( 
    input CLK, D, RST,                  //inputs
    output reg Q                        //outputs
    );

    always @(posedge CLK) begin
        if(RST) begin
            Q <= 1'b0;                  // Sync reset, resets Q to 0
        end
        else begin
            Q <= D;                     // Q <- D  on clock +ve edge
        end
    end
    
endmodule // dff

/*8-bit Parallel Load Shift Register*/
module shiftReg_parallel_load_8bit(
    input [7:0] A,				        // 8-bit input
	input select, RST, CLK,			    // Control signals
	output O 					        // Current MSB of the input
    );

	wire [7:1] Q;				        // M represents wire going from MUX to D-FF & Q is output of D-FF
    wire [6:0] M;

    dff d0(CLK, A[7], RST, Q[7]);       // DFF for the LSB

    generate
        genvar i;
        for(i = 6; i >= 1; i = i - 1) begin: gen_mux_dff   // Cascading the DFFs bits 1 to 6
            mux21 mx(A[i], Q[i+1], select, M[i]);    
	        dff di(CLK, M[i], RST, Q[i]);
        end
    endgenerate

    mux21 mx(A[0], Q[1], select, M[0]);    
    dff di(CLK, M[0], RST, O);   // DFF for the LSB
endmodule // shiftReg_parallel_load_8bit

/*8-bit Shift Register*/
module shiftReg_8bit(
    input a,				            // 1-bit input
	input RST, CLK,			            // *usual meanings*
	output [7:0] O 					    // Output bits (Qs of the DFFs)
    );
   
    dff d0(CLK, a, RST, O[7]);          // DFF for the LSB

    generate
        genvar i;
        for(i = 6; i >= 0; i = i - 1) begin: gen_mux_dff   // Cascading the DFFs bits 0 to 6
	        dff di(CLK, O[i+1], RST, O[i]);
        end
    endgenerate

endmodule // shiftReg_8bit

/*8-bit Bit-Serial Adder*/
module bit_serial_adder(
    input [7:0] A, B,
    input CLK, RST, select,
    output [7:0] S,
    output LSB_A, LSB_B
    );
    wire D, Q, sum;
    // Appropriate module instantiations as per circuit
    shiftReg_parallel_load_8bit inputA(
        .A(A),
        .select(select),
        .RST(RST),
        .CLK(CLK),
        .O(LSB_A)
    );
    shiftReg_parallel_load_8bit inputB(
        .A(B),
        .select(select),
        .RST(RST),
        .CLK(CLK),
        .O(LSB_B)
    );
    dff carryFF(
        .CLK(CLK),
        .RST(RST),
        .D(D),
        .Q(Q)
    );
    full_adder fa(
        .a(LSB_A),
        .b(LSB_B),
        .carryIn(Q),
        .sum(sum),
        .carryOut(D)
    );
    shiftReg_8bit outputS(
        .a(sum),
        .RST(RST),
        .CLK(CLK),
        .O(S)
    );
endmodule // bit_serial_adder