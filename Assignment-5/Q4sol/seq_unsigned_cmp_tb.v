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

module seq_unsigned_cmp_tb;
    reg CLK, RST, OP;
    reg [31:0] A, B, RST_A, RST_B;
    reg SELECT;
    wire L, E, G;
    wire MSB_A, MSB_B;

    seq_unsigned_cmp cmp(
        .CLK(CLK),
        .RST(RST),
        .OP(OP),
        .A(MSB_A),
        .B(MSB_B),
        .L(L),
        .E(E),
        .G(G)
    ); // instantiate seq_unsigned_cmp module
    
    shiftReg_32bit I_A(
        .A(A),
        .select(SELECT),
        .reset(RST_A),
        .CLK(CLK),
        .O(MSB_A)
    ); // instantiate shiftReg_32bit module for input A

    shiftReg_32bit I_B(
        .A(B),
        .select(SELECT),
        .reset(RST_B),
        .CLK(CLK),
        .O(MSB_B)
    ); // instantiate shiftReg_32bit module for input B

    initial begin
        $dumpfile("seq_unsigned_cmp_tb.vcd");
      	$dumpvars(0,seq_unsigned_cmp_tb);
        CLK = 1'b1; // Start clock
        
        #2
        $display("FIRST SET OF INPUTS");
        RST = 1'b1; // Reset the FSM
        OP = 1'b0; // input control of FSM <- logic-0
        // -2147483648 = 32'b11111111111111111111111111111111
        RST_A = -2147483648; RST_B = -2147483648; // Reset the two 32-bit shift registers
        A = 1001; B = 1000; // Two 32-bit unsigned integers as input
        SELECT = 1'b0; // Load the two integers in the two 32-bit shift registers
        #2 SELECT = 1'b1; RST_A = 32'b0; RST_B = 32'b0; RST = 32'b0; // 
        #64 OP = 1'b1; // input control of FSM <- logic-1 after 32 cycles

        #2
        $display("SECOND SET OF INPUTS");
        RST = 1'b1;
        OP = 1'b0;
        RST_A = -2147483648; RST_B = -2147483648;
        A = 1000; B = 1000;
        SELECT = 1'b0;
        #2 SELECT = 1'b1; RST_A = 32'b0; RST_B = 32'b0; RST = 32'b0;
        #64 OP = 1'b1;

        #2
        $display("THIRD SET OF INPUTS");
        RST = 1'b1;
        OP = 1'b0;
        RST_A = -2147483648; RST_B = -2147483648;
        A = 999; B = 1000;
        SELECT = 1'b0;
        #2 SELECT = 1'b1; RST_A = 32'b0; RST_B = 32'b0; RST = 32'b0;
        #64 OP = 1'b1; $finish;
    end
    always #1 CLK = ~CLK;
    always #68 $monitor($time, "ns -> L = %b, E = %b, G = %b A = %d B = %d", L, E, G, A, B);

endmodule