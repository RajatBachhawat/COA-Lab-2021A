/*
 * Assignment     : 6
 * Problem No.    : 3
 * Semester       : Autumn 2021 
 * Group          : 46
 * Name1          : Neha Dalmia
 * RollNumber1    : 19CS30055
 * Name2          : Rajat Bachhawat
 * RollNumber2    : 19CS10073
 */

`timescale 1ns / 1ps

module seq_booth_multiplier_tb;
    reg signed [7:0] A, B;
    reg CLK, RST, LOAD;
    wire signed [15:0] prod;
    wire [7:0] L,R,M;

    seq_booth_multiplier sbm(
        .A(A),
        .B(B),
        .CLK(CLK),
        .RST(RST),
        .LOAD(LOAD),
        .prod(prod)
    ); // module instantiation
    initial begin
        $dumpfile("seq_booth_multiplier_tb.vcd");
      	$dumpvars(0,seq_booth_multiplier_tb);
        CLK = 1'b1;
        RST = 1'b1;
        #2
        $display("First Example");
        RST = 1'b0;
        LOAD = 1'b1;    // Load the inputs A and B
        A = 11; B = 13;
        #2
        RST = 1'b0;
        LOAD = 1'b0;    // Start multiplication
        #14
        #2
        $display("Second Example");
        RST = 1'b0;
        LOAD = 1'b1;
        A = -21; B = -10;
        #2
        RST = 1'b0;
        LOAD = 1'b0;
        #14
        #2
        $display("Third Example");
        RST = 1'b0;
        LOAD = 1'b1;
        A = 15; B = -40;
        #2
        RST = 1'b0;
        LOAD = 1'b0;
    end
    initial begin
        #54 $finish;    // Per example: 1 cycle for LOAD + 8 cycles to calculate product = 9 cycles
                        // Total = 3 * 9 = 27 cycles -> 54ns 
    end
    always #1 CLK = ~CLK;
    always #2 $monitor($time, "ns -> A = %d, B = %d, Product = %d, L = %b, R = %b", A, B, prod, prod[15:8], prod[7:0]);
endmodule